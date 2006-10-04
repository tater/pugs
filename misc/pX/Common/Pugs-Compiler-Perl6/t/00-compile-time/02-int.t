use Test::More tests => 1;
use Data::Dumper;

use Pugs::Emitter::Perl6::Perl5::Value;
use Pugs::Emitter::Perl6::Perl5::Native;
use Pugs::Emitter::Perl6::Perl5::Expression;

sub node {
    eval 'use Pugs::Emitter::Perl6::Perl5::' . $_[0];
    ( 'Pugs::Emitter::Perl6::Perl5::' . $_[0] )->new( { name => $_[1] } );
}

sub emit {
    return node( 'int', $_[0]{int} )
        if ( exists $_[0]{int} );
    return emit( $_[0]{exp1} )->_43_( emit( $_[0]{exp1} ) )
        if (  exists $_[0]{fixity}
           && $_[0]{fixity} eq 'infix'
           && $_[0]{op1} eq '+' );
    die 'not implemented: ', Dumper( $_[0] );
}

# 1+1
my $ast = {
      'exp1' => {
        'int' => '1',
        'pos' => 1
      },
      'exp2' => {
        'int' => '1',
        'pos' => 3
      },
      'fixity' => 'infix',
      'op1' => '+'
};

my $i = emit( $ast );
is( "" . $i, "2", "AST evaluates correctly" );



