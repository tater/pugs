#!/usr/bin/perl -w

use strict;
use warnings;

our %BuildPrefs;
use PugsBuild::Config;

build(classify_options(@ARGV)) unless caller;
exit 0;

sub build {
    my($opts) = @_;
    my $thispugs = { @{ $opts->{GEN_PRELUDE} } }->{'--pugs'} or # laugh at me now.
        die "$0: no pugs passed in +GEN_PRELUDE segment";
    
    print "Build configuration:\n" . PugsBuild::Config->pretty_print;

    run($^X, qw<util/gen_prelude.pl -v --touch --null --output src/Pugs/PreludePC.hs>);
    run(@{ $opts->{GHC} });

    if (PugsBuild::Config->lookup('precompile_prelude')) {
        run($^X, qw<util/gen_prelude.pl -v -i src/perl6/Prelude.pm>,
                (map { ('-i' => $_) } @{ PugsBuild::Config->lookup('precompile_modules') }),
                '-p', $thispugs, qw<--touch --output src/Pugs/PreludePC.hs>);
        run(@{ $opts->{GHC} });
    }
}

sub classify_options {
    my($kind, %opts);
    for (@_) {
        $kind = $1,  next if /^_\+(.*)/;
        undef $kind, next if $_ eq "_-$kind";
        
        s/^__(.*)__$/PugsBuild::Config->lookup($1)/e;
        
        die "don't know where this option belongs: $_" unless $kind;
        push @{ $opts{$kind} }, $_;
    }
    \%opts;
}

sub run {
    system @_ and die (sprintf "system: [%s]: $!", join " ", @_);
}
