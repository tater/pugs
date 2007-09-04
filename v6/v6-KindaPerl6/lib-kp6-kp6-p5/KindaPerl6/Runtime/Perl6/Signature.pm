{

    package Signature::Item;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }

    BEGIN {
        $_ =
          ::DISPATCH( $::Scalar, "new",
            { modified => $_MODIFIED, name => "$_" } );
    }
    {
        do {
            if (
                ::DISPATCH(
                    ::DISPATCH(
                        ::DISPATCH(
                            $GLOBAL::Code_VAR_defined, 'APPLY',
                            $::Signature::Item
                        ),
                        "true"
                    ),
                    "p5landish"
                )
              )
            {
            }
            else {
                {
                    do {
                        ::MODIFIED($::Signature::Item);
                        $::Signature::Item = ::DISPATCH(
                            ::DISPATCH(
                                $::Class,
                                'new',
                                ::DISPATCH( $::Str, 'new', 'Signature::Item' )
                            ),
                            'PROTOTYPE',
                        );
                      }
                }
            }
        };
        ::DISPATCH(
            ::DISPATCH( $::Signature::Item, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'sigil' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature::Item, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'twigil' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature::Item, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'name' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature::Item, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'perl' ),
            ::DISPATCH(
                $::Method,
                'new',
                sub {
                    my $List__ =
                      ::DISPATCH( $::Array, 'new',
                        { modified => $_MODIFIED, name => '$List__' } );
                    my $self;
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } )
                      unless defined $self;

                    BEGIN {
                        $self =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$self' } );
                    }
                    $self = shift;
                    my $CAPTURE;
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } )
                      unless defined $CAPTURE;

                    BEGIN {
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } );
                    }
                    ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                    do {
                        ::MODIFIED($List__);
                        $List__ = ::DISPATCH( $CAPTURE, 'array', );
                    };
                    ::DISPATCH(
                        $GLOBAL::Code_infix_58__60__126__62_,
                        'APPLY',
                        ::DISPATCH( $self, "sigil" ),
                        ::DISPATCH(
                            $GLOBAL::Code_infix_58__60__126__62_,
                            'APPLY',
                            ::DISPATCH( $self, "twigil" ),
                            ::DISPATCH( $self, "name" )
                        )
                    );
                }
            )
          )
    };
    1
}

{

    package Signature;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }

    BEGIN {
        $_ =
          ::DISPATCH( $::Scalar, "new",
            { modified => $_MODIFIED, name => "$_" } );
    }
    {
        do {
            if (
                ::DISPATCH(
                    ::DISPATCH(
                        ::DISPATCH(
                            $GLOBAL::Code_VAR_defined, 'APPLY',
                            $::Signature
                        ),
                        "true"
                    ),
                    "p5landish"
                )
              )
            {
            }
            else {
                {
                    do {
                        ::MODIFIED($::Signature);
                        $::Signature = ::DISPATCH(
                            ::DISPATCH(
                                $::Class, 'new',
                                ::DISPATCH( $::Str, 'new', 'Signature' )
                            ),
                            'PROTOTYPE',
                        );
                      }
                }
            }
        };
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_parent',
            ::DISPATCH( $::Str, 'new', 'Value' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'invocant' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'array' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'hash' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_attribute',
            ::DISPATCH( $::Str, 'new', 'return' )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'arity' ),
            ::DISPATCH(
                $::Method,
                'new',
                sub {
                    my $List__ =
                      ::DISPATCH( $::Array, 'new',
                        { modified => $_MODIFIED, name => '$List__' } );
                    my $self;
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } )
                      unless defined $self;

                    BEGIN {
                        $self =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$self' } );
                    }
                    $self = shift;
                    my $CAPTURE;
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } )
                      unless defined $CAPTURE;

                    BEGIN {
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } );
                    }
                    ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                    do {
                        ::MODIFIED($List__);
                        $List__ = ::DISPATCH( $CAPTURE, 'array', );
                    };
                    ::DISPATCH(
                        $GLOBAL::Code_infix_58__60__43__62_,
                        'APPLY',
                        ::DISPATCH( ::DISPATCH( $self, "array" ), 'elems', ),
                        ::DISPATCH( ::DISPATCH( $self, "hash" ),  'elems', )
                    );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'perl' ),
            ::DISPATCH(
                $::Method,
                'new',
                sub {
                    my $v;
                    $v =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$v' } )
                      unless defined $v;

                    BEGIN {
                        $v =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$v' } );
                    }
                    my $s;
                    $s =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$s' } )
                      unless defined $s;

                    BEGIN {
                        $s =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$s' } );
                    }
                    my $List__ =
                      ::DISPATCH( $::Array, 'new',
                        { modified => $_MODIFIED, name => '$List__' } );
                    my $self;
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } )
                      unless defined $self;

                    BEGIN {
                        $self =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$self' } );
                    }
                    $self = shift;
                    my $CAPTURE;
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } )
                      unless defined $CAPTURE;

                    BEGIN {
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } );
                    }
                    ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                    do {
                        ::MODIFIED($List__);
                        $List__ = ::DISPATCH( $CAPTURE, 'array', );
                    };
                    $v;
                    ::DISPATCH_VAR( $s, 'STORE',
                        ::DISPATCH( $::Str, 'new', ':( ' ) );
                    do {
                        if (
                            ::DISPATCH(
                                ::DISPATCH(
                                    ::DISPATCH(
                                        ::DISPATCH( $self, "invocant" ),
                                        'defined',
                                    ),
                                    "true"
                                ),
                                "p5landish"
                            )
                          )
                        {
                            {
                                ::DISPATCH_VAR(
                                    $s, 'STORE',
                                    ::DISPATCH(
                                        $GLOBAL::Code_infix_58__60__126__62_,
                                        'APPLY', $s,
                                        ::DISPATCH(
                                            $GLOBAL::Code_infix_58__60__126__62_,
                                            'APPLY',
                                            ::DISPATCH(
                                                ::DISPATCH( $self, "invocant" ),
                                                'perl',
                                            ),
                                            ::DISPATCH( $::Str, 'new', ': ' )
                                        )
                                    )
                                  )
                            }
                        }
                    };
                    {
                        my $v;
                        $v =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$v' } )
                          unless defined $v;

                        BEGIN {
                            $v =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$v' } );
                        }
                        for $v (
                            @{ ::DISPATCH( $self, "array" )->{_value}{_array} }
                          )
                        {
                            {
                                ::DISPATCH_VAR(
                                    $s, 'STORE',
                                    ::DISPATCH(
                                        $GLOBAL::Code_infix_58__60__126__62_,
                                        'APPLY', $s,
                                        ::DISPATCH(
                                            $GLOBAL::Code_infix_58__60__126__62_,
                                            'APPLY',
                                            ::DISPATCH( $v, 'perl', ),
                                            ::DISPATCH( $::Str, 'new', ', ' )
                                        )
                                    )
                                  )
                            }
                        }
                    };
                    return (
                        ::DISPATCH(
                            $GLOBAL::Code_infix_58__60__126__62_,
                            'APPLY', $s, ::DISPATCH( $::Str, 'new', ' )' )
                        )
                    );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Signature, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'str' ),
            ::DISPATCH(
                $::Method,
                'new',
                sub {
                    my $List__ =
                      ::DISPATCH( $::Array, 'new',
                        { modified => $_MODIFIED, name => '$List__' } );
                    my $self;
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } )
                      unless defined $self;

                    BEGIN {
                        $self =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$self' } );
                    }
                    $self = shift;
                    my $CAPTURE;
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } )
                      unless defined $CAPTURE;

                    BEGIN {
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } );
                    }
                    ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                    do {
                        ::MODIFIED($List__);
                        $List__ = ::DISPATCH( $CAPTURE, 'array', );
                    };
                    ::DISPATCH( $self, 'perl', );
                }
            )
          )
    };
    1
}

