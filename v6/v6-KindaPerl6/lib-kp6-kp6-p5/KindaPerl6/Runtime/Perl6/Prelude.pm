{

    package GLOBAL;

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
        our $Code_all =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_all' } );
        our $Code_any =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_any' } );
        our $Code_none =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_none' } );
        our $Code_one =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_one' } );
        our $Code_infix_58__60__124__62_ = ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_infix_58__60__124__62_' }
        );
        our $Code_infix_58__60__38__62_ =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_infix_58__60__38__62_' } );
        our $Code_infix_58__60__94__62_ =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_infix_58__60__94__62_' } );
        our $Code_mkdir =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_mkdir' } );
        our $Code_rmdir =
          ::DISPATCH( $::Routine, 'new',
            { modified => $_MODIFIED, name => '$Code_rmdir' } );
        do {

            if (
                ::DISPATCH(
                    ::DISPATCH(
                        ::DISPATCH(
                            $GLOBAL::Code_VAR_defined, 'APPLY', $::GLOBAL
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
                    our $Code_all =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_all' } );
                    our $Code_any =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_any' } );
                    our $Code_none =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_none' } );
                    our $Code_one =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_one' } );
                    our $Code_infix_58__60__124__62_ = ::DISPATCH(
                        $::Routine,
                        'new',
                        {
                            modified => $_MODIFIED,
                            name     => '$Code_infix_58__60__124__62_'
                        }
                    );
                    our $Code_infix_58__60__38__62_ = ::DISPATCH(
                        $::Routine,
                        'new',
                        {
                            modified => $_MODIFIED,
                            name     => '$Code_infix_58__60__38__62_'
                        }
                    );
                    our $Code_infix_58__60__94__62_ = ::DISPATCH(
                        $::Routine,
                        'new',
                        {
                            modified => $_MODIFIED,
                            name     => '$Code_infix_58__60__94__62_'
                        }
                    );
                    our $Code_mkdir =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_mkdir' } );
                    our $Code_rmdir =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_rmdir' } );
                    do {
                        ::MODIFIED($::GLOBAL);
                        $::GLOBAL = ::DISPATCH(
                            ::DISPATCH(
                                $::Class, 'new',
                                ::DISPATCH( $::Str, 'new', 'GLOBAL' )
                            ),
                            'PROTOTYPE',
                        );
                      }
                }
            }
        };
        do {
            ::MODIFIED($Code_all);
            $Code_all = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $junc;
                        $junc =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$junc' } )
                          unless defined $junc;

                        BEGIN {
                            $junc =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$junc' } );
                        }
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH_VAR( $junc, 'STORE',
                            ::DISPATCH( $::Junction, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $junc, 'things', ),
                            'STORE', $List__ );
                        ::DISPATCH_VAR(
                            ::DISPATCH( $junc, 'type', ),
                            'STORE',
                            ::DISPATCH( $::Str, 'new', 'all' )
                        );
                        $junc;
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_any);
            $Code_any = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $junc;
                        $junc =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$junc' } )
                          unless defined $junc;

                        BEGIN {
                            $junc =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$junc' } );
                        }
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH_VAR( $junc, 'STORE',
                            ::DISPATCH( $::Junction, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $junc, 'things', ),
                            'STORE', $List__ );
                        ::DISPATCH_VAR(
                            ::DISPATCH( $junc, 'type', ),
                            'STORE',
                            ::DISPATCH( $::Str, 'new', 'any' )
                        );
                        $junc;
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_none);
            $Code_none = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $junc;
                        $junc =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$junc' } )
                          unless defined $junc;

                        BEGIN {
                            $junc =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$junc' } );
                        }
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH_VAR( $junc, 'STORE',
                            ::DISPATCH( $::Junction, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $junc, 'things', ),
                            'STORE', $List__ );
                        ::DISPATCH_VAR(
                            ::DISPATCH( $junc, 'type', ),
                            'STORE',
                            ::DISPATCH( $::Str, 'new', 'none' )
                        );
                        $junc;
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_one);
            $Code_one = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $junc;
                        $junc =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$junc' } )
                          unless defined $junc;

                        BEGIN {
                            $junc =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$junc' } );
                        }
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH_VAR( $junc, 'STORE',
                            ::DISPATCH( $::Junction, 'new', ) );
                        ::DISPATCH_VAR( ::DISPATCH( $junc, 'things', ),
                            'STORE', $List__ );
                        ::DISPATCH_VAR(
                            ::DISPATCH( $junc, 'type', ),
                            'STORE',
                            ::DISPATCH( $::Str, 'new', 'one' )
                        );
                        $junc;
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_infix_58__60__124__62_);
            $Code_infix_58__60__124__62_ = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $a;
                        $a =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$a' } )
                          unless defined $a;

                        BEGIN {
                            $a =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$a' } );
                        }
                        my $b;
                        $b =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$b' } )
                          unless defined $b;

                        BEGIN {
                            $b =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$b' } );
                        }
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($a);
                            $a =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            ::MODIFIED($b);
                            $b =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 1 ) );
                        };
                        ::DISPATCH( $Code_any, 'APPLY', $a, $b );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array    => ::DISPATCH(
                                $::Array, "new",
                                {
                                    _array => [
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'a',
                                            }
                                        ),
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'b',
                                            }
                                        ),
                                    ]
                                }
                            ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_infix_58__60__38__62_);
            $Code_infix_58__60__38__62_ = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $a;
                        $a =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$a' } )
                          unless defined $a;

                        BEGIN {
                            $a =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$a' } );
                        }
                        my $b;
                        $b =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$b' } )
                          unless defined $b;

                        BEGIN {
                            $b =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$b' } );
                        }
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($a);
                            $a =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            ::MODIFIED($b);
                            $b =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 1 ) );
                        };
                        ::DISPATCH( $Code_all, 'APPLY', $a, $b );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array    => ::DISPATCH(
                                $::Array, "new",
                                {
                                    _array => [
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'a',
                                            }
                                        ),
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'b',
                                            }
                                        ),
                                    ]
                                }
                            ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_infix_58__60__94__62_);
            $Code_infix_58__60__94__62_ = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $a;
                        $a =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$a' } )
                          unless defined $a;

                        BEGIN {
                            $a =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$a' } );
                        }
                        my $b;
                        $b =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$b' } )
                          unless defined $b;

                        BEGIN {
                            $b =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$b' } );
                        }
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($a);
                            $a =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 0 ) );
                        };
                        do {
                            ::MODIFIED($b);
                            $b =
                              ::DISPATCH( $List__, 'INDEX',
                                ::DISPATCH( $::Int, 'new', 1 ) );
                        };
                        ::DISPATCH( $Code_one, 'APPLY', $a, $b );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array    => ::DISPATCH(
                                $::Array, "new",
                                {
                                    _array => [
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'a',
                                            }
                                        ),
                                        ::DISPATCH(
                                            $::Signature::Item,
                                            "new",
                                            {
                                                sigil  => '$',
                                                twigil => '',
                                                name   => 'b',
                                            }
                                        ),
                                    ]
                                }
                            ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_mkdir);
            $Code_mkdir = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH( $::IO, 'mkdir', $List__ );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
        };
        do {
            ::MODIFIED($Code_rmdir);
            $Code_rmdir = ::DISPATCH(
                $::Code, 'new',
                {
                    code => sub {
                        my $List__ =
                          ::DISPATCH( $::Array, 'new',
                            { modified => $_MODIFIED, name => '$List__' } );
                        my $CAPTURE;
                        $CAPTURE =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$CAPTURE' } )
                          unless defined $CAPTURE;

                        BEGIN {
                            $CAPTURE = ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$CAPTURE' }
                            );
                        }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        ::DISPATCH( $::IO, 'rmdir', $List__ );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {
                            invocant => $::Undef,
                            array =>
                              ::DISPATCH( $::Array, "new", { _array => [] } ),
                            hash =>
                              ::DISPATCH( $::Hash, "new", { _hash => {} } ),
                            return => $::Undef,
                        }
                    ),
                }
            );
          }
    };
    1
}

