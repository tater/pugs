# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Visitor::Emit::Perl5Regex;
sub new { shift; bless {@_}, "KindaPerl6::Visitor::Emit::Perl5Regex" }
use KindaPerl6::Visitor::Emit::Perl5;

sub visit {
    my $self   = shift;
    my $List__ = \@_;
    my $node;
    do { $node = $List__->[0]; [$node] };
    $node->emit_perl5();
}

package Token;
sub new { shift; bless {@_}, "Token" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $regex_source = $self->{regex}->emit_perl5();
    my $source       = (
        'do { '
            . (
            'use vars qw($_rule_'
                . (
                $self->{name}
                    . (
                    '); '
                        . (
                        '$_rule_'
                            . (
                            $self->{name}
                                . (
                                ' = qr'
                                    . (
                                    chr(0)
                                        . (
                                        '(?{ '
                                            . (
                                            'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                                                . (
                                                '$GLOBAL::_M2 = $GLOBAL::_M; '
                                                    . (
                                                    '})'
                                                        . (
                                                        $regex_source
                                                            . (
                                                            '(?{ '
                                                                . (
                                                                'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; '
                                                                    . (
                                                                    '$GLOBAL::_M2 = $GLOBAL::_M; '
                                                                        . (
                                                                        '})'
                                                                            . (
                                                                            chr(0)
                                                                                . (
                                                                                'x; '
                                                                                    . (
                                                                                    Main::newline()
                                                                                        . (
                                                                                        '::DISPATCH(::DISPATCH($::'
                                                                                            . (
                                                                                            $KindaPerl6::Visitor::Emit::Perl5::current_compunit
                                                                                                . (
                                                                                                ',"HOW"),'
                                                                                                    . (
                                                                                                    '"add_method", '
                                                                                                        . (
                                                                                                        '::DISPATCH( $::Str, "new", "'
                                                                                                            . (
                                                                                                            $self->{name}
                                                                                                                . (
                                                                                                                '" ), '
                                                                                                                    . (
                                                                                                                    '::DISPATCH( $::Method, "new", '
                                                                                                                        . (
                                                                                                                        '{ code => '
                                                                                                                            . (
                                                                                                                            'sub { '
                                                                                                                                . (
                                                                                                                                'local $GLOBAL::_Class = shift; '
                                                                                                                                    . (
                                                                                                                                    'undef $GLOBAL::_M2; '
                                                                                                                                        . (
                                                                                                                                        '( ref($_) ? ::DISPATCH( $_, "Str" )->{_value} : $_ ) =~ '
                                                                                                                                            . (
                                                                                                                                            '/$_rule_'
                                                                                                                                                . (
                                                                                                                                                $self->{name}
                                                                                                                                                    . (
                                                                                                                                                    '/; '
                                                                                                                                                        . (
                                                                                                                                                        'if ( $GLOBAL::_M2->[1] eq \'to\' ) { '
                                                                                                                                                            . (
                                                                                                                                                            'Match::from_global_data( $GLOBAL::_M2 ); '
                                                                                                                                                                . (
                                                                                                                                                                '$MATCH = $GLOBAL::MATCH = pop @Match::Matches; '
                                                                                                                                                                    . (
                                                                                                                                                                    '} '
                                                                                                                                                                        . (
                                                                                                                                                                        'else { '
                                                                                                                                                                            . (
                                                                                                                                                                            '$MATCH = $GLOBAL::MATCH = Match->new(); '
                                                                                                                                                                                . (
                                                                                                                                                                                '} '
                                                                                                                                                                                    . (
                                                                                                                                                                                    '@Match::Matches = (); '
                                                                                                                                                                                        . (
                                                                                                                                                                                        'return $MATCH; '
                                                                                                                                                                                            . (
                                                                                                                                                                                            '} '
                                                                                                                                                                                                . (
                                                                                                                                                                                                '} ' . ( '), ' . ( '); ' . ( '} ' . Main::newline() ) ) )
                                                                                                                                                                                                )
                                                                                                                                                                                            )
                                                                                                                                                                                        )
                                                                                                                                                                                    )
                                                                                                                                                                                )
                                                                                                                                                                            )
                                                                                                                                                                        )
                                                                                                                                                                    )
                                                                                                                                                                )
                                                                                                                                                            )
                                                                                                                                                        )
                                                                                                                                                    )
                                                                                                                                                )
                                                                                                                                            )
                                                                                                                                        )
                                                                                                                                    )
                                                                                                                                )
                                                                                                                            )
                                                                                                                        )
                                                                                                                    )
                                                                                                                )
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
    );
    return ($source);
}

package P5Token;
sub new { shift; bless {@_}, "P5Token" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $self->{regex};
}

package Rule::Quantifier;
sub new { shift; bless {@_}, "Rule::Quantifier" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( $self->{term}->emit_perl5() . ( $self->{quant} . $self->{greedy} ) );
}

package Rule::Or;
sub new { shift; bless {@_}, "Rule::Or" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '(?:' . ( Main::join( [ map { $_->emit_perl5() } @{ $self->{or} } ], '|' ) . ')' ) );
}

package Rule::Concat;
sub new { shift; bless {@_}, "Rule::Concat" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '(?:' . ( Main::join( [ map { $_->emit_perl5() } @{ $self->{concat} } ], '' ) . ')' ) );
}

package Rule::Var;
sub new { shift; bless {@_}, "Rule::Var" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $table = { '$' => '$', '@' => '$List_', '%' => '$Hash_', '&' => '$Code_', };
    ( $table->{ $self->{sigil} } . $self->{name} );
}

package Rule::Constant;
sub new { shift; bless {@_}, "Rule::Constant" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $str = $self->{constant};
    do {
        if   ( ( $str eq ' ' ) ) { return ('\\ ') }
        else                     { }
    };
    do {
        if   ( ( $str eq '#' ) ) { return ('\\#') }
        else                     { }
    };
    do {
        if   ( ( $str eq '$' ) ) { return ('\\$') }
        else                     { }
    };
    do {
        if   ( ( $str eq '$<' ) ) { return ('\\$<') }
        else                      { }
    };
    do {
        if   ( ( $str eq '@' ) ) { return ('\\@') }
        else                     { }
    };
    do {
        if   ( ( $str eq '%' ) ) { return ('\\%') }
        else                     { }
    };
    do {
        if   ( ( $str eq '?' ) ) { return ('\\?') }
        else                     { }
    };
    do {
        if   ( ( $str eq '+' ) ) { return ('\\+') }
        else                     { }
    };
    do {
        if   ( ( $str eq '*' ) ) { return ('\\*') }
        else                     { }
    };
    do {
        if   ( ( $str eq '??' ) ) { return ('\\?\\?') }
        else                      { }
    };
    do {
        if   ( ( $str eq '++' ) ) { return ('\\+\\+') }
        else                      { }
    };
    do {
        if   ( ( $str eq '**' ) ) { return ('\\*\\*') }
        else                      { }
    };
    do {
        if   ( ( $str eq '(' ) ) { return ('\\(') }
        else                     { }
    };
    do {
        if   ( ( $str eq ')' ) ) { return ('\\)') }
        else                     { }
    };
    do {
        if   ( ( $str eq '[' ) ) { return ('\\[') }
        else                     { }
    };
    do {
        if   ( ( $str eq ']' ) ) { return ('\\]') }
        else                     { }
    };
    do {
        if   ( ( $str eq '{' ) ) { return ('\\{') }
        else                     { }
    };
    do {
        if   ( ( $str eq '}' ) ) { return ('\\}') }
        else                     { }
    };
    do {
        if   ( ( $str eq '\\' ) ) { return ('\\\\') }
        else                      { }
    };
    do {
        if   ( ( $str eq '\'' ) ) { return ('\\\'') }
        else                      { }
    };
    $str;
}

package Rule::Dot;
sub new { shift; bless {@_}, "Rule::Dot" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    '(?:\n\r?|\r\n?|\X)';
}

package Rule::SpecialChar;
sub new { shift; bless {@_}, "Rule::SpecialChar" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $char = $self->{char};
    do {
        if   ( ( $char eq 'n' ) ) { return ('(?:\n\r?|\r\n?)') }
        else                      { }
    };
    do {
        if   ( ( $char eq 'N' ) ) { return ('(?:(?!\n\r?|\r\n?)\X)') }
        else                      { }
    };
    do {
        if   ( ( $char eq '\\' ) ) { return ('\\\\') }
        else                       { }
    };
    do {
        if   ( ( $char eq '\'' ) ) { return ('\\\'') }
        else                       { }
    };
    return ( ( '\\' . $char ) );
}

package Rule::Block;
sub new { shift; bless {@_}, "Rule::Block" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    (   '(?{ '
            . (
            'local $GLOBAL::_M = [ $GLOBAL::_M, "to", pos() ]; '
                . (
                'Match::from_global_data( $GLOBAL::_M ); '
                    . (
                    '$MATCH = '
                        . (
                        '$GLOBAL::MATCH = pop @Match::Matches; '
                            . (
                            '@Match::Matches = (); '
                                . ( 'my $ret = ( sub {' . ( $self->{closure}->emit_perl5() . ( '; "974^213" ' . ( '} )->();' . ( 'if ( $ret ne "974^213" ) {' . ( '$GLOBAL::_M = [ [ @$GLOBAL::_M ], "result", $ret ]; ' . ( '};' . ' })' ) ) ) ) ) ) )
                            )
                        )
                    )
                )
            )
    );
}

package Rule::InterpolateVar;
sub new { shift; bless {@_}, "Rule::InterpolateVar" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    Main::say( ( '# TODO: interpolate var ' . ( $self->{var}->emit_perl5() . '' ) ) );
    die();
}

package Rule::After;
sub new { shift; bless {@_}, "Rule::After" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( ( $self->{assertion_modifier} eq '!' ) ) { return ( ( '(?<!' . ( $self->{rule}->emit_perl5() . ')' ) ) ) }
        else                                          { }
    };
    do {
        if ( ( $self->{assertion_modifier} eq '?' ) ) { return ( ( '(?<=' . ( $self->{rule}->emit_perl5() . ')' ) ) ) }
        else                                          { }
    };
    do {
        if ( $self->{capture_to_array} ) {
            (   '(?<='
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . ( '})' . ( $self->{rule}->emit_perl5() . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture_to_array", "after" ]; ' . ( '})' . ')' ) ) ) ) ) )
                        )
                    )
            );
        }
        else {
            (   '(?<='
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . ( '})' . ( $self->{rule}->emit_perl5() . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture", "after" ]; ' . ( '})' . ')' ) ) ) ) ) )
                        )
                    )
            );
        }
        }
}

package Rule::Before;
sub new { shift; bless {@_}, "Rule::Before" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( ( $self->{assertion_modifier} eq '!' ) ) { return ( ( '(?!' . ( $self->{rule}->emit_perl5() . ')' ) ) ) }
        else                                          { }
    };
    do {
        if ( ( $self->{assertion_modifier} eq '?' ) ) { return ( ( '(?=' . ( $self->{rule}->emit_perl5() . ')' ) ) ) }
        else                                          { }
    };
    do {
        if ( $self->{capture_to_array} ) {
            (   '(?='
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . ( '})' . ( $self->{rule}->emit_perl5() . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture_to_array", "before" ]; ' . ( '})' . ')' ) ) ) ) ) )
                        )
                    )
            );
        }
        else {
            (   '(?='
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . ( '})' . ( $self->{rule}->emit_perl5() . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture", "before" ]; ' . ( '})' . ')' ) ) ) ) ) )
                        )
                    )
            );
        }
        }
}

package Rule::NegateCharClass;
sub new { shift; bless {@_}, "Rule::NegateCharClass" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    Main::say('TODO NegateCharClass');
    die();
}

package Rule::CharClass;
sub new { shift; bless {@_}, "Rule::CharClass" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    Main::say('TODO CharClass');
    die();
}

package Rule::SubruleNoCapture;
sub new { shift; bless {@_}, "Rule::SubruleNoCapture" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $meth = ( '\'$_rule_' . ( $self->{metasyntax} . '\'' ) );
    ( '(?:' . ( '(??{ eval ' . ( $meth . ( ' })' . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "discard_capture" ]; ' . ( '})' . ')' ) ) ) ) ) ) );
}

package Rule::Subrule;
sub new { shift; bless {@_}, "Rule::Subrule" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $meth = ( '\'$_rule_' . ( $self->{metasyntax} . '\'' ) );
    do {
        if   ( $self->{capture_to_array} ) { ( '(?:' . ( '(??{ eval ' . ( $meth . ( ' })' . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture_to_array", "' . ( $self->{ident} . ( '" ]; ' . ( '})' . ')' ) ) ) ) ) ) ) ) ) }
        else                               { ( '(?:' . ( '(??{ eval ' . ( $meth . ( ' })' . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture", "' .          ( $self->{ident} . ( '" ]; ' . ( '})' . ')' ) ) ) ) ) ) ) ) ) }
        }
}

package Rule::NamedCapture;
sub new { shift; bless {@_}, "Rule::NamedCapture" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( $self->{capture_to_array} ) {
            (   '(?:'
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . (
                            '})'
                                . (
                                $self->{rule}->emit_perl5()
                                    . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture_to_array", "' . ( $self->{ident} . ( '" ]; ' . ( '})' . ')' ) ) ) ) ) )
                                )
                            )
                        )
                    )
            );
        }
        else {
            (   '(?:'
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . (
                            '})'
                                . (
                                $self->{rule}->emit_perl5() . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "named_capture", "' . ( $self->{ident} . ( '" ]; ' . ( '})' . ')' ) ) ) ) ) )
                                )
                            )
                        )
                    )
            );
        }
        }
}

package Rule::Capture;
sub new { shift; bless {@_}, "Rule::Capture" }

sub emit_perl5 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( $self->{capture_to_array} ) {
            (   '(?:'
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . (
                            '})'
                                . (
                                $self->{rule}->emit_perl5()
                                    . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "positional_capture_to_array", ' . ( $self->{position} . ( ' ]; ' . ( '})' . ')' ) ) ) ) ) )
                                )
                            )
                        )
                    )
            );
        }
        else {
            (   '(?:'
                    . (
                    '(?{ '
                        . (
                        'local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; '
                            . (
                            '})'
                                . (
                                $self->{rule}->emit_perl5()
                                    . ( '(?{ ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ( 'local $GLOBAL::_M = [ $GLOBAL::_M, "positional_capture", ' . ( $self->{position} . ( ' ]; ' . ( '})' . ')' ) ) ) ) ) )
                                )
                            )
                        )
                    )
            );
        }
        }
}

1;
