{ package KindaPerl6::Visitor::Emit::TokenC; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::KindaPerl6::Visitor::Emit::TokenC )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::KindaPerl6::Visitor::Emit::TokenC);
$::KindaPerl6::Visitor::Emit::TokenC = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'KindaPerl6::Visitor::Emit::TokenC' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::KindaPerl6::Visitor::Emit::TokenC, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'visit' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
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
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $node_name = $List__->{_value}{_array}[ $_param_index++ ];  } } ::DISPATCH( $node, 'emit_c',  )
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
{ package Token; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Token )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Token);
$::Token = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Token' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Token, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', 'match* ' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $Main::Code_mangle_ident, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $KindaPerl6::Visitor::Emit::Perl5::current_compunit, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '::' )
, ::DISPATCH( $self, "name" )
 )
 )
 )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', ' (char *str,int pos) {match* m = new_match(str,pos);m->boolean = (' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( ::DISPATCH( $self, "regex" )
, 'emit_c',  )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', ');m->to = pos;return m;}' )
, ::DISPATCH( $Main::Code_newline, 'APPLY',  )
 )
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
 }
; 1 }
{ package CompUnit; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::CompUnit )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::CompUnit);
$::CompUnit = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'CompUnit' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::CompUnit, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } do {::MODIFIED($KindaPerl6::Visitor::Emit::Perl5::current_compunit);
$KindaPerl6::Visitor::Emit::Perl5::current_compunit = ::DISPATCH( $self, "name" )
}; ::DISPATCH( ::DISPATCH( $self, "body" )
, 'emit_c',  )
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
{ package Lit::Code; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Lit::Code )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Lit::Code);
$::Lit::Code = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Lit::Code' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Lit::Code, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my $source; $source = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$source' } )  unless defined $source; INIT { $source = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$source' } ) }
;
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } do {::MODIFIED($source);
$source = ::DISPATCH( $::Str, 'new', '' )
}; ::DISPATCH( ::DISPATCH( $self, "body" )
, 'map', ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $node; $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } )  unless defined $node; INIT { $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } ) }
;
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( exists $Hash__->{_value}{_hash}{'node'} )  { do {::MODIFIED($node);
$node = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'node' )
 )
} }  elsif ( exists $List__->{_value}{_array}[ $_param_index ] )  { $node = $List__->{_value}{_array}[ $_param_index++ ];  } } do { if (::DISPATCH(::DISPATCH(::DISPATCH( $node, 'isa', ::DISPATCH( $::Str, 'new', 'Token' )
 )
,"true"),"p5landish") ) { do { do {::MODIFIED($source);
$source = ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $source, ::DISPATCH( $node, 'emit_c',  )
 )
} } }  else { ::DISPATCH($::Bit, "new", 0) } }
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::Array, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
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
; $source }, signature => ::DISPATCH( $::Signature, "new", { invocant => bless( {
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
{ package Rule::Or; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Or )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Or);
$::Rule::Or = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Or' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Or, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '({int saved_pos=pos;' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( [ map { $_->emit_c() } @{ ::DISPATCH( $self, "or" )
 } ]
, 'join', ::DISPATCH( $::Str, 'new', '||' )
 )
, ::DISPATCH( $::Str, 'new', '|| (pos=saved_pos,0);})' )
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
 }
; 1 }
{ package Rule::Concat; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Concat )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Concat);
$::Rule::Concat = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Concat' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Concat, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '(' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( [ map { $_->emit_c() } @{ ::DISPATCH( $self, "concat" )
 } ]
, 'join', ::DISPATCH( $::Str, 'new', '&&' )
 )
, ::DISPATCH( $::Str, 'new', ')' )
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
 }
; 1 }
{ package Rule::Constant; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Constant )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Constant);
$::Rule::Constant = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Constant' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Constant, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '(strncmp("' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $self, "constant" )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '",str+pos,' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_chars, 'APPLY', ::DISPATCH( $self, "constant" )
 )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', ') == 0 && (pos += ' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $GLOBAL::Code_chars, 'APPLY', ::DISPATCH( $self, "constant" )
 )
, ::DISPATCH( $::Str, 'new', '))' )
 )
 )
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
 }
; 1 }
{ package Rule::Block; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Block )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Block);
$::Rule::Block = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Block' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Block, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', 'printf("Rule::Block stub:' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $self, "closure" )
, ::DISPATCH( $::Str, 'new', '\\n")' )
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
 }
; 1 }
{ package Rule::Subrule; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Subrule )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Subrule);
$::Rule::Subrule = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Subrule' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Subrule, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '({match* submatch=' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $Main::Code_mangle_ident, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $KindaPerl6::Visitor::Emit::Perl5::current_compunit, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '::' )
, ::DISPATCH( $self, "metasyntax" )
 )
 )
 )
, ::DISPATCH( $::Str, 'new', '(str,pos);pos = submatch->to;int boolean = submatch->boolean;free(submatch);boolean;})' )
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
 }
; 1 }
{ package Rule::SubruleNoCapture; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::SubruleNoCapture )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::SubruleNoCapture);
$::Rule::SubruleNoCapture = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::SubruleNoCapture' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::SubruleNoCapture, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '({match* submatch=' )
, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $Main::Code_mangle_ident, 'APPLY', ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', $KindaPerl6::Visitor::Emit::Perl5::current_compunit, ::DISPATCH( $GLOBAL::Code_infix_58__60__126__62_, 'APPLY', ::DISPATCH( $::Str, 'new', '::' )
, ::DISPATCH( $self, "metasyntax" )
 )
 )
 )
, ::DISPATCH( $::Str, 'new', '(str,pos);pos = submatch->to;int boolean = submatch->boolean;free(submatch);boolean;})' )
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
 }
; 1 }
{ package Rule::Dot; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Dot )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Dot);
$::Rule::Dot = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Dot' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Dot, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $::Str, 'new', 'printf("Rule::Dot stub\\n")' )
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
{ package Rule::SpecialChar; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::SpecialChar )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::SpecialChar);
$::Rule::SpecialChar = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::SpecialChar' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::SpecialChar, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $::Str, 'new', 'printf("Rule::SpecialChar stub\\n")' )
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
{ package Rule::Before; 
# Do not edit this file - Perl 5 generated by KindaPerl6
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do { do { if (::DISPATCH(::DISPATCH(::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Rule::Before )
,"true"),"p5landish") ) { }  else { do { do {::MODIFIED($::Rule::Before);
$::Rule::Before = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'Rule::Before' )
 )
, 'PROTOTYPE',  )
} } } }
; ::DISPATCH( ::DISPATCH( $::Rule::Before, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'emit_c' )
, ::DISPATCH( $::Code, 'new', { code => sub { my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $self; $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } )  unless defined $self; INIT { $self = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$self' } ) }
;
$self = shift; my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));do {::MODIFIED($List__);
$List__ = ::DISPATCH( $CAPTURE, 'array',  )
};do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0; } ::DISPATCH( $::Str, 'new', 'printf("Rule::Before stub")' )
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
