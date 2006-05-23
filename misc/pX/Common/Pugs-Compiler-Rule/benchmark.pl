# Perl 6 Rule benchmark
# - fglock
#

use strict;
use warnings;
use Data::Dumper;

use Benchmark;
use Pugs::Compiler::Rule;
use Pugs::Compiler::Token;
use Pugs::Compiler::Regex;
my $rpc_rule  = Pugs::Compiler::Rule->compile('[a|b](b)');
my $rpc_token = Pugs::Compiler::Token->compile('[a|b](b)' );
my $rpc_regex = Pugs::Compiler::Regex->compile('[a|b](b)' );
#print $rpc_token->perl5, "\n";

{
    print "P5 regex benchmark:\n";
    my $str = "abcdefg";
    my $match;
    Benchmark::cmpthese(500, {
        substr         => sub{ $match = (substr($str,3,1) eq 'd') for 1..4000},
        regex          => sub{ $match = ($str =~ /^.{3}d/os)      for 1..4000},
    });
}

{
    print "P6 Rule Benchmark:\n";
    my $str = "abcdefg";
    my $match;
    Benchmark::cmpthese(500, {
        P6_Rule_x1    => sub{ $match = $rpc_rule->match($str)  for 1..40},
        P6_Token_x1   => sub{ $match = $rpc_token->match($str) for 1..40},
        P6_Regex_x1   => sub{ $match = $rpc_regex->match($str) for 1..40},
        P5_regex_x100 => sub{ $match = ($str =~ /[a|b](b)/o)   for 1..4000},
    });
    #print "Str = $str\n";
}

