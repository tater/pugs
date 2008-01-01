# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Visitor::Emit::Perl5V6;
sub new { shift; bless {@_}, "KindaPerl6::Visitor::Emit::Perl5V6" }
sub visitor_args { @_ == 1 ? ( $_[0]->{visitor_args} ) : ( $_[0]->{visitor_args} = $_[1] ) }

sub visit {
    my $self   = shift;
    my $List__ = \@_;
    my $node;
    do { $node = $List__->[0]; [$node] };
    $node->emit_perl5v6( $self->{visitor_args}->{'secure'} );
}

package CompUnit;
sub new { shift; bless {@_}, "CompUnit" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $KindaPerl6::Visitor::Emit::Perl5::current_compunit = $self->{name};
    my $source = '';
    do {
        if ( $self->{body} ) { $source = $self->{body}->emit_perl5v6() }
        else                 { }
    };
    (   '{ package '
            . (
            $self->{name}
                . (
                '; '
                    . (
                    Main::newline()
                        . (
                        '# Do not edit this file - Perl 5 generated by '
                            . (
                            $Main::_V6_COMPILER_NAME
                                . (
                                Main::newline()
                                    . (
                                    '# AUTHORS, COPYRIGHT: Please look at the source file.'
                                        . (
                                        Main::newline()
                                            . (
                                            'use v5;'
                                                . (
                                                Main::newline()
                                                    . (
                                                    'use strict;'
                                                        . (
                                                        Main::newline()
                                                            . (
                                                            'use Data::Bind;'
                                                                . (
                                                                Main::newline() . ( 'use KindaPerl6::Runtime::Perl5V6::Runtime;' . ( Main::newline() . ( 'sub {' . ( $source . ( '}->()' . ( Main::newline() . ( '; 1 }' . Main::newline() ) ) ) ) ) ) )
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
}

package Val::Int;
sub new { shift; bless {@_}, "Val::Int" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $self->{int};
}

package Val::Bit;
sub new { shift; bless {@_}, "Val::Bit" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $self->{bit};
}

package Val::Num;
sub new { shift; bless {@_}, "Val::Num" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $self->{num};
}

package Val::Buf;
sub new { shift; bless {@_}, "Val::Buf" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( Main::singlequote() . ( Main::mangle_string( $self->{buf} ) . Main::singlequote() ) );
}

package Val::Char;
sub new { shift; bless {@_}, "Val::Char" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( 'chr( ' . ( $self->{char} . ' )' ) );
}

package Val::Undef;
sub new { shift; bless {@_}, "Val::Undef" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    '(undef)';
}

package Val::Object;
sub new { shift; bless {@_}, "Val::Object" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    die('Emitting of Val::Object not implemented');
}

package Native::Buf;
sub new { shift; bless {@_}, "Native::Buf" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    die('Emitting of Native::Buf not implemented');
}

package Lit::Seq;
sub new { shift; bless {@_}, "Lit::Seq" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '(' . ( Main::join( [ map { $_->emit_perl5v6() } @{ $self->{seq} } ], ', ' ) . ')' ) );
}

package Lit::Array;
sub new { shift; bless {@_}, "Lit::Array" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '{ _array => [' . ( Main::join( [ map { $_->emit_perl5v6() } @{ $self->{array} } ], ', ' ) . ( '] }' . Main::newline() ) ) );
}

package Lit::Hash;
sub new { shift; bless {@_}, "Lit::Hash" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $fields = $self->{hash};
    my $str    = '';
    my $field;
    do {
        for my $field ( @{$fields} ) { $str = ( $str . ( '[ ' . ( $field->[0]->emit_perl5v6() . ( ', ' . ( $field->[1]->emit_perl5v6() . ' ],' ) ) ) ) ) }
    };
    ( $str . Main::newline() );
}

package Lit::Pair;
sub new { shift; bless {@_}, "Lit::Pair" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '::DISPATCH( $::Pair, \'new\', ' . ( '{ key => ' . ( $self->{key}->emit_perl5v6() . ( ', value => ' . ( $self->{value}->emit_perl5v6() . ( ' } )' . Main::newline() ) ) ) ) ) );
}

package Lit::NamedArgument;
sub new { shift; bless {@_}, "Lit::NamedArgument" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '::DISPATCH( $::NamedArgument, \'new\', ' . ( '{ _argument_name_ => ' . ( $self->{key}->emit_perl5v6() . ( ', value => ' . ( ( defined( $self->{value} ) ? $self->{value}->emit_perl5v6() : 'undef' ) . ( ' } )' . Main::newline() ) ) ) ) ) );
}

package Lit::SigArgument;
sub new { shift; bless {@_}, "Lit::SigArgument" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    (   '::DISPATCH( $::Signature::Item, \'new\', '
            . (
            '{ '
                . (
                'sigil  => \''
                    . (
                    $self->{key}->sigil()
                        . (
                        '\', '
                            . (
                            'twigil => \''
                                . (
                                $self->{key}->twigil()
                                    . (
                                    '\', '
                                        . (
                                        'name   => \''
                                            . (
                                            $self->{key}->name()
                                                . (
                                                '\', '
                                                    . (
                                                    'value  => '
                                                        . (
                                                        ( defined( $self->{value} ) ? $self->{value}->emit_perl5v6() : 'undef' )
                                                        . ( ', '
                                                                . (
                                                                'has_default    => '
                                                                    . (
                                                                    $self->{has_default}->emit_perl5v6()
                                                                        . (
                                                                        ', '
                                                                            . (
                                                                            'is_named_only  => '
                                                                                . (
                                                                                $self->{is_named_only}->emit_perl5v6()
                                                                                    . (
                                                                                    ', '
                                                                                        . (
                                                                                        'is_optional    => '
                                                                                            . (
                                                                                            $self->{is_optional}->emit_perl5v6()
                                                                                                . (
                                                                                                ', '
                                                                                                    . (
                                                                                                    'is_slurpy      => '
                                                                                                        . (
                                                                                                        $self->{is_slurpy}->emit_perl5v6()
                                                                                                            . (
                                                                                                            ', '
                                                                                                                . (
                                                                                                                'is_multidimensional  => '
                                                                                                                    . (
                                                                                                                    $self->{is_multidimensional}->emit_perl5v6()
                                                                                                                        . (
                                                                                                                        ', '
                                                                                                                            . (
                                                                                                                            'is_rw          => '
                                                                                                                                . (
                                                                                                                                $self->{is_rw}->emit_perl5v6()
                                                                                                                                    . ( ', ' . ( 'is_copy        => ' . ( $self->{is_copy}->emit_perl5v6() . ( ', ' . ( ' } )' . Main::newline() ) ) ) ) )
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
}

package Lit::Code;
sub new { shift; bless {@_}, "Lit::Code" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( $self->{CATCH} ) { ( 'do { eval {' . ( $self->emit_declarations() . ( $self->emit_body() . ( '};if ($@) {' . ( $self->{CATCH}->emit_perl5v6() . '}}' ) ) ) ) ) }
        else                  { ( 'do {' . ( $self->emit_declarations() . ( $self->emit_body() . '}' ) ) ) }
        }
}

sub emit_body {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    Main::join( [ map { $_->emit_perl5v6() } @{ $self->{body} } ], '; ' );
}

sub emit_signature {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    $self->{sig}->emit_perl5v6();
}

sub emit_declarations {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $s;
    my $name;
    do {
        for my $name ( @{ $self->{pad}->lexicals() } ) {
            my $decl = Decl->new( 'decl' => 'my', 'type' => '', 'var' => Var->new( 'sigil' => '', 'twigil' => '', 'name' => $name, 'namespace' => [], ), );
            $s = ( $s . ( $name->emit_perl5v6() . ( ';' . Main::newline() ) ) );
        }
    };
    return ($s);
}

sub emit_arguments {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $array_  = Var->new( 'sigil' => '@', 'twigil' => '', 'name' => '_',       'namespace' => [], );
    my $hash_   = Var->new( 'sigil' => '%', 'twigil' => '', 'name' => '_',       'namespace' => [], );
    my $CAPTURE = Var->new( 'sigil' => '$', 'twigil' => '', 'name' => 'CAPTURE', 'namespace' => [], );
    my $CAPTURE_decl = Decl->new( 'decl' => 'my', 'type' => '', 'var' => $CAPTURE, );
    my $str = '';
    $str = ( $str . $CAPTURE_decl->emit_perl5v6() );
    $str = ( $str . Decl->new( 'decl' => 'my', 'type' => '', 'var' => $array_, )->emit_perl5v6() );
    $str = ( $str . '::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));' );
    my $bind_array = Assign->new( 'parameters' => $array_, 'arguments' => Call->new( 'invocant' => $CAPTURE, 'method' => 'array', 'arguments' => [], ), );
    $str = ( $str . ( $bind_array->emit_perl5v6() . ';' ) );
    my $bind_hash = Bind->new( 'parameters' => $hash_, 'arguments' => Call->new( 'invocant' => $CAPTURE, 'method' => 'hash', 'arguments' => [], ), );
    $str = ( $str . ( $bind_hash->emit_perl5v6() . ';' ) );
    my $i = 0;
    my $field;
    $str = ( $str . '{ my $_param_index = 0; ' );
    do {

        for my $field ( @{ $self->{sig}->positional() } ) {
            my $bind_named = Bind->new( 'parameters' => $field->key(), 'arguments' => Call->new( 'invocant' => $hash_, 'arguments' => [ Val::Buf->new( 'buf' => $field->key()->name(), ) ], 'method' => 'LOOKUP', ), );
            my $bind_default = Bind->new( 'parameters' => $field->key(), 'arguments' => $field->value(), );
            $str = (
                $str
                    . (
                    ' if ( ::DISPATCH( $GLOBAL::Code_exists, '
                        . (
                        ' \'APPLY\', '
                            . (
                            ' ::DISPATCH( '
                                . (
                                ' $Hash__, \'LOOKUP\', '
                                    . (
                                    ' ::DISPATCH( $::Str, \'new\', \''
                                        . (
                                        $field->key()->name()
                                            . (
                                            '\' ) '
                                                . (
                                                ' ) )->{_value} '
                                                    . (
                                                    ' ) '
                                                        . (
                                                        ' { '
                                                            . (
                                                            $bind_named->emit_perl5v6()
                                                                . (
                                                                ' } '
                                                                    . (
                                                                    ' elsif ( ::DISPATCH( $GLOBAL::Code_exists, '
                                                                        . (
                                                                        ' \'APPLY\', '
                                                                            . (
                                                                            ' ::DISPATCH( '
                                                                                . (
                                                                                ' $List__, \'INDEX\', '
                                                                                    . (
                                                                                    ' ::DISPATCH( $::Int, \'new\', $_param_index ) '
                                                                                        . (
                                                                                        ' ) )->{_value} '
                                                                                            . (
                                                                                            ' ) '
                                                                                                . (
                                                                                                ' { '
                                                                                                    . (
                                                                                                    $field->key()->emit_perl5v6()
                                                                                                        . ( ' = ::DISPATCH( ' . ( ' $List__, \'INDEX\', ' . ( ' ::DISPATCH( $::Int, \'new\', $_param_index++ ) ' . ( ' ); ' . ' } ' ) ) ) )
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
            do {
                if ( $field->has_default()->bit() ) { $str = ( $str . ( ' else { ' . ( $bind_default->emit_perl5v6() . ' } ' ) ) ) }
                else                                { }
            };
            $i = ( $i + 1 );
        }
    };
    $str = ( $str . '} ' );
    return ($str);
}

package Lit::Object;
sub new { shift; bless {@_}, "Lit::Object" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $fields = $self->{fields};
    my $str    = '';
    my $field;
    do {
        for my $field ( @{$fields} ) {
            $str = ( $str . ( '::DISPATCH( $::NamedArgument, "new", ' . ( '{ ' . ( '_argument_name_ => ' . ( $field->[0]->emit_perl5v6() . ( ', ' . ( 'value           => ' . ( $field->[1]->emit_perl5v6() . ( ', ' . ' } ), ' ) ) ) ) ) ) ) ) );
        }
    };
    ( '::DISPATCH( $::' . ( $self->{class} . ( ', \'new\', ' . ( $str . ( ' )' . Main::newline() ) ) ) ) );
}

package Assign;
sub new { shift; bless {@_}, "Assign" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( $self->{parameters}->emit_perl5v6() . ( ' = ' . ( $self->{arguments}->emit_perl5v6() . Main::newline() ) ) );
}

package Var;
sub new { shift; bless {@_}, "Var" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $table = { '$' => '$', '@' => '$List_', '%' => '$Hash_', '&' => '$Code_', };
    do {
        if ( ( $self->{twigil} eq '.' ) ) { return ( ( '::DISPATCH( $self, "' . ( $self->{name} . ( '" )' . Main::newline() ) ) ) ) }
        else                              { }
    };
    do {
        if ( ( $self->{twigil} eq '!' ) ) { return ( ( '$self->{_value}{"' . ( $self->{name} . ( '"}' . Main::newline() ) ) ) ) }
        else                              { }
    };
    do {
        if ( ( $self->{name} eq '/' ) ) { return ( ( $table->{ $self->{sigil} } . 'MATCH' ) ) }
        else                            { }
    };
    return ( ( $table->{ $self->{sigil} } . Main::mangle_ident( $self->{name} ) ) );
}

package Bind;
sub new { shift; bless {@_}, "Bind" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( Main::isa( $self->{parameters}, 'Var' ) ) {
            do {
                if ( ( $self->{parameters}->sigil() eq '$' ) ) { return ( ( 'bind_op(' . ( Main::singlequote() . ( $self->{parameters}->emit_perl5v6() . ( Main::singlequote() . ( ' => \\' . ( $self->{arguments}->emit_perl5v6() . ')' ) ) ) ) ) ) ) }
                else                                           { }
            };
            return ( ( '(' . ( $self->{parameters}->emit_perl5v6() . ( ' = ' . ( $self->{arguments}->emit_perl5v6() . ' )' ) ) ) ) );
        }
        else { }
    };
    die('TODO');
}

package Proto;
sub new { shift; bless {@_}, "Proto" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    return ( ( '$::' . $self->{name} ) );
}

package Call;
sub new { shift; bless {@_}, "Call" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $invocant;
    do {
        if ( Main::isa( $self->{invocant}, 'Proto' ) ) {
            do {
                if   ( ( $self->{invocant}->name() eq 'self' ) ) { $invocant = '$self' }
                else                                             { $invocant = $self->{invocant}->emit_perl5v6() }
                }
        }
        else { $invocant = $self->{invocant}->emit_perl5v6() }
    };
    do {
        if ( ( $invocant eq 'self' ) ) { $invocant = '$self' }
        else                           { }
    };
    my $meth = $self->{method};
    do {
        if ( ( $meth eq 'postcircumfix:<( )>' ) ) { $meth = '' }
        else                                      { }
    };
    my $call = Main::join( [ map { $_->emit_perl5v6() } @{ $self->{arguments} } ], ', ' );
    do {
        if ( $self->{hyper} ) {
            ( '::DISPATCH( $::List, "new", { _array => [ '
                    . ( 'map { ::DISPATCH( $_, "' . ( $meth . ( '", ' . ( $call . ( ') } ' . ( '@{ ::DISPATCH( ' . ( $invocant . ( ', "array" )->{_value}{_array} } ' . ( '] } )' . Main::newline() ) ) ) ) ) ) ) ) ) );
        }
        else {
            do {
                if ( ( $meth eq '' ) ) { ( '::DISPATCH( ' . ( $invocant . ( ', \'APPLY\', ' . ( $call . ( ' )' . Main::newline() ) ) ) ) ) }
                else                   { ( '::DISPATCH( ' . ( $invocant . ( ', ' . ( '\'' . ( $meth . ( '\', ' . ( $call . ( ' )' . Main::newline() ) ) ) ) ) ) ) ) }
                }
        }
        }
}

package Apply;
sub new { shift; bless {@_}, "Apply" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if   ( ( Main::isa( $self->{code}, 'Var' ) && ( $self->{code}->name() eq 'self' ) ) ) { return ('$self') }
        else                                                                                  { }
    };
    do {
        if ( ( Main::isa( $self->{code}, 'Var' ) && ( $self->{code}->name() eq 'make' ) ) ) {
            return ( ( '::DISPATCH_VAR( ' . ( '$GLOBAL::_REGEX_RETURN_, "STORE", ' . ( $self->{arguments}->[0]->emit_perl5v6() . ( '' . ( ' )' . Main::newline() ) ) ) ) ) );
        }
        else { }
    };
    my $ops = { 'infix:<~>' => '.', 'infix:<+>' => '+', 'infix:<==>' => '==', 'infix:<!=>' => 'ne', 'infix:<eq>' => 'eq', 'infix:<ne>' => 'ne', 'infix:<&&>' => '&&', 'infix:<||>' => '||', };
    do {
        if ( ( Main::isa( $self->{code}, 'Var' ) && $ops->{ $self->{code}->name() } ) ) {
            return ( ( '(' . ( $self->{arguments}->[0]->emit_perl5v6() . ( ' ' . ( $ops->{ $self->{code}->name() } . ( ' ' . ( $self->{arguments}->[1]->emit_perl5v6() . ')' ) ) ) ) ) ) );
        }
        else { }
    };
    return ( ( '(' . ( $self->{code}->emit_perl5v6() . ( ')->(' . ( Main::join( [ map { $_->emit_perl5v6() } @{ $self->{arguments} } ], ', ' ) . ( ' )' . Main::newline() ) ) ) ) ) );
}

package Return;
sub new { shift; bless {@_}, "Return" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( 'return(' . ( $self->{result}->emit_perl5v6() . ( ')' . Main::newline() ) ) );
}

package If;
sub new { shift; bless {@_}, "If" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    (   'do { if ('
            . (
            $self->{cond}->emit_perl5v6()
                . (
                ') ' . ( ( $self->{body} ? ( '{ ' . ( $self->{body}->emit_perl5v6() . ' } ' ) ) : '{ } ' ) . ( ( $self->{otherwise} ? ( ' else { ' . ( $self->{otherwise}->emit_perl5v6() . ' }' ) ) : ' else { 0 }' ) . ( ' }' . Main::newline() ) ) )
                )
            )
    );
}

package While;
sub new { shift; bless {@_}, "While" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $cond = $self->{cond};
    do {
        if   ( ( Main::isa( $cond, 'Var' ) && ( $cond->sigil() eq '@' ) ) ) { }
        else                                                                { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&', 'twigil' => '', 'name' => 'prefix:<@>', 'namespace' => ['GLOBAL'], ), 'arguments' => [$cond], ) }
    };
    ( 'do { while (::DISPATCH(::DISPATCH(' . ( $self->{cond}->emit_perl5v6() . ( ',"true"),"p5landish") ) ' . ( ' { ' . ( $self->{body}->emit_perl5v6() . ( ' } }' . Main::newline() ) ) ) ) ) );
}

package Decl;
sub new { shift; bless {@_}, "Decl" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $decl = $self->{decl};
    my $name = $self->{var}->name();
    do {
        if ( ( $decl eq 'has' ) ) { return ( ( 'sub ' . ( $name . ( ' { ' . ( '@_ == 1 ' . ( '? ( $_[0]->{' . ( $name . ( '} ) ' . ( ': ( $_[0]->{' . ( $name . ( '} = $_[1] ) ' . '}' ) ) ) ) ) ) ) ) ) ) ) }
        else                      { }
    };
    return ( ( $self->{decl} . ( ' ' . $self->{var}->emit_perl5v6() ) ) );
}

package Sig;
sub new { shift; bless {@_}, "Sig" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $inv = '$::Undef';
    do {
        if ( Main::isa( $self->{invocant}, 'Var' ) ) { $inv = Main::perl( $self->{invocant}, ) }
        else                                         { }
    };
    my $pos;
    my $decl;
    do {
        for my $decl ( @{ $self->{positional} } ) { $pos = ( $pos . ( $decl->emit_perl5v6() . ', ' ) ) }
    };
    my $named = '';
    ( '::DISPATCH( $::Signature, "new", { ' . ( 'invocant => ' . ( $inv . ( ', ' . ( 'array    => ::DISPATCH( $::List, "new", { _array => [ ' . ( $pos . ( ' ] } ), ' . ( 'return   => $::Undef, ' . ( '} )' . Main::newline() ) ) ) ) ) ) ) ) );
}

package Lit::Capture;
sub new { shift; bless {@_}, "Lit::Capture" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    my $s = '::DISPATCH( $::Capture, "new", { ';
    do {
        if ( defined( $self->{invocant} ) ) { $s = ( $s . ( 'invocant => ' . ( $self->{invocant}->emit_perl5v6() . ', ' ) ) ) }
        else                                { $s = ( $s . 'invocant => $::Undef, ' ) }
    };
    do {
        if ( defined( $self->{array} ) ) {
            $s = ( $s . 'array => ::DISPATCH( $::List, "new", { _array => [ ' );
            my $item;
            do {
                for my $item ( @{ $self->{array} } ) { $s = ( $s . ( $item->emit_perl5v6() . ', ' ) ) }
            };
            $s = ( $s . ' ] } ),' );
        }
        else { }
    };
    do {
        if ( defined( $self->{hash} ) ) {
            $s = ( $s . 'hash => ::DISPATCH( $::Hash, "new", ' );
            my $item;
            do {
                for my $item ( @{ $self->{hash} } ) { $s = ( $s . ( '[ ' . ( $item->[0]->emit_perl5v6() . ( ', ' . ( $item->[1]->emit_perl5v6() . ' ], ' ) ) ) ) ) }
            };
            $s = ( $s . ' ),' );
        }
        else { }
    };
    return ( ( $s . ( ' } )' . Main::newline() ) ) );
}

package Lit::Subset;
sub new { shift; bless {@_}, "Lit::Subset" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '::DISPATCH( $::Subset, "new", { '
            . ( 'base_class => ' . ( $self->{base_class}->emit_perl5v6() . ( ', ' . ( 'block => ' . ( 'sub { local $_ = shift; ' . ( $self->{block}->block()->emit_perl5v6() . ( ' } ' . ( ' } )' . Main::newline() ) ) ) ) ) ) ) ) );
}

package Method;
sub new { shift; bless {@_}, "Method" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    die('TODO methods');
    (   '::DISPATCH( $::Code, \'new\', { '
            . (
            'code => sub { '
                . (
                Main::newline()
                    . (
                    '# emit_declarations'
                        . (
                        Main::newline()
                            . (
                            $self->{block}->emit_declarations()
                                . (
                                Main::newline()
                                    . (
                                    '# get $self'
                                        . (
                                        Main::newline()
                                            . (
                                            '$self = shift; '
                                                . (
                                                Main::newline()
                                                    . (
                                                    '# emit_arguments'
                                                        . (
                                                        Main::newline()
                                                            . (
                                                            $self->{block}->emit_arguments()
                                                                . (
                                                                Main::newline()
                                                                    . (
                                                                    '# emit_body'
                                                                        . ( Main::newline() . ( $self->{block}->emit_body() . ( ' }, ' . ( 'signature => ' . ( $self->{block}->emit_signature() . ( ', ' . ( ' } )' . Main::newline() ) ) ) ) ) ) )
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
}

package Sub;
sub new { shift; bless {@_}, "Sub" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( 'sub {' . ( $self->{block}->emit_declarations() . ( $self->{block}->emit_body() . ( ' }' . Main::newline() ) ) ) );
}

package Macro;
sub new { shift; bless {@_}, "Macro" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    (   '::DISPATCH( $::Macro, \'new\', { '
            . (
            'code => sub { '
                . ( $self->{block}->emit_declarations() . ( $self->{block}->emit_arguments() . ( $self->{block}->emit_body() . ( ' }, ' . ( 'signature => ' . ( $self->{block}->emit_signature() . ( ', ' . ( ' } )' . Main::newline() ) ) ) ) ) ) ) )
            )
    );
}

package Do;
sub new { shift; bless {@_}, "Do" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( 'do { ' . ( $self->{block}->emit_perl5v6() . ( ' }' . Main::newline() ) ) );
}

package BEGIN;
sub new { shift; bless {@_}, "BEGIN" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( 'INIT { ' . ( $self->{block}->emit_perl5v6() . ' }' ) );
}

package Use;
sub new { shift; bless {@_}, "Use" }

sub emit_perl5v6 {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    do {
        if ( ( $self->{mod} eq 'v6' ) ) { return ( ( Main::newline() . ( '#use v6' . Main::newline() ) ) ) }
        else                            { }
    };
    do {
        if ( $self->{perl5} ) { return ( ( 'use ' . ( $self->{mod} . ( ';$::' . ( $self->{mod} . ( '= KindaPerl6::Runtime::Perl5::Wrap::use5(\'' . ( $self->{mod} . '\')' ) ) ) ) ) ) ) }
        else                  { return ( ( 'use ' . $self->{mod} ) ) }
        }
}

1;
