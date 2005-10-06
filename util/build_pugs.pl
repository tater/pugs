#!/usr/bin/perl -w

use strict;
use warnings;
use File::Copy;

our %BuildPrefs;
use Config;
use PugsBuild::Config;

help() if ($ARGV[0] || '--help') =~ /^--?h(?:elp)?/i;
build(classify_options(@ARGV));
exit 0;

sub help {
    print <<".";
$0 - build a pugs executable

This script calls GHC to build a pugs exectuable, optionally inlining
precompiled modules in a second pass.

Primary configuration settings are read from the file `config.yml` in
the build root. You may override these settings using the PUGS_BUILD_OPTS
environment variable.

Current settings:
.
    print PugsBuild::Config->pretty_print;

    exit 0;
}

sub build {
    my($opts) = @_;
    my $thispugs = { @{ $opts->{GEN_PRELUDE} } }->{'--pugs'} or # laugh at me now.
        die "$0: no pugs passed in _+GEN_PRELUDE segment";
    
    print "Build configuration:\n" . PugsBuild::Config->pretty_print;

    # if Prelude.pm wasn't changed, don't bother to recompile Run.hs.
    if (PugsBuild::Config->lookup('precompile_prelude')) {
        my $pm = "src/perl6/Prelude.pm";
        my $ppc_hs = "src/Pugs/PreludePC.hs";
        my $ppc_null = "src/Pugs/PreludePC.hs-null";
        if (-e $ppc_hs and -s $ppc_hs > -s $ppc_null and -M $ppc_hs < -M $pm) {
            return run_build(1, @{$opts->{GHC}});
        }
    }

    run($^X, qw<util/gen_prelude.pl -v --touch --null --output src/Pugs/PreludePC.hs>);
    run_build(0, @{$opts->{GHC}});

    if (PugsBuild::Config->lookup('precompile_prelude')) {
        run($^X, qw<util/gen_prelude.pl -v -i src/perl6/Prelude.pm>,
                (map { ('-i' => $_) } @{ PugsBuild::Config->lookup('precompile_modules') }),
                '-p', $thispugs, qw<--touch --output src/Pugs/PreludePC.hs>);
        return run_build(1, @{$opts->{GHC}});
    }
}

sub run_build {
    my ($is_final, $setup, @args) = @_;

    write_buildinfo($is_final, @args);
    system $setup, 'configure';
    system $setup, 'build', '--verbose';

    if ($is_final--) {
        write_buildinfo($is_final, @args);
        system $setup, 'configure';
        system $setup, 'build', '--verbose';
    }

    copy "dist/build/Pugs/pugs$Config{_exe}", "pugs$Config{_exe}";
}

sub write_buildinfo { 
    my ($is_final, @args) = @_;
    my $build_lib = ($is_final ? 'True' : 'False');
    my $build_exe = ($is_final ? 'False' : 'True');

    open INFO, "> Pugs.buildinfo" or die $!;
    print INFO << ".";
ghc-options: @args
buildable: $build_lib

executable: pugs
ghc-options: @args
buildable: $build_exe
.
    close INFO;
}

sub classify_options {
    my($kind, %opts);
    for (@_) {
        # we can't use +SEGMENT and -SEGMENT since that interferes with GHC.
        $kind = $1,  next if /^_\+(.*)/;        # _+SEGMENT start
        undef $kind, next if $_ eq "_-$kind";   # _-SEGMENT end
        
        s/^__(.*)__$/PugsBuild::Config->lookup($1)/e;
        
        die "don't know where this option belongs: $_" unless $kind;
        push @{ $opts{$kind} }, $_;
    }
    \%opts;
}

sub run {
    print ((join " ", @_) . "\n");
    system @_ and die (sprintf "system: [%s]: $!", join " ", @_);
}
