{ package KindaPerl6::Visitor::Emit::AstHTML; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::KindaPerl6::Visitor::Emit::AstHTML )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::KindaPerl6::Visitor::Emit::AstHTML);
$::KindaPerl6::Visitor::Emit::AstHTML = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'KindaPerl6::Visitor::Emit::AstHTML' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::KindaPerl6::Visitor::Emit::AstHTML, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'visit' )
, ::DISPATCH( $::Code, 'new', { code => sub { my $result; $result = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$result' } )  unless defined $result; INIT { $result = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$result' } ) }
;
my $data; $data = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$data' } )  unless defined $data; INIT { $data = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$data' } ) }
;
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $node; $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } )  unless defined $node; INIT { $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } ) }
;
my $node_name; $node_name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node_name' } )  unless defined $node_name; INIT { $node_name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node_name' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'node'} )  { do {::MODIFIED($node);
$node = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'node' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $node = $List__->{_value}{_array}[ $_param_index++ ];  }  if ( exists $Hash__->{_value}{_hash}{'node_name'} )  { do {::MODIFIED($node_name);
$node_name = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'node_name' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $node_name = $List__->{_value}{_array}[ $_param_index++ ];  } } do {::MODIFIED($result);
$result = ::DISPATCH( $::Str, 'new', '' )
}; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '<span class="' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $Main::Code_mangle_ident, 'APPLY', $node_name )
, ::DISPATCH( $::Str, 'new', '">' )
 )
 )
 )
}; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '::' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $node_name, ::DISPATCH( $::Str, 'new', '( ' )
 )
 )
 )
}; do {::MODIFIED($data);
$data = ::DISPATCH( $node, 'attribs',  )
}; ::DISPATCH( ::DISPATCH( $GLOBAL::Code_keys, 'APPLY', ::DISPATCH( $GLOBAL::Code_prefix_58__60__37__62_, 'APPLY', $data )
 )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $item; $item = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$item' } )  unless defined $item; INIT { $item = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$item' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'item'} )  { do {::MODIFIED($item);
$item = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'item' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $item = $List__->{_value}{_array}[ $_param_index++ ];  } } do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', ' ' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $item, ::DISPATCH( $::Str, 'new', ' => ' )
 )
 )
 )
}; do { if (::DISPATCH(::DISPATCH(::DISPATCH( ::DISPATCH( $data, 'LOOKUP', $item )
, 'isa', ::DISPATCH( $::Str, 'new', 'Array' )
 )
,"true"),"p5landish") ) { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', '[ ' )
 )
}; ::DISPATCH( ::DISPATCH( $GLOBAL::Code_prefix_58__60__64__62_, 'APPLY', ::DISPATCH( $data, 'LOOKUP', $item )
 )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $subitem; $subitem = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$subitem' } )  unless defined $subitem; INIT { $subitem = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$subitem' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'subitem'} )  { do {::MODIFIED($subitem);
$subitem = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'subitem' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $subitem = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $subitem, 'isa', ::DISPATCH( $::Str, 'new', 'Array' )
 )
,"true"),"p5landish") ) { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', ' [ ... ], ' )
 )
} } }  else { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $subitem, 'emit', $self )
, ::DISPATCH( $::Str, 'new', ', ' )
 )
 )
} } } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'subitem', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', ' ], ' )
 )
} } }  else { do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( ::DISPATCH( $data, 'LOOKUP', $item )
, 'isa', ::DISPATCH( $::Str, 'new', 'Hash' )
 )
,"true"),"p5landish") ) { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', '{ ' )
 )
}; ::DISPATCH( ::DISPATCH( $GLOBAL::Code_keys, 'APPLY', ::DISPATCH( $GLOBAL::Code_prefix_58__60__37__62_, 'APPLY', ::DISPATCH( $data, 'LOOKUP', $item )
 )
 )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $subitem; $subitem = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$subitem' } )  unless defined $subitem; INIT { $subitem = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$subitem' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'subitem'} )  { do {::MODIFIED($subitem);
$subitem = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'subitem' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $subitem = $List__->{_value}{_array}[ $_param_index++ ];  } } do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $subitem, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', ' => ' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( ::DISPATCH( ::DISPATCH( $data, 'LOOKUP', $item )
, 'LOOKUP', $subitem )
, 'emit', $self )
, ::DISPATCH( $::Str, 'new', ', ' )
 )
 )
 )
 )
} }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'subitem', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', ' }, ' )
 )
} } }  else { do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( ::DISPATCH( $data, 'LOOKUP', $item )
, 'isa', ::DISPATCH( $::Str, 'new', 'Str' )
 )
,"true"),"p5landish") ) { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr( 39 ) )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $data, 'LOOKUP', $item )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', chr( 39 ) )
, ::DISPATCH( $::Str, 'new', ', ' )
 )
 )
 )
 )
} } }  else { do { do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $data, 'LOOKUP', $item )
, 'emit', $self )
, ::DISPATCH( $::Str, 'new', ', ' )
 )
 )
} } } }
 } } }
 } } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'item', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', ') ' )
 )
}; do {::MODIFIED($result);
$result = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $result, ::DISPATCH( $::Str, 'new', '</span>' )
 )
} }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
, ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node_name', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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