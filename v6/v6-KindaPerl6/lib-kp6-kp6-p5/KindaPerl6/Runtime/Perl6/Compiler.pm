{

    package COMPILER;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::KP6Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }
    BEGIN { $_ = ::DISPATCH( $::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
    {
        our $List_PAD         = ::DISPATCH( $::Array,   'new', { modified => $_MODIFIED, name => '$List_PAD' } );
        our $List_CHECK       = ::DISPATCH( $::Array,   'new', { modified => $_MODIFIED, name => '$List_CHECK' } );
        our $Code_emit_perl6  = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_emit_perl6' } );
        our $Code_env_init    = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_env_init' } );
        our $Code_add_pad     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_add_pad' } );
        our $Code_drop_pad    = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_drop_pad' } );
        our $Code_put_pad     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_put_pad' } );
        our $Code_current_pad = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_current_pad' } );
        our $Code_begin_block = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_begin_block' } );
        our $Code_check_block = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_check_block' } );
        our $Code_get_var     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_get_var' } );
        do {
            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::COMPILER ), "true" ), "p5landish" ) ) { }
            else {
                {
                    our $List_PAD         = ::DISPATCH( $::Array,   'new', { modified => $_MODIFIED, name => '$List_PAD' } );
                    our $List_CHECK       = ::DISPATCH( $::Array,   'new', { modified => $_MODIFIED, name => '$List_CHECK' } );
                    our $Code_emit_perl6  = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_emit_perl6' } );
                    our $Code_env_init    = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_env_init' } );
                    our $Code_add_pad     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_add_pad' } );
                    our $Code_drop_pad    = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_drop_pad' } );
                    our $Code_put_pad     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_put_pad' } );
                    our $Code_current_pad = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_current_pad' } );
                    our $Code_begin_block = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_begin_block' } );
                    our $Code_check_block = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_check_block' } );
                    our $Code_get_var     = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_get_var' } );
                    do {
                        ::MODIFIED($::COMPILER);
                        $::COMPILER = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'COMPILER' ) ), 'PROTOTYPE', );
                        }
                }
            }
        };
        $List_PAD;
        $List_CHECK;
        do {
            ::MODIFIED($Code_emit_perl6);
            $Code_emit_perl6 = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $perl6;
                        $perl6 = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$perl6' } ) unless defined $perl6;
                        BEGIN { $perl6 = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$perl6' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $node;
                        $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } ) unless defined $node;
                        BEGIN { $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($node);
                            $node = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        ::DISPATCH_VAR( $perl6, 'STORE', ::DISPATCH( $node, 'emit', $COMPILER::visitor_emit_perl6 ) );
                        return ($perl6);
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'node', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_env_init);
            $Code_env_init = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $pad;
                        $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) unless defined $pad;
                        BEGIN { $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        ::DISPATCH_VAR( $pad, 'STORE', ::DISPATCH( $::Pad, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'outer', ), 'STORE', $::Undef );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'lexicals', ), 'STORE', ::DISPATCH( $::Array, "new", { _array => [] } ) );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'namespace', ), 'STORE', ::DISPATCH( $::Str, 'new', 'Main' ) );
                        ::DISPATCH( $COMPILER::List_PAD, 'unshift', $pad );
                        ::DISPATCH_VAR(
                            ::DISPATCH(
                                $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_,
                                'APPLY',
                                ::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $List_COMPILER::PAD ),
                                $List_COMPILER::PAD,
                                do {
                                    ::MODIFIED($List_COMPILER::PAD);
                                    $List_COMPILER::PAD = ::DISPATCH( $::Scalar, 'new', );
                                    }
                            ),
                            'STORE',
                            $COMPILER::List_PAD
                        );
                    },
                    signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array => ::DISPATCH( $::Array, "new", { _array => [] } ), hash => ::DISPATCH( $::Hash, "new", { _hash => {} } ), return => $::Undef, } ),
                }
            );
        };
        do {
            ::MODIFIED($Code_add_pad);
            $Code_add_pad = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $pad;
                        $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) unless defined $pad;
                        BEGIN { $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $namespace;
                        $namespace = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$namespace' } ) unless defined $namespace;
                        BEGIN { $namespace = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$namespace' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($namespace);
                            $namespace = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        ::DISPATCH_VAR( $pad, 'STORE', ::DISPATCH( $::Pad, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'outer', ), 'STORE', ::DISPATCH( $COMPILER::List_PAD, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) ) );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'lexicals', ), 'STORE', ::DISPATCH( $::Array, "new", { _array => [] } ) );
                        ::DISPATCH_VAR( ::DISPATCH( $pad, 'namespace', ), 'STORE', $namespace );
                        ::DISPATCH( $COMPILER::List_PAD, 'unshift', $pad );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'namespace', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_drop_pad);
            $Code_drop_pad = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        ::DISPATCH( $COMPILER::List_PAD, 'shift', );
                    },
                    signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array => ::DISPATCH( $::Array, "new", { _array => [] } ), hash => ::DISPATCH( $::Hash, "new", { _hash => {} } ), return => $::Undef, } ),
                }
            );
        };
        do {
            ::MODIFIED($Code_put_pad);
            $Code_put_pad = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $pad;
                        $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) unless defined $pad;
                        BEGIN { $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($pad);
                            $pad = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        ::DISPATCH( $COMPILER::List_PAD, 'unshift', $pad );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'pad', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_current_pad);
            $Code_current_pad = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        return ( ::DISPATCH( $COMPILER::List_PAD, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) ) );
                    },
                    signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array => ::DISPATCH( $::Array, "new", { _array => [] } ), hash => ::DISPATCH( $::Hash, "new", { _hash => {} } ), return => $::Undef, } ),
                }
            );
        };
        do {
            ::MODIFIED($Code_begin_block);
            $Code_begin_block = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $ast;
                        $ast = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$ast' } ) unless defined $ast;
                        BEGIN { $ast = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$ast' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($ast);
                            $ast = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        ::DISPATCH( $Pad::Code_begin_block, 'APPLY', $ast );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'ast', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_check_block);
            $Code_check_block = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $pad;
                        $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) unless defined $pad;
                        BEGIN { $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $ast;
                        $ast = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$ast' } ) unless defined $ast;
                        BEGIN { $ast = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$ast' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($ast);
                            $ast = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        ::DISPATCH_VAR( $pad, 'STORE', ::DISPATCH( $COMPILER::PAD, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) ) );
                        ::DISPATCH( $GLOBAL::Code_push, 'APPLY', $COMPILER::List_CHECK, ::DISPATCH( $::Array, "new", { _array => [ $ast, $pad ] } ) );
                        return ( ::DISPATCH( $::Val::Undef, 'new', ) );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'ast', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_get_var);
            $Code_get_var = ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $var;
                        $var = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$var' } ) unless defined $var;
                        BEGIN { $var = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$var' } ) }
                        my $pad;
                        $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) unless defined $pad;
                        BEGIN { $pad = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$pad' } ) }
                        my $decl;
                        $decl = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$decl' } ) unless defined $decl;
                        BEGIN { $decl = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$decl' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $sigil;
                        $sigil = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sigil' } ) unless defined $sigil;
                        BEGIN { $sigil = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sigil' } ) }
                        my $twigil;
                        $twigil = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$twigil' } ) unless defined $twigil;
                        BEGIN { $twigil = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$twigil' } ) }
                        my $name;
                        $name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$name' } ) unless defined $name;
                        BEGIN { $name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$name' } ) }
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        do {
                            ::MODIFIED($sigil);
                            $sigil = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            ::MODIFIED($twigil);
                            $twigil = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 1 ) );
                        };
                        do {
                            ::MODIFIED($name);
                            $name = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 2 ) );
                        };
                        ::DISPATCH_VAR( $var, 'STORE', ::DISPATCH( $::Var, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $var, 'sigil', ),  'STORE', $sigil );
                        ::DISPATCH_VAR( ::DISPATCH( $var, 'twigil', ), 'STORE', $twigil );
                        ::DISPATCH_VAR( ::DISPATCH( $var, 'name', ),   'STORE', $name );
                        ::DISPATCH_VAR( $pad, 'STORE', ::DISPATCH( $COMPILER::List_PAD, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) ) );
                        ::DISPATCH_VAR( $decl, 'STORE', ::DISPATCH( $pad, 'declaration', $var ) );
                        return ($var);
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH(
                                $::Array, "new",
                                {   _array => [
                                        ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'sigil',  namespace => [], } ),
                                        ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'twigil', namespace => [], } ),
                                        ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'name',   namespace => [], } ),
                                    ]
                                }
                            ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
            }
    };
    1
}
