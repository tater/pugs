#!/usr/bin/perl

use warnings;
use strict;

#use Smart::Comments;
use Best 0.05 [ [qw/YAML::Syck YAML/], qw/Dump Load/ ];
use Getopt::Long;
use Test::TAP::HTMLMatrix;
use Test::TAP::Model::Visual;
use File::Spec;

GetOptions \our %Config, qw(inlinecss|e cssfile|c=s help|h);
$Config{cssfile} ||= Test::TAP::HTMLMatrix->css_file();
usage() if $Config{help};

my $yamlfile = shift || 'smoke.yml';

open(my $yamlfh, '<', $yamlfile) or die "Couldn't open $yamlfile for reading: $!";
binmode $yamlfh, ":utf8" or die "binmode: $!";
local $/=undef;

my $data = Load(<$yamlfh>);
## data keys: keys %$data
### build info: $data->{build_info}
my $timing = $data->{timing};
$timing->{duration} .=
    " (" . sprintf("%.2f min", $timing->{duration} / 60) . ')';
$timing->{start} .=
    " (" . localtime($timing->{start}) . ')';
$timing->{end} .= " (" . localtime($timing->{end}) . ')';
### timing: $data->{timing}

undef $yamlfh;

my $tap = My::Model->new_with_struct(delete $data->{meat});
my $v = Test::TAP::HTMLMatrix->new($tap, Dump($data));
$v->has_inline_css($Config{inlinecss});

my $fh;
if (my $out = shift) {
    open $fh, '>', $out or die $!;
}
else {
    $fh = \*STDOUT;
}
binmode $fh, ":utf8" or die "binmode: $!";
my $html = "$v";
# patch the resulting HTML for the "...\n...\t" stuff
$html =~ s{(?<=build_info:) \&quot;([^\n]*)\&quot;}
    { my $s = $1; $s =~ s/\\n/\n/g; $s =~ s/\\t/\t/g; "\n$s" }ems;
print $fh $html; close $fh;

sub usage {
  print <<"USAGE";
usage: $0 [OPTIONS] > output_file.html

Generates an HTML summary of a YAML test run. Options:

   --inlinecss, -e      inline css in HTML header (for broken webservers)
   --cssfile,  -c FILE  location of css. [default: $Config{cssfile}]

See also:
   util/yaml_harness.pl  - produce the data for this tool
   util/catalog_tests.pl - produce cross-linkable tests
   util/run-smoke.pl     - automate the smoke process

USAGE
  exit 0;
}

{
    package My::Model;
    use base qw/Test::TAP::Model::Visual/;
    sub file_class { "My::File" }

    package My::File;
    use base qw/Test::TAP::Model::File::Visual/;
    sub subtest_class { "My::Subtest" }
    sub link {
        my $self = shift;
        my $link = $self->SUPER::link;
        $link =~ s/\.t$/.html/;
        File::Spec->catdir("t_index",$link);
    }

    package My::Subtest;
    use base qw/Test::TAP::Model::Subtest::Visual/;
    sub link {
        my $self = shift;
        my $link = $self->SUPER::link;
        $link =~ s/\.t(?=#line|$)/.html/;
        File::Spec->catdir("t_index",$link);
    }
}

