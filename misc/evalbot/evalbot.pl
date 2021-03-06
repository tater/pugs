#!/usr/bin/perl

=head1 NAME

evalbot.pl - a pluggable p5 evalbot

=head1 SYNOPSIS

perl -Ilib evalbot.pl <configfile>

=head1 DESCRIPTION

evalbot.pl is a perl5 based evalbot, intended for the different Perl 6
implementations.

Take a look at the example config file that is hopefully is the same 
directory.

=head1 AUTHOR

Written by Moritz Lenz, many good contributions came from the #perl6 folks, 
notably diakopter, Mitchell Charity (putter), Adrian Kreher (Auzon), rhr, 
and all those that I forgot.

Copyright (C) 2007 by Moritz Lenz and the pugs authors.

This file may be distributed under the same terms as perl or pugs itself.

=cut

use warnings;
use strict;

use Bot::BasicBot;
use Config::File;
use Carp qw(confess);
use Data::Dumper;
use FindBin;
use lib 'lib';
use EvalbotExecuter;

$ENV{LD_LIBRARY_PATH} = '/home/evalenv/pugs/v6/smop/build/';

package Evalbot;
{
    use base 'Bot::BasicBot';
    use File::Temp qw(tempfile);
    use Carp qw(confess);
    use Scalar::Util qw(reftype);
    my $prefix  = '';
    my $postfix = ':';

    our %impls = (
            mildew  => {
                chdir       => 'umask 002; ../../v6/mildew',
                cmd_line    => 'perl mildew --exec --file %program >> %out 2>&1',
            },
            elf => {
                chdir       => '../elf',
                cmd_line    => './elf_f %program >> %out 2>&1',
                revision    => \&get_revision,
            },
            kp6 => {
                chdir       => '../../v6/v6-KindaPerl6/',
                cmd_line    => "$^X script/kp6 --secure < \%program >\%out 2>&1",
                revision    => \&get_revision,
                filter      => \&filter_kp6,
            },
            rakudo => {
                chdir       => '../../../parrot/',
                cmd_line    => './parrot languages/perl6/perl6.pbc %program >> %out 2>&1',
                revision    => \&get_rakudo_revision,
                filter      => \&filter_pct,
            },
            nqp   => {
                chdir       => '../../../parrot/',
                cmd_line    => './parrot compilers/nqp/nqp.pbc %program >> %out 2>&1',
                filter      => \&filter_pct,
            },
            pugs => {
                cmd_line    => 'PUGS_SAFEMODE=true /home/evalenv/pugs/pugs %program >> %out 2>&1',
            },
            smop => {
                cmd_line    => 'PUGS_SAFEMODE=true /home/evalenv/pugs/pugs -Bm0ld %program >> %out 2>&1',
            },
            std  => {
                chdir       => '../../src/perl6',
                cmd_line    => $^X . ' tryfile %program >>%out 2>&1',
                revision    => \&get_revision,
            },
            highlight  => {
                chdir       => '../../src/perl6',
                cmd_line    => $^X . ' STD_syntax_highlight %program >>%out 2>&1',
                revision    => \&get_revision,
            }
    );

    my $evalbot_version = get_revision();

    my $regex = $prefix . '(' . join('|',  keys %impls) . ")$postfix";

    sub help {
        return "Usage: <$regex \$perl6_program>";
    }
#    warn "Regex: ", $regex, "\n";

    sub said {
        my $self = shift;
        my $e = shift;
        my $message = $e->{body};
        my $address = $e->{address} // '';
        if ($message =~ m/\A$regex\s+(.*)\z/){
            my ($eval_name, $str) = ($1, $2);
            my $e = $impls{$eval_name};
            return "Please use /msg $self->{nick} $str" 
                if($eval_name eq 'highlight');
            warn "Eval: $str\n";
            my $result = EvalbotExecuter::run($str, $e, $eval_name);
            my $revision = '';
            if (reftype($e) eq 'HASH' && $e->{revision}){
                $revision = ' ' . $e->{revision}->();
            }
            return sprintf "%s%s: %s", $eval_name, $revision, $result;
        } elsif ( $message =~ m/\Aperl6:\s+(.+)\z/ ){
            my $str = $1;
            return "Program empty" unless length $str;
            warn "Perl6: $str\n";
            my %results;
            for my $eval_name qw(elf pugs rakudo){
                my $e = $impls{$eval_name};
                my $tmp_res = EvalbotExecuter::run($str, $e, $eval_name);
                my $revision = '';
                if (reftype($e) eq 'HASH' && $e->{revision}){
                    $revision = ' ' . $e->{revision}->();
                }
                push @{$results{$tmp_res}}, "$eval_name$revision";
            }
            my $result = '';
            while (my ($text, $names) = each %results){
                $result .= join(', ', @$names);
                $result .= sprintf(": %s\n", $text);
            }
            return $result;

        } elsif ( $message =~ m/\Aevalbot\s*control\s+(\w+)/) {
            my $command = $1;
            if ($command eq 'restart'){
                warn "Restarting $0 (by user request\n";
                # we do hope that evalbot is started in an endless loop ;-)
                exit;
            } elsif ($command eq 'version'){
                return "This is evalbot revision $evalbot_version";
            }

        } elsif ($message =~ m/\A(.+)\z/ && $address eq 'msg') {
            #a request like /msg evalbot perl6 code
            my ($eval_name, $str) = ('highlight', $1);
            my $e = $impls{$eval_name};
            warn "Highlight: $str\n";
            my $result = EvalbotExecuter::run($str, $e, $eval_name);
            my $revision = '';
            if (reftype($e) eq 'HASH' && $e->{revision}){
                $revision = ' ' . $e->{revision}->();
            }
            return sprintf "%s%s: %s", $eval_name, $revision, $result;           
        }
        return;
    }

    sub exec_yap6 {
        my ($program, $fh, $filename) = @_;
        chdir('../yap6/src')
            or confess("Can't chdir to yap6 base dir: $!");
        my ($tmp_fh, $name) = tempfile();
        if ($program =~ m/\|\|\|/){
            die "Disabled due to security concerns";
            # 11:28 < pmurias> yap6: >/dev/null;echo ../* |||;
            # 11:28 < p6eval> yap6: OUTPUT[../CHANGES ../COPYRIGHT  
            # etc.

            # if you want to allow different commands, please
            # either limit them to the current directory (if you think
            # you can do it safely), or better, introduce a whitelist of
            # allowed programs.
        }
        my ($gram,$inp) = split('\|\|\|',$program);
        my $is_custom = $inp?1:0;
        $inp ||= $gram;
        $gram = $is_custom?$gram:'STD_hand';
        print $tmp_fh $inp;
        close $tmp_fh;
        system "perl -Ilib bin/test $gram $name >> $filename 2>&1";
        unlink $name;
        chdir $FindBin::Bin;
        return;
    }

    sub get_revision {
        my $info = qx/svn info/;
        if ($info =~ m/^Revision:\s+(\d+)$/smx){
            return $1;
        } else {
            return "_unknown";
        }
    }

    sub get_rakudo_revision {
        my $file = '/home/evalenv/parrot/languages/perl6/rakudo_svn_revision';
        open my $f, '<', $file or die "Can't open file '$file': $!";
        my $res = <$f>;
        close $f;
        chomp $res;
        return $res;
    }

    sub filter_pct {
        my $str = shift;
        $str =~ s/called from Sub.*//ms;
        return $str;
    }

    sub filter_kp6 {
        my $str = shift;
        $str =~ s/KindaPerl6::Runtime.*//ms;
        return $str;
    }

    sub filter_std {
        my $str = shift;
        if($str =~ /PARSE FAILED/) {
            my @lines = grep {!/-+>/ && !/PARSE FAILED/} split /\n/, $str;
            return join '', @lines;
        } elsif($str =~ /Out of memory!/) {
            return 'Out of memory!';
        } elsif($str =~ /--- !!perl/) {
            return 'parse ok';
        } else {
            return $str;
        }
    }
}

package main;

my $config_file = shift @ARGV 
    or confess("Usage: $0 <config_file>");
my %conf = %{ Config::File::read_config_file($config_file) };

#warn Dumper(\%conf);

my $bot = Evalbot->new(
        server => $conf{server},
        port   => $conf{port} || 6667,
        channels  => [ map { "#$_" } split m/\s+/, $conf{channels} ],
        nick      => $conf{nick},
        alt_nicks => [ split m/\s+/, $conf{alt_nicks} ],
        username  => "evalbot",
        name      => "combined, experimental evalbot",
        charset   => "utf-8",
        );
$bot->run();

# vim: ts=4 sw=4 expandtab
