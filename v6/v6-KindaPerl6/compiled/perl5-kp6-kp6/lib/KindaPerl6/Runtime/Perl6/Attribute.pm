{ package Attribute; 
# Do not edit this file - Perl 5 generated by KindaPerl6
# AUTHORS, COPYRIGHT: Please look at the source file.
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do {do { if (::DISPATCH(::DISPATCH(::DISPATCH(  ( $GLOBAL::Code_VAR_defined = $GLOBAL::Code_VAR_defined || ::DISPATCH( $::Routine, "new", )  ) 
, 'APPLY', $::Attribute )
,"true"),"p5landish") ) { do {} }  else { do {do {::MODIFIED($::Attribute);
$::Attribute = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Attribute' )
 )
, 'PROTOTYPE',  )
}} } }
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'name' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'type' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'scope' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'rw' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'private' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'accessor' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'build' )
 )
; ::DISPATCH( ::DISPATCH( $::Attribute, 'HOW',  )
, 'add_attribute', ::DISPATCH( $::Str, 'new', 'readonly' )
 )
}
; 1 }
