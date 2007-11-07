package main;

use lib ( '../v6-MiniPerl6/lib5', '.' );
use strict;

BEGIN {
    $::_V6_COMPILER_NAME    = 'MiniPerl6';
    $::_V6_COMPILER_VERSION = '0.003';
}

use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package Main;
use MiniPerl6::Grammar;
use Emitter;  # Groovy
use MiniPerl6::Grammar::Regex;
use MiniPerl6::Emitter::Token;

my $source = join('', <> );
my $pos = 0;

say( "// Do not edit this file - Generated by MiniPerl6" );

while ( $pos < length( $source ) ) {
    #say( "Source code:", $source );
    my $p = MiniPerl6::Grammar->comp_unit($source, $pos);
    #say( Main::perl( $$p ) );
    say( join( ";\n", (map { $_->emit() } ($$p) )));
    #say( $p->to, " -- ", length($source) );
    say( ";" );
    $pos = $p->to;
}

say "";