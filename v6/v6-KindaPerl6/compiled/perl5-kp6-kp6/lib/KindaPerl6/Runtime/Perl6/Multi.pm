{ package Multi; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do {do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Multi )
,"true"),"p5landish") ) { }  else { do {do {::MODIFIED($::Multi);
$::Multi = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Multi' )
 )
, 'PROTOTYPE',  )
}} } }
; ::DISPATCH( ::DISPATCH( $::Multi, 'HOW',  )
, 'add_parent', ::DISPATCH( $::Code, 'HOW',  )
 )
; ::DISPATCH( ::DISPATCH( $::Multi, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'long_names' )
 )
; ::DISPATCH( ::DISPATCH( $::Multi, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'add_variant' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $code; $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } )  unless defined $code; INIT { $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'code'} )  { do {::MODIFIED($code);
$code = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'code' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $code = $List__->{_value}{_array}[ $_param_index++ ];  } } 
# emit_body
do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'long_names',  )
 )
 )
,"true"),"p5landish") ) { do {::DISPATCH_VAR( ::DISPATCH( $self, 'long_names',  )
, 'STORE', ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 )
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; ::DISPATCH( ::DISPATCH( $self, 'long_names',  )
, 'push', $code )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'code', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; ::DISPATCH( ::DISPATCH( $::Multi, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'select' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List_candidates = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List_candidates' } ) ; 
;
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $capture; $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } )  unless defined $capture; INIT { $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'capture'} )  { do {::MODIFIED($capture);
$capture = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'capture' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $capture = $List__->{_value}{_array}[ $_param_index++ ];  } } 
# emit_body
do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'long_names',  )
 )
 )
,"true"),"p5landish") ) { do {::DISPATCH( $GLOBAL::Code_die, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', 'can' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr( 39 ) )
, ::DISPATCH( $::Str, 'new', 't resolve Multi dispatch' )
 )
 )
 )
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; ::DISPATCH_VAR( $List_candidates, 'STORE', ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 )
; ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__64__62_, 'APPLY', ::DISPATCH( $self, 'long_names',  )
 )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $sub; $sub = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sub' } )  unless defined $sub; INIT { $sub = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sub' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'sub'} )  { do {::MODIFIED($sub);
$sub = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'sub' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $sub = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__61__61__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $sub, 'signature',  )
, 'arity',  )
, ::DISPATCH( $capture, 'arity',  )
 )
,"true"),"p5landish") ) { do {::DISPATCH( $List_candidates, 'push', $sub )
} }  else { ::DISPATCH($::Bit, "new", 0) } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'sub', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__61__61__62_, 'APPLY', ::DISPATCH( $List_candidates, 'elems',  )
, ::DISPATCH( $::Int, 'new', 1 )
 )
,"true"),"p5landish") ) { do {return(::DISPATCH( $List_candidates, 'INDEX', ::DISPATCH( $::Int, 'new', 0 )
 )
)
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; ::DISPATCH( $GLOBAL::Code_die, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', 'can' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr( 39 ) )
, ::DISPATCH( $::Str, 'new', 't resolve Multi dispatch' )
 )
 )
 )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'capture', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; ::DISPATCH( ::DISPATCH( $::Multi, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'perl' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } 
# emit_body
::DISPATCH( $::Str, 'new', 'Multi.new()' )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => bless( {
                 'namespace' => [],
                 'name' => 'self',
                 'twigil' => '',
                 'sigil' => '$'
               }, 'Var' )
, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
}
; 1 }
{ package MultiToken; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do {do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::MultiToken )
,"true"),"p5landish") ) { }  else { do {do {::MODIFIED($::MultiToken);
$::MultiToken = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'MultiToken' )
 )
, 'PROTOTYPE',  )
}} } }
; ::DISPATCH( ::DISPATCH( $::MultiToken, 'HOW',  )
, 'add_parent', ::DISPATCH( $::Code, 'HOW',  )
 )
; ::DISPATCH( ::DISPATCH( $::MultiToken, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'token_length' )
 )
; ::DISPATCH( ::DISPATCH( $::MultiToken, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'add_token_variant' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my $len; $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } )  unless defined $len; INIT { $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) }
;
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $code; $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } )  unless defined $code; INIT { $code = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$code' } ) }
;
my $sym; $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } )  unless defined $sym; INIT { $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'code'} )  { do {::MODIFIED($code);
$code = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'code' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $code = $List__->{_value}{_array}[ $_param_index++ ];  }  if ( exists $Hash__->{_value}{_hash}{'sym'} )  { do {::MODIFIED($sym);
$sym = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'sym' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $sym = $List__->{_value}{_array}[ $_param_index++ ];  } } 
# emit_body
::DISPATCH_VAR( $len, 'STORE', ::DISPATCH( $sym, 'chars',  )
 )
; do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'token_length',  )
 )
 )
,"true"),"p5landish") ) { do {::DISPATCH_VAR( ::DISPATCH( $self, 'token_length',  )
, 'STORE', ::DISPATCH( $::Hash, 'new', { _hash => {  } }
 )
 )
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_prefix_58__60__33__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'LOOKUP', $len )
 )
 )
,"true"),"p5landish") ) { do {::DISPATCH_VAR( ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'LOOKUP', $len )
, 'STORE', ::DISPATCH( $::Hash, 'new', { _hash => {  } }
 )
 )
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; ::DISPATCH_VAR( ::DISPATCH( ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'LOOKUP', $len )
, 'LOOKUP', $sym )
, 'STORE', ::DISPATCH( $::Multi, 'new',  )
 )
; ::DISPATCH( ::DISPATCH( ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'LOOKUP', $len )
, 'LOOKUP', $sym )
, 'add_variant', $code )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'code', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
, ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'sym', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; ::DISPATCH( ::DISPATCH( $::MultiToken, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'select' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $capture; $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } )  unless defined $capture; INIT { $capture = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$capture' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'capture'} )  { do {::MODIFIED($capture);
$capture = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'capture' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $capture = $List__->{_value}{_array}[ $_param_index++ ];  } } 
# emit_body
do { if (::DISPATCH(::DISPATCH(::DISPATCH( $capture, 'isa', ::DISPATCH( $::Str, 'new', 'Capture' )
 )
,"true"),"p5landish") ) { }  else { do {::DISPATCH( $GLOBAL::Code_die, 'APPLY', ::DISPATCH( $::Str, 'new', 'the parameter to Multi.select must be a Capture' )
 )
} } }
; do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__38__38__62_, 'APPLY', ::DISPATCH( $::Code, 'new', { code => sub { my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_defined, 'APPLY', ::DISPATCH( $self, 'token_length',  )
 )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
, ::DISPATCH( $::Code, 'new', { code => sub { my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'keys',  )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
,"true"),"p5landish") ) { do {my  $List_len = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List_len' } ) ; 
;
::DISPATCH_VAR( $List_len, 'STORE', ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'keys',  )
 )
; ::DISPATCH_VAR( $List_len, 'STORE', ::DISPATCH( $List_len, 'sort', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__60__61__62__62_, 'APPLY', ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 1 )
 )
, ::DISPATCH( $List__, 'INDEX', ::DISPATCH( $::Int, 'new', 0 )
 )
 )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
 )
; ::DISPATCH( $List_len, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $len; $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } )  unless defined $len; INIT { $len = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$len' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'len'} )  { do {::MODIFIED($len);
$len = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'len' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $len = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60__62__61__62_, 'APPLY', ::DISPATCH( $_, 'chars',  )
, $len )
,"true"),"p5landish") ) { do {my $s; $s = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$s' } )  unless defined $s; INIT { $s = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$s' } ) }
;
my  $Hash_syms = ::DISPATCH( $::HashContainer, 'new', { modified => $_MODIFIED, name => '$Hash_syms' } ) ; 
;
::DISPATCH_VAR( $s, 'STORE', ::DISPATCH( $GLOBAL::Code_substr, 'APPLY', $_, ::DISPATCH( $::Int, 'new', 0 )
, $len )
 )
; ::DISPATCH_VAR( $Hash_syms, 'STORE', ::DISPATCH( ::DISPATCH( $self, 'token_length',  )
, 'LOOKUP', $len )
 )
; ::DISPATCH( ::DISPATCH( $Hash_syms, 'keys',  )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $sym; $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } )  unless defined $sym; INIT { $sym = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$sym' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'sym'} )  { do {::MODIFIED($sym);
$sym = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'sym' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $sym = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_infix_58__60_eq_62_, 'APPLY', $s, $sym )
,"true"),"p5landish") ) { do {return(::DISPATCH( ::DISPATCH( $Hash_syms, 'LOOKUP', $sym )
, 'select', $capture )
)
} }  else { ::DISPATCH($::Bit, "new", 0) } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'sym', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
} }  else { ::DISPATCH($::Bit, "new", 0) } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'len', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
} }  else { ::DISPATCH($::Bit, "new", 0) } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'capture', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; ::DISPATCH( ::DISPATCH( $::MultiToken, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'perl' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } 
# emit_body
::DISPATCH( $::Str, 'new', 'MultiToken.new()' )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => bless( {
                 'namespace' => [],
                 'name' => 'self',
                 'twigil' => '',
                 'sigil' => '$'
               }, 'Var' )
, array    => ::DISPATCH( $::Array, "new", { _array => [  ] } ), return   => $::Undef, } )
,  } )
 )
}
; 1 }
