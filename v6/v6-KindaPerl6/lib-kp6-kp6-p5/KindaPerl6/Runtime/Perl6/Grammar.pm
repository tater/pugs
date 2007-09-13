{

    package Grammar;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::KP6Runtime;
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
                            $GLOBAL::Code_VAR_defined, 'APPLY', $::Grammar
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
                        ::MODIFIED($::Grammar);
                        $::Grammar = ::DISPATCH(
                            ::DISPATCH(
                                $::Class, 'new',
                                ::DISPATCH( $::Str, 'new', 'Grammar' )
                            ),
                            'PROTOTYPE',
                        );
                      }
                }
            }
        };
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'space' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '[[:space:]]' ),
                        $string, $pos );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'word' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '[[:word:]' ),
                        $string, $pos );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'digit' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '[[:digit:]' ),
                        $string, $pos );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'backslash' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '\\\\' ),
                        $string, $pos );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'newline' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '(?m)(\\n\\r?|\\r\\n?)' ),
                        $string, $pos );
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Grammar, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'not_newline' ),
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
                    my $string;
                    $string =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$string' } )
                      unless defined $string;

                    BEGIN {
                        $string =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$string' } );
                    }
                    my $pos;
                    $pos =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$pos' } )
                      unless defined $pos;

                    BEGIN {
                        $pos =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$pos' } );
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
                        ::MODIFIED($string);
                        $string =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 0 ) );
                    };
                    do {
                        ::MODIFIED($pos);
                        $pos =
                          ::DISPATCH( $List__, 'INDEX',
                            ::DISPATCH( $::Int, 'new', 1 ) );
                    };
                    ::DISPATCH( $GLOBAL::Code_match_p5rx, 'APPLY',
                        ::DISPATCH( $::Str, 'new', '.' ),
                        $string, $pos );
                }
            )
          )
    };
    1
}
