{ package Range; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; BEGIN { $_MODIFIED = {} }
BEGIN { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Range )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Range);
$::Range = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Range' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_parent', ::DISPATCH( $::Value, 'HOW',  )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'start' )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'end' )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'perl' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; BEGIN { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '( ' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $self, "start" )
, 'perl',  )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '..' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $self, "end" )
, 'perl',  )
, ::DISPATCH( $::Str, 'new', ' )' )
 )
 )
 )
 )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => bless( {
                 'namespace' => [],
                 'name' => 'self',
                 'twigil' => '',
                 'sigil' => '$'
               }, 'Var' )
, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'Str' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; BEGIN { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $self, "start" )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '..' )
, ::DISPATCH( $self, "end" )
 )
 )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => bless( {
                 'namespace' => [],
                 'name' => 'self',
                 'twigil' => '',
                 'sigil' => '$'
               }, 'Var' )
, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'INDEX' )
, ::DISPATCH( $::Code, 'new', { code => sub { my $v; $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } )  unless defined $v; BEGIN { $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } ) }
;
my  $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $i; $i = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$i' } )  unless defined $i; BEGIN { $i = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$i' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'i'} )  { do {::MODIFIED($i);
$i = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'i' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $i = $List__->{_value}{_array}[ $_param_index++ ];  } } ::DISPATCH_VAR( $v, 'STORE', ::DISPATCH( $GLOBAL::Code_infix_58__60__43__62_, 'APPLY', $i, ::DISPATCH( $GLOBAL::Code_infix_58__60__45__62_, 'APPLY', ::DISPATCH( $self, "start" )
, ::DISPATCH( $::Int, 'new', 1 )
 )
 )
 )
; ::DISPATCH( $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__126__62_, 'APPLY', $v, $self )
, $v, $::Undef )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'i', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
,  ] } ), return   => $::Undef, } )
,  } )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'for' )
, ::DISPATCH( $::Code, 'new', { code => sub { my $arity; $arity = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$arity' } )  unless defined $arity; BEGIN { $arity = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$arity' } ) }
;
my $v; $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } )  unless defined $v; BEGIN { $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } ) }
;
my  $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $Code_code; $Code_code = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_code' } )  unless defined $Code_code; BEGIN { $Code_code = ::DISPATCH( $::Routine, 'new', { modified => $_MODIFIED, name => '$Code_code' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'code'} )  { do {::MODIFIED($Code_code);
$Code_code = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'code' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $Code_code = $List__->{_value}{_array}[ $_param_index++ ];  } } ::DISPATCH_VAR( $arity, 'STORE', ::DISPATCH( ::DISPATCH( $Code_code, 'signature',  )
, 'arity',  )
 )
; ::DISPATCH_VAR( $v, 'STORE', ::DISPATCH( $self, "start" )
 )
; do { while (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__60__61__62_, 'APPLY', $v, ::DISPATCH( $self, "end" )
 )
,"true"),"p5landish") )  { do { my  $List_param = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List_param' } ) ; 
;
$List_param; do { while (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__60__62_, 'APPLY', ::DISPATCH( $List_param, 'elems',  )
, $arity )
,"true"),"p5landish") )  { do { ::DISPATCH( $List_param, 'push', ::DISPATCH( $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__60__61__62_, 'APPLY', $v, ::DISPATCH( $self, "end" )
 )
, $v, $::Undef )
 )
; ::DISPATCH_VAR( $v, 'STORE', ::DISPATCH( $GLOBAL::Code_infix_58__60__43__62_, 'APPLY', $v, ::DISPATCH( $::Int, 'new', 1 )
 )
 )
 } } }
; ::DISPATCH( $Code_code, 'APPLY', ::DISPATCH( $GLOBAL::Code_prefix_58__60__124__62_, 'APPLY', $List_param )
 )
 } } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '&', twigil => '', name   => 'code', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
,  ] } ), return   => $::Undef, } )
,  } )
 )
; ::DISPATCH( ::DISPATCH( $::Range, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'smartmatch' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::Array, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $v; $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } )  unless defined $v; BEGIN { $v = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$v' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; BEGIN { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'v'} )  { do {::MODIFIED($v);
$v = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'v' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $v = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__60__62_, 'APPLY', $v, ::DISPATCH( $self, "start" )
 )
,"true"),"p5landish") ) { do { return(::DISPATCH( $::Bit, 'new', 0 )
)
 } }  else { ::DISPATCH($::Bit, "new", 0) } }
; do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__62__62_, 'APPLY', $v, ::DISPATCH( $self, "end" )
 )
,"true"),"p5landish") ) { do { return(::DISPATCH( $::Bit, 'new', 0 )
)
 } }  else { ::DISPATCH($::Bit, "new", 0) } }
; return(::DISPATCH( $::Bit, 'new', 1 )
)
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'v', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
,  ] } ), return   => $::Undef, } )
,  } )
 )
 }
; 1 }
