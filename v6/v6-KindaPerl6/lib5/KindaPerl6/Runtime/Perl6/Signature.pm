{

    package Signature;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }

    BEGIN {
        $_ =
          ::DISPATCH( $::Scalar, "new",
            { modified => $_MODIFIED, name => "$_" } );
    }
    do {
        if (
            ::DISPATCH(
                ::DISPATCH(
                    ::DISPATCH(
                        $GLOBAL::Code_VAR_defined, 'APPLY', $::Signature
                    ),
                    "true"
                ),
                "p5landish"
            )
          )
        {
        }
        else {
            ::MODIFIED($::Signature);
            $::Signature = ::DISPATCH(
                ::DISPATCH(
                    $::Class, 'new',
                    ::DISPATCH( $::Str, 'new', 'Signature' )
                ),
                'PROTOTYPE',
            );
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
                $List__->{_value}{_array} = \@_;
                ::DISPATCH(
                    $GLOBAL::Code_infix_58__60__126__62_,
                    'APPLY',
                    ::DISPATCH( $::Str, 'new', ':( ' ),
                    ::DISPATCH(
                        $GLOBAL::Code_infix_58__60__126__62_,
                        'APPLY',
                        ::DISPATCH( ::DISPATCH( $self, "invocant" ), 'perl', ),
                        ::DISPATCH(
                            $GLOBAL::Code_infix_58__60__126__62_,
                            'APPLY',
                            ::DISPATCH( $::Str, 'new', ': ' ),
                            ::DISPATCH(
                                $GLOBAL::Code_infix_58__60__126__62_,
                                'APPLY',
                                ::DISPATCH(
                                    $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_,
                                    'APPLY',
                                    ::DISPATCH(
                                        ::DISPATCH( $self, "array" ), 'elems',
                                    ),
                                    ::DISPATCH(
                                        $GLOBAL::Code_infix_58__60__126__62_,
                                        'APPLY',
                                        ::DISPATCH(
                                            ::DISPATCH( $self, "array" ),
                                            'perl',
                                        ),
                                        ::DISPATCH( $::Str, 'new', ', ' )
                                    ),
                                    ::DISPATCH( $::Str, 'new', '' )
                                ),
                                ::DISPATCH(
                                    $GLOBAL::Code_infix_58__60__126__62_,
                                    'APPLY',
                                    ::DISPATCH(
                                        $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_,
                                        'APPLY',
                                        ::DISPATCH(
                                            ::DISPATCH( $self, "hash" ),
                                            'elems',
                                        ),
                                        ::DISPATCH(
                                            ::DISPATCH( $self, "hash" ), 'perl',
                                        ),
                                        ::DISPATCH( $::Str, 'new', '' )
                                    ),
                                    ::DISPATCH( $::Str, 'new', ' )' )
                                )
                            )
                        )
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
                $List__->{_value}{_array} = \@_;
                ::DISPATCH( $self, 'perl', );
            }
        )
    );
    1
}

