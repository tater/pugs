{

    package KindaPerl6::Visitor::Hyper;

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
                            $::KindaPerl6::Visitor::Hyper
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
                        ::MODIFIED($::KindaPerl6::Visitor::Hyper);
                        $::KindaPerl6::Visitor::Hyper = ::DISPATCH(
                            ::DISPATCH(
                                $::Class, 'new',
                                ::DISPATCH(
                                    $::Str, 'new',
                                    'KindaPerl6::Visitor::Hyper'
                                )
                            ),
                            'PROTOTYPE',
                        );
                      }
                }
            }
        };
        ::DISPATCH(
            ::DISPATCH( $::KindaPerl6::Visitor::Hyper, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'visit' ),
            ::DISPATCH(
                $::Method,
                'new',
                sub {
                    my $List__ =
                      ::DISPATCH( $::Array, 'new',
                        { modified => $_MODIFIED, name => '$List__' } );
                    my $node;
                    $node =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$node' } )
                      unless defined $node;

                    BEGIN {
                        $node =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$node' } );
                    }
                    my $node_name;
                    $node_name =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$node_name' } )
                      unless defined $node_name;

                    BEGIN {
                        $node_name =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$node_name' } );
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
                    do {
                        ::MODIFIED($Hash__);
                        $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                    };
                    do {
                        ::MODIFIED($node);
                        $node =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($node_name);
                        $node_name =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    do {
                        if (
                            ::DISPATCH(
                                ::DISPATCH(
                                    ::DISPATCH(
                                        $GLOBAL::Code_infix_58__60__38__38__62_,
                                        'APPLY',
                                        ::DISPATCH(
                                            $GLOBAL::Code_infix_58__60_eq_62_,
                                            'APPLY',
                                            $node_name,
                                            ::DISPATCH( $::Str, 'new', 'Call' )
                                        ),
                                        ::DISPATCH( $node, 'hyper', )
                                    ),
                                    "true"
                                ),
                                "p5landish"
                            )
                          )
                        {
                            {
                                return (
                                    ::DISPATCH(
                                        $::Apply, 'new',
                                        ::DISPATCH( $::Str,   'new', 'code' ) =>
                                          ::DISPATCH( $::Str, 'new', 'map' ),
                                        ::DISPATCH(
                                            $::Str, 'new', 'arguments'
                                          ) => ::DISPATCH(
                                            $::Array, "new",
                                            {
                                                _array => [
                                                    ::DISPATCH(
                                                        $::Sub, 'new',
                                                        ::DISPATCH(
                                                            $::Str, 'new',
                                                            'sig'
                                                          ) => ::DISPATCH(
                                                            $::Sig,
                                                            'new',
                                                            ::DISPATCH(
                                                                $::Str,
                                                                'new',
                                                                'positional'
                                                              ) => ::DISPATCH(
                                                                $::Array,
                                                                "new",
                                                                {
                                                                    _array => []
                                                                }
                                                              ),
                                                            ::DISPATCH(
                                                                $::Str,
                                                                'new',
                                                                'named'
                                                              ) => ::DISPATCH(
                                                                $::Array,
                                                                "new",
                                                                {
                                                                    _array => []
                                                                }
                                                              ),
                                                          ),
                                                        ::DISPATCH(
                                                            $::Str, 'new',
                                                            'block'
                                                          ) => ::DISPATCH(
                                                            $::Array,
                                                            "new",
                                                            {
                                                                _array => [
                                                                    ::DISPATCH(
                                                                        $::Call,
                                                                        'new',
                                                                        ::DISPATCH(
                                                                            $::Str,
'new',
'invocant'
                                                                          ) =>
                                                                          ::DISPATCH(
                                                                            $::Var,
'new',
                                                                            ::DISPATCH(
                                                                                $::Str,
'new',
'sigil'
                                                                              )
                                                                              => ::DISPATCH(
                                                                                $::Str,
'new',
'$'
                                                                              ),
                                                                            ::DISPATCH(
                                                                                $::Str,
'new',
'twigil'
                                                                              )
                                                                              => ::DISPATCH(
                                                                                $::Str,
'new',
''
                                                                              ),
                                                                            ::DISPATCH(
                                                                                $::Str,
'new',
'name'
                                                                              )
                                                                              => ::DISPATCH(
                                                                                $::Str,
'new',
'_'
                                                                              ),
                                                                          ),
                                                                        ::DISPATCH(
                                                                            $::Str,
'new',
'method'
                                                                          ) =>
                                                                          ::DISPATCH(
                                                                            $node,
'method',
                                                                          ),
                                                                        ::DISPATCH(
                                                                            $::Str,
'new',
'arguments'
                                                                          ) =>
                                                                          ::DISPATCH(
                                                                            $node,
'arguments',
                                                                          ),
                                                                    )
                                                                ]
                                                            }
                                                          ),
                                                    ),
                                                    ::DISPATCH(
                                                        $node, 'invocant',
                                                    )
                                                ]
                                            }
                                          ),
                                    )
                                  )
                            }
                        }
                    };
                    return ($::Undef);
                }
            )
          )
    };
    1
}

