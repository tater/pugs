{

    package Multi;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict "vars";
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::KP6Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }
    BEGIN { $_ = ::DISPATCH( $::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
    {
        do {
            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Multi ), "true" ), "p5landish" ) ) { }
            else {
                {
                    do {
                        ::MODIFIED($::Multi);
                        $::Multi = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Multi' ) ), 'PROTOTYPE', );
                        }
                }
            }
        };
        ::DISPATCH( ::DISPATCH( $::Multi, 'HOW', ), 'add_parent',    ::DISPATCH( $::Str, 'new', 'Code' ) );
        ::DISPATCH( ::DISPATCH( $::Multi, 'HOW', ), 'add_attribute', ::DISPATCH( $::Str, 'new', 'long_names' ) );
        ::DISPATCH( ::DISPATCH( $::Multi, 'HOW', ), 'add_attribute', ::DISPATCH( $::Str, 'new', 'token_length' ) );
        ::DISPATCH(
            ::DISPATCH( $::Multi, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'add_variant' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $code;
                        $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) unless defined $code;
                        BEGIN { $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) }
                        $self = shift;
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
                            ::MODIFIED($code);
                            $code = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'long_names', ) ) ), "true" ), "p5landish" ) ) {
                                {
                                    ::DISPATCH_VAR( ::DISPATCH( $self, 'long_names', ), 'STORE', ::DISPATCH( $::Array, "new", { _array => [] } ) )
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        ::DISPATCH( ::DISPATCH( $self, 'long_names', ), 'push', $code );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'code', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Multi, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'add_token_variant' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $len;
                        $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) unless defined $len;
                        BEGIN { $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) }
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $code;
                        $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) unless defined $code;
                        BEGIN { $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) }
                        my $sym;
                        $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) unless defined $sym;
                        BEGIN { $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) }
                        $self = shift;
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
                            ::MODIFIED($code);
                            $code = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            ::MODIFIED($sym);
                            $sym = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 1 ) );
                        };
                        ::DISPATCH_VAR( $len, 'STORE', ::DISPATCH( $sym, 'chars', ) );
                        do {
                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'token_length', ) ) ), "true" ), "p5landish" ) ) {
                                {
                                    ::DISPATCH_VAR( ::DISPATCH( $self, 'token_length', ), 'STORE', ::DISPATCH( $::Hash, "new", { _hash => {} } ) )
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        do {
                            if (::DISPATCH(
                                    ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'LOOKUP', $len ) ) ), "true" ), "p5landish"
                                )
                                )
                            {
                                {
                                    ::DISPATCH_VAR( ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'LOOKUP', $len ), 'STORE', ::DISPATCH( $::Hash, "new", { _hash => {} } ) )
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        ::DISPATCH_VAR( ::DISPATCH( ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'LOOKUP', $len ), 'LOOKUP', $sym ), 'STORE', ::DISPATCH( $::Multi, 'new', ) );
                        ::DISPATCH( ::DISPATCH( ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'LOOKUP', $len ), 'LOOKUP', $sym ), 'add_variant', $code );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH(
                                $::Array, "new",
                                {   _array => [
                                        ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'code', namespace => [], } ),
                                        ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'sym',  namespace => [], } ),
                                    ]
                                }
                            ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Multi, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'select' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List_candidates = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List_candidates' } );
                        my $List__          = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $capture;
                        $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } ) unless defined $capture;
                        BEGIN { $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } ) }
                        $self = shift;
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
                            ::MODIFIED($capture);
                            $capture = ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $capture, 'isa', ::DISPATCH( $::Str, 'new', 'Capture' ) ), "true" ), "p5landish" ) ) { }
                            else {
                                {
                                    ::DISPATCH( $GLOBAL::Code_die, 'APPLY', ::DISPATCH( $::Str, 'new', 'the parameter to Multi.select must be a Capture' ) )
                                }
                            }
                        };
                        do {
                            if (::DISPATCH(
                                    ::DISPATCH(
                                        do {
                                            (   do {
                                                    my $____some__weird___var____ = ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'token_length', ) );
                                                    ::DISPATCH( $____some__weird___var____, "true" )->{_value} && $____some__weird___var____;
                                                    }
                                                    && do {
                                                    my $____some__weird___var____ = ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'keys', );
                                                    ::DISPATCH( $____some__weird___var____, "true" )->{_value} && $____some__weird___var____;
                                                    }
                                            ) || ::DISPATCH( $::Bit, "new", 0 );
                                        },
                                        "true"
                                    ),
                                    "p5landish"
                                )
                                )
                            {
                                {
                                    my $List_len = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List_len' } );
                                    ::DISPATCH_VAR( $List_len, 'STORE', ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'keys', ) );
                                    ::DISPATCH_VAR(
                                        $List_len,
                                        'STORE',
                                        ::DISPATCH(
                                            $List_len,
                                            'sort',
                                            ::DISPATCH(
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
                                                        ::DISPATCH( $GLOBAL::Code_infix_58__60__60__61__62__62_, 'APPLY', ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 1 ) ), ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', ) ) );
                                                    },
                                                    signature =>
                                                        ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array => ::DISPATCH( $::Array, "new", { _array => [] } ), hash => ::DISPATCH( $::Hash, "new", { _hash => {} } ), return => $::Undef, } ),
                                                }
                                            )
                                        )
                                    );
                                    {
                                        my $len;
                                        $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) unless defined $len;
                                        BEGIN { $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) }
                                        for $len ( @{ $List_len->{_value}{_array} } ) {
                                            {
                                                do {
                                                    if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_infix_58__60__62__61__62_, 'APPLY', ::DISPATCH( $_, 'chars', ), $len ), "true" ), "p5landish" ) ) {
                                                        {
                                                            my $s;
                                                            $s = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$s' } ) unless defined $s;
                                                            BEGIN { $s = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$s' } ) }
                                                            my $Hash_syms = ::DISPATCH( $::Hash, 'new', { modified => $_MODIFIED, name => '$Hash_syms' } );
                                                            ::DISPATCH_VAR( $s, 'STORE', ::DISPATCH( $GLOBAL::Code_substr, 'APPLY', $_, ::DISPATCH( $::Int, 'new', ), $len ) );
                                                            ::DISPATCH_VAR( $Hash_syms, 'STORE', ::DISPATCH( ::DISPATCH( $self, 'token_length', ), 'LOOKUP', $len ) );
                                                            {
                                                                my $sym;
                                                                $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) unless defined $sym;
                                                                BEGIN { $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) }
                                                                for $sym ( @{ ::DISPATCH( $GLOBAL::Code_prefix_58__60__64__62_, 'APPLY', ::DISPATCH( $Hash_syms, 'keys', ) )->{_value}{_array} } ) {
                                                                    {
                                                                        do {
                                                                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_infix_58__60_eq_62_, 'APPLY', $s, $sym ), "true" ), "p5landish" ) ) {
                                                                                {
                                                                                    return ( ::DISPATCH( ::DISPATCH( $Hash_syms, 'LOOKUP', $sym ), 'select', $capture ) )
                                                                                }
                                                                            }
                                                                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                                                                            }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else { ::DISPATCH( $::Bit, "new", 0 ) }
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        do {
                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'long_names', ) ) ), "true" ), "p5landish" ) ) {
                                {
                                    ::DISPATCH(
                                        $GLOBAL::Code_die,
                                        'APPLY',
                                        ::DISPATCH(
                                            $GLOBAL::Code_infix_58__60__126__62_, 'APPLY',
                                            ::DISPATCH( $::Str, 'new', 'can' ), ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr(39) ), ::DISPATCH( $::Str, 'new', 't resolve Multi dispatch' ) )
                                        )
                                        )
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        ::DISPATCH_VAR( $List_candidates, 'STORE', ::DISPATCH( $::Array, "new", { _array => [] } ) );
                        {
                            my $sub;
                            $sub = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sub' } ) unless defined $sub;
                            BEGIN { $sub = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sub' } ) }
                            for $sub ( @{ ::DISPATCH( $GLOBAL::Code_prefix_58__60__64__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_prefix_58__60__64__62_, 'APPLY', ::DISPATCH( $self, 'long_names', ) ) )->{_value}{_array} } ) {
                                {
                                    do {
                                        if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_infix_58__60__61__61__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $sub, 'signature', ), 'arity', ), ::DISPATCH( $capture, 'arity', ) ), "true" ), "p5landish" ) )
                                        {
                                            {
                                                ::DISPATCH( $List_candidates, 'push', $sub )
                                            }
                                        }
                                        else { ::DISPATCH( $::Bit, "new", 0 ) }
                                        }
                                }
                            }
                        };
                        do {
                            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( $GLOBAL::Code_infix_58__60__61__61__62_, 'APPLY', ::DISPATCH( $List_candidates, 'elems', ), ::DISPATCH( $::Int, 'new', 1 ) ), "true" ), "p5landish" ) ) {
                                {
                                    return ( ::DISPATCH( $List_candidates, 'INDEX', ::DISPATCH( $::Int, 'new', ) ) )
                                }
                            }
                            else { ::DISPATCH( $::Bit, "new", 0 ) }
                        };
                        ::DISPATCH(
                            $GLOBAL::Code_die,
                            'APPLY',
                            ::DISPATCH(
                                $GLOBAL::Code_infix_58__60__126__62_, 'APPLY',
                                ::DISPATCH( $::Str, 'new', 'can' ), ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr(39) ), ::DISPATCH( $::Str, 'new', 't resolve Multi dispatch' ) )
                            )
                        );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => $::Undef,
                            array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, "new", { sigil => '$', twigil => '', name => 'capture', namespace => [], } ), ] } ),
                            hash   => ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Multi, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'perl' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {
                        my $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $self;
                        $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) unless defined $self;
                        BEGIN { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
                        $self = shift;
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
                        ::DISPATCH( $::Str, 'new', 'Multi.new( ... )' );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => ::DISPATCH( $::Signature::Item, "new", { sigil  => '$', twigil => '', name => 'self', namespace => [], } ),
                            array    => ::DISPATCH( $::Array,           "new", { _array => [] } ),
                            hash     => ::DISPATCH( $::Hash,            "new", { _hash  => {} } ),
                            return   => $::Undef,
                        }
                    ),
                }
            )
            )
    };
    1
}
