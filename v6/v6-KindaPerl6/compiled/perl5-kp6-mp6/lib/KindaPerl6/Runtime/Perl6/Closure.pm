{

    package Closure;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    # AUTHORS, COPYRIGHT: Please look at the source file.
    use v5;
    use strict;
    no strict "vars";
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    INIT { $_MODIFIED = {} }
    INIT { $_ = ::DISPATCH( $::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
    do {
        do {
            if ( ::DISPATCH( ::DISPATCH( ::DISPATCH( ( $GLOBAL::Code_VAR_defined = $GLOBAL::Code_VAR_defined || ::DISPATCH( $::Routine, "new", ) ), 'APPLY', $::Closure ), "true" ), "p5landish" ) ) { }
            else {
                do {
                    do {
                        ::MODIFIED($::Closure);
                        $::Closure = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Closure' ) ), 'PROTOTYPE', );
                        }
                    }
            }
        };
        ::DISPATCH( ::DISPATCH( $::Closure, 'HOW', ), 'add_attribute', ::DISPATCH( $::Str, 'new', 'code' ) );
        ::DISPATCH( ::DISPATCH( $::Closure, 'HOW', ), 'add_attribute', ::DISPATCH( $::Str, 'new', 'scope' ) );
        ::DISPATCH(
            ::DISPATCH( $::Closure, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'perl' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {

                        # emit_declarations
                        my $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $self;
                        $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) unless defined $self;
                        INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }

                        # get $self
                        $self = shift;

                        # emit_arguments
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        { my $_param_index = 0; }

                        # emit_body
                        ::DISPATCH( $::Str, 'new', 'sub { ... }' );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => bless(
                                {   'namespace' => [],
                                    'name'      => 'self',
                                    'twigil'    => '',
                                    'sigil'     => '$'
                                },
                                'Var'
                            ),
                            array  => ::DISPATCH( $::Array, "new", { _array => [] } ),
                            return => $::Undef,
                        }
                    ),
                }
            )
        );
        ::DISPATCH(
            ::DISPATCH( $::Closure, 'HOW', ),
            'add_method',
            ::DISPATCH( $::Str, 'new', 'Str' ),
            ::DISPATCH(
                $::Code, 'new',
                {   code => sub {

                        # emit_declarations
                        my $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } );
                        my $self;
                        $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) unless defined $self;
                        INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }

                        # get $self
                        $self = shift;

                        # emit_arguments
                        my $CAPTURE;
                        $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) unless defined $CAPTURE;
                        INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
                        ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                        do {
                            ::MODIFIED($List__);
                            $List__ = ::DISPATCH( $CAPTURE, 'array', );
                        };
                        do {
                            ::MODIFIED($Hash__);
                            $Hash__ = ::DISPATCH( $CAPTURE, 'hash', );
                        };
                        { my $_param_index = 0; }

                        # emit_body
                        ::DISPATCH( $::Str, 'new', 'sub { ... }' );
                    },
                    signature => ::DISPATCH(
                        $::Signature,
                        "new",
                        {   invocant => bless(
                                {   'namespace' => [],
                                    'name'      => 'self',
                                    'twigil'    => '',
                                    'sigil'     => '$'
                                },
                                'Var'
                            ),
                            array  => ::DISPATCH( $::Array, "new", { _array => [] } ),
                            return => $::Undef,
                        }
                    ),
                }
            )
        );
    };
    1
}
