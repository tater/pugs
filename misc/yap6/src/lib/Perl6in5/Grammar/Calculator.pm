package Perl6in5::Grammar::Calculator;

use warnings;
use strict;

# isa Perl6in5::Grammar someday (to inherit some of the common features below)

use Perl6in5::Compiler::Stream ':all';
use Perl6in5::Compiler::Parser ':all';
use Perl6in5::Compiler::Lexer ':all';


sub make_parser {
    my $input = shift;

    my $handle_lex_whitespace = sub { "" };
    
    my $lexer = iterator_to_stream(make_lexer($input,

    # These are the patterns to do the initial lexing.  Each's first item is
    # a category used by the "l()" (lookfor) function, which is a technique of
    # defining literals in the grammar rules.  These are the defaults from
    # MJD's "Higher Order Perl", but they'll be modified greatly.

    [ 'TERMINATOR'      ,qr/;\n*|\n+/         ,                            ],
    [ 'INT'             ,qr/\d+/              ,                            ],
    [ 'SAY'             ,qr/\bsay\b/          ,                            ],
    [ 'IDENTIFIER'      ,qr|\$[A-Za-z_]\w*|    ,                            ],
    [ 'OP'              ,qr#\*\*|[-=+*/()]#   ,                            ],
    [ 'WHITESPACE'      ,qr/\s+/              ,$handle_lex_whitespace      ],

    )); 

    # This is our current excuse for a symbol table for our (only) variable scope.
    my %VAR;

    # the below through the handlers will be autogenerated (by require-time eval)
    # by Perl6in5::Grammar

    # These are locally accessible "shortcuts" to the actual parser coderefs.
    my ($base, $expression, $factor, $program, $statement, $term);
    my ($Base, $Expression, $Factor, $Program, $Statement, $Term);

    $Base               = parser { $base            ->(@_) };
    $Expression         = parser { $expression      ->(@_) };
    $Factor             = parser { $factor          ->(@_) };
    $Program            = parser { $program         ->(@_) };
    $Statement          = parser { $statement       ->(@_) };
    $Term               = parser { $term            ->(@_) };

    # these hash keys are coderef (addresses)
    $N{ $End_of_Input      } = 'EOI';
    $N{ $nothing           } = '(nothing)';
    $N{ $Expression        } = 'Expression';
    $N{ $Term              } = 'Term';
    $N{ $Factor            } = 'Factor';
    $N{ $Statement         } = 'Statement';
    $N{ $Base              } = 'Base';
    $N{ $Program           } = 'Program';

    # Currently these handlers do a synchronous evaluation of
    # simple variable assignment, variable printing, and
    # Please Excuse My Dear Aunt Sally arithmetic,
    # comprising a one-step interpreter. Soon, instead they
    # will pass around and generate an enhanced AST.
    # On an evaluation run of a given "visible-code instruction set",
    # they can be defined to implement the runtime, given a decent
    # object/metaobject model.  Of course, they may return coderefs
    # to subroutines in other packages, or another coderef
    # generator.

    my $handle_say_statement =
    sub { say $_[1] };

    my $handle_assignment_statement =
    sub { $VAR{ $_[0]} = $_[2] };

    my $handle_infix_addition =
    sub { my $term = $_[1];
          sub { $_[0] + $term }};

    my $handle_infix_subtraction =
    sub { my $term = $_[1];
          sub { $_[0] - $term }}; 

    my $handle_infix_multiplication =
    sub { my $factor = $_[1];
          sub { $_[0] * $factor }};
          
    my $handle_infix_division =
    sub { my $factor = $_[1];
          warn "failed to divide by 0!" unless $factor;
          $factor ||= 1; #silly, I know; this is only a toy interpreter.
          sub {$_[0] / $factor}};
          
    my $handle_infix_exponentiation_factor = sub { $_[1] };

    my $handle_empty_nothing = sub { 1 };

    my $handle_infix_exponentiation_operation = sub { $_[0] ** $_[1] };

    my $handle_variable_lookup = sub { $VAR{$_[0]} };

    my $handle_base_value = sub { $_[1] };

    my $handle_cascade =
    sub { my ($first, $rest) = @_;
          for my $f (@$rest) { 
              $first = $f->($first); 
          } $first};

    # the items (parsing rules) below also represent atomic compilation units....

    $program = star($Statement) - $End_of_Input;

    $statement = l('SAY') - $Expression - l('TERMINATOR')
                 >> $handle_say_statement
               | l('IDENTIFIER') - l('OP', '=') - $Expression - l('TERMINATOR')
                 >> $handle_assignment_statement;

    $expression = $Term - star(l('OP', '+') - $Term >>  $handle_infix_addition
                             | l('OP', '-') - $Term >> $handle_infix_subtraction) 
                  >> $handle_cascade;

    $term = $Factor - star(l('OP', '*') - $Factor >> $handle_infix_multiplication
                         | l('OP', '/') - $Factor >> $handle_infix_division)
            >> $handle_cascade;
              
    $factor = $Base - ( l('OP', '**') - $Factor >> $handle_infix_exponentiation_factor
                      | $nothing >> $handle_empty_nothing )
              >> $handle_infix_exponentiation_operation;

    $base = l('INT')
          | (l('IDENTIFIER') > $handle_variable_lookup)
          | l('OP', '(') - $Expression - l('OP', ')')
          >> $handle_base_value;

    sub { $program->($lexer) }
}

1;