# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Visitor::EmitLisp;
sub new { shift; bless { @_ }, "KindaPerl6::Visitor::EmitLisp" }
sub visit { my $self = shift; my $List__ = \@_; my $node; do {  $node = $List__->[0]; [$node] }; $node->emit_lisp($self->{visitor_args}->{'secure'}) }


;
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub set_secure_mode { my $List__ = \@_; my $args_secure; do {  $args_secure = $List__->[0]; [$args_secure] }; my  $value = '0'; do { if (($args_secure != 0)) { $value = '1' } else {  } }; return(('(defconstant +KP6_DISABLE_INSECURE_CODE+ ' . ($value . (')' . Main::newline())))) };
sub emit_lisp { my $self = shift; my $List__ = \@_; my $args_secure; do {  $args_secure = $List__->[0]; [$args_secure] }; ('(defpackage :' . ($self->{name} . (')' . (Main::newline() . ('(in-package :' . ($self->{name} . (')' . (Main::newline() . (';; Do not edit this file - Lisp generated by ' . ($Main::_V6_COMPILER_NAME . (Main::newline() . (set_secure_mode($args_secure) . ('use ' . (Main::get_compiler_target_runtime() . (';' . (Main::newline() . ('my $_MODIFIED; BEGIN { $_MODIFIED = {} }' . (Main::newline() . ('BEGIN { ' . ('$_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); ' . ('}' . (Main::newline() . ($self->{body}->emit_lisp() . (Main::newline() . ('; 1 }' . Main::newline()))))))))))))))))))))))))) }


;
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Int :value ' . ($self->{int} . (')' . Main::newline()))) }


;
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Bit :value ' . ($self->{bit} . (')' . Main::newline()))) }


;
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Num :value ' . ($self->{num} . (')' . Main::newline()))) }


;
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Str :value ' . ('"' . (Main::mangle_string($self->{buf}) . ('"' . (')' . Main::newline()))))) }


;
package Val::Char;
sub new { shift; bless { @_ }, "Val::Char" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Str :value (code-char ' . ($self->{char} . (') )' . Main::newline()))) }


;
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Undef )' . Main::newline()) }


;
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; die('Emitting of Val::Object not implemented') }


;
package Native::Buf;
sub new { shift; bless { @_ }, "Native::Buf" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; die('Emitting of Native::Buf not implemented') }


;
package Lit::Seq;
sub new { shift; bless { @_ }, "Lit::Seq" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(' . (Main::join([ map { $_->emit_lisp() } @{ $self->{seq} } ], ', ') . ')')) }


;
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Array :value (list ' . (Main::join([ map { $_->emit_lisp() } @{ $self->{array} } ], ' ') . (') )' . Main::newline()))) }


;
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $fields = $self->{hash}; my  $str = ''; my  $field; do { for my $field ( @{$fields} ) { $str = ($str . ('(setf (gethash \'' . ($field->[0]->emit_lisp() . (') ' . ($field->[1]->emit_lisp() . ')'))))) } }; ('(make-instance \'Hash :value ' . ('(let ((hash (make-hash-table))) ' . ($str . (' hash)' . (')' . Main::newline()))))) }


;
package Lit::Pair;
sub new { shift; bless { @_ }, "Lit::Pair" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('(make-instance \'Pair :key ' . ($self->{key}->emit_lisp() . (' :value ' . ($self->{value}->emit_lisp() . (')' . Main::newline()))))) }


;
package Lit::NamedArgument;
sub new { shift; bless { @_ }, "Lit::NamedArgument" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( $::NamedArgument, \'new\', ' . ('{ _argument_name_ => ' . ($self->{key}->emit_lisp() . (', value => ' . ($self->{value}->emit_lisp() . (' } )' . Main::newline())))))) }


;
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('{ ' . ($self->emit_declarations() . ($self->emit_body() . ' }'))) };
sub emit_body { my $self = shift; my $List__ = \@_; do { [] }; Main::join([ map { $_->emit_lisp() } @{ $self->{body} } ], '; ') };
sub emit_signature { my $self = shift; my $List__ = \@_; do { [] }; $self->{sig}->emit_lisp() };
sub emit_declarations { my $self = shift; my $List__ = \@_; do { [] }; my  $s; my  $name; do { for my $name ( @{$self->{pad}->variable_names()} ) { my  $decl = Decl->new( 'decl' => 'my','type' => '','var' => Var->new( 'sigil' => '','twigil' => '','name' => $name,'namespace' => [], ), );$s = ($s . ($name->emit_lisp() . (';' . Main::newline()))) } }; return($s) };
sub emit_arguments { my $self = shift; my $List__ = \@_; do { [] }; my  $array_ = Var->new( 'sigil' => '@','twigil' => '','name' => '_','namespace' => [], ); my  $hash_ = Var->new( 'sigil' => '%','twigil' => '','name' => '_','namespace' => [], ); my  $CAPTURE = Var->new( 'sigil' => '$','twigil' => '','name' => 'CAPTURE','namespace' => [], ); my  $CAPTURE_decl = Decl->new( 'decl' => 'my','type' => '','var' => $CAPTURE, ); my  $str = ''; $str = ($str . $CAPTURE_decl->emit_lisp()); $str = ($str . '::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));'); my  $bind_ = Bind->new( 'parameters' => $array_,'arguments' => Call->new( 'invocant' => $CAPTURE,'method' => 'array','arguments' => [], ), ); $str = ($str . ($bind_->emit_lisp() . ';')); my  $bind_hash = Bind->new( 'parameters' => $hash_,'arguments' => Call->new( 'invocant' => $CAPTURE,'method' => 'hash','arguments' => [], ), ); $str = ($str . ($bind_hash->emit_lisp() . ';')); my  $i = 0; my  $field; do { for my $field ( @{$self->{sig}->positional()} ) { my  $bind = Bind->new( 'parameters' => $field,'arguments' => Index->new( 'obj' => $array_,'index' => Val::Int->new( 'int' => $i, ), ), );$str = ($str . ($bind->emit_lisp() . ';'));$i = ($i + 1) } }; return($str) }


;
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $fields = $self->{fields}; my  $str = ''; my  $field; do { for my $field ( @{$fields} ) { $str = ($str . ($field->[0]->emit_lisp() . (' => ' . ($field->[1]->emit_lisp() . ',')))) } }; ('::DISPATCH( $::' . ($self->{class} . (', \'new\', ' . ($str . (' )' . Main::newline()))))) }


;
package Index;
sub new { shift; bless { @_ }, "Index" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( ' . ($self->{obj}->emit_lisp() . (', \'INDEX\', ' . ($self->{index}->emit_lisp() . (' )' . Main::newline()))))) }


;
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( ' . ($self->{obj}->emit_lisp() . (', \'LOOKUP\', ' . ($self->{index}->emit_lisp() . (' )' . Main::newline()))))) }


;
package Assign;
sub new { shift; bless { @_ }, "Assign" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $node = $self->{parameters}; do { if ((Main::isa($node, 'Var') && @{$node->namespace()})) { $node = Apply->new( 'code' => Var->new( 'name' => 'ternary:<?? !!>','twigil' => '','sigil' => '&','namespace' => ['GLOBAL'], ),'arguments' => [Apply->new( 'arguments' => [$node],'code' => Var->new( 'name' => 'VAR_defined','twigil' => '','sigil' => '&','namespace' => ['GLOBAL'], ), ), $node, Bind->new( 'parameters' => $node,'arguments' => Call->new( 'invocant' => Var->new( 'name' => '::Scalar','twigil' => '','sigil' => '$','namespace' => [], ),'method' => 'new','hyper' => '', ), )], ) } else {  } }; ('::DISPATCH_VAR( ' . ($node->emit_lisp() . (', \'STORE\', ' . ($self->{arguments}->emit_lisp() . (' )' . Main::newline()))))) }


;
package Var;
sub new { shift; bless { @_ }, "Var" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $table = { '$' => '$','@' => '$List_','%' => '$Hash_','&' => '$Code_', }; do { if (($self->{twigil} eq '.')) { return(('::DISPATCH( $self, "' . ($self->{name} . ('" )' . Main::newline())))) } else {  } }; do { if (($self->{name} eq '/')) { return(($table->{$self->{sigil}} . 'MATCH')) } else {  } }; return(Main::mangle_name($self->{sigil}, $self->{twigil}, $self->{name}, $self->{namespace})) };
sub perl { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( $::Signature::Item, "new", { ' . ('sigil  => \'' . ($self->{sigil} . ('\', ' . ('twigil => \'' . ($self->{twigil} . ('\', ' . ('name   => \'' . ($self->{name} . ('\', ' . ('namespace => [ ], ' . ('} )' . Main::newline())))))))))))) }


;
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; do { if (Main::isa($self->{parameters}, 'Call')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp()) } else {  } }; do { if (Main::isa($self->{parameters}, 'Lookup')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp()) } else {  } }; do { if (Main::isa($self->{parameters}, 'Index')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp()) } else {  } }; my  $str = ('::MODIFIED(' . ($self->{parameters}->emit_lisp() . (');' . Main::newline()))); $str = ($str . ($self->{parameters}->emit_lisp() . (' = ' . $self->{arguments}->emit_lisp()))); return(('do {' . ($str . '}'))) }


;
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; return(('$::' . $self->{name})) }


;
package Call;
sub new { shift; bless { @_ }, "Call" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $invocant; do { if (Main::isa($self->{invocant}, 'Proto')) { do { if (($self->{invocant}->name() eq 'self')) { $invocant = '$self' } else { $invocant = $self->{invocant}->emit_lisp() } } } else { $invocant = $self->{invocant}->emit_lisp() } }; do { if (($invocant eq 'self')) { $invocant = '$self' } else {  } }; my  $meth = $self->{method}; do { if (($meth eq 'postcircumfix:<( )>')) { $meth = '' } else {  } }; my  $call = Main::join([ map { $_->emit_lisp() } @{ $self->{arguments} } ], ', '); do { if ($self->{hyper}) { ('[ map { $_' . ('->' . ($meth . ('(' . ($call . (') } @{ ' . ($invocant . (' } ]' . Main::newline())))))))) } else { do { if (($meth eq '')) { ('::DISPATCH( ' . ($invocant . (', \'APPLY\', ' . ($call . (' )' . Main::newline()))))) } else { ('::DISPATCH( ' . ($invocant . (', ' . ('\'' . ($meth . ('\', ' . ($call . (' )' . Main::newline())))))))) } } } } }


;
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; do { if (($self->{code}->name() eq 'self')) { return('$self') } else {  } }; my  $op = $self->{code}->emit_lisp(); do { if (($op eq '$GLOBAL::Code_infix_58__60__124__124__62_')) { return(('do { do { my $____some__weird___var____ = ' . ($self->{arguments}->[0]->emit_lisp() . ('; ' . ('::DISPATCH($____some__weird___var____,"true")->{_value} && $____some__weird___var____ ' . ('} ||' . ('do { my $____some__weird___var____ = ' . ($self->{arguments}->[1]->emit_lisp() . ('; ' . ('::DISPATCH($____some__weird___var____,"true")->{_value} && $____some__weird___var____ ' . ('} || ::DISPATCH( $::Bit, "new", 0 ) }' . Main::newline()))))))))))) } else {  } }; do { if (($op eq '$GLOBAL::Code_infix_58__60__38__38__62_')) { return(('do { ( ' . ('do { my $____some__weird___var____ = ' . ($self->{arguments}->[0]->emit_lisp() . ('; ' . ('::DISPATCH($____some__weird___var____,"true")->{_value} && $____some__weird___var____ ' . ('} &&' . ('do { my $____some__weird___var____ = ' . ($self->{arguments}->[1]->emit_lisp() . ('; ' . ('::DISPATCH($____some__weird___var____,"true")->{_value} && $____some__weird___var____ ' . ('}) || ::DISPATCH( $::Bit, "new", 0) }' . Main::newline())))))))))))) } else {  } }; return(('::DISPATCH( ' . ($op . (', \'APPLY\', ' . (Main::join([ map { $_->emit_lisp() } @{ $self->{arguments} } ], ', ') . (' )' . Main::newline())))))) }


;
package Return;
sub new { shift; bless { @_ }, "Return" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; return(('return(' . ($self->{result}->emit_lisp() . (')' . Main::newline())))) }


;
package If;
sub new { shift; bless { @_ }, "If" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('do { if (::DISPATCH(::DISPATCH(' . ($self->{cond}->emit_lisp() . (',"true"),"p5landish") ) ' . (($self->{body} ? ('{ ' . ($self->{body}->emit_lisp() . ' } ')) : '{ } ') . (($self->{otherwise} ? (' else { ' . ($self->{otherwise}->emit_lisp() . ' }')) : '') . (' }' . Main::newline())))))) }


;
package For;
sub new { shift; bless { @_ }, "For" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $cond = $self->{cond}; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) {  } else { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<@>','namespace' => ['GLOBAL'], ),'arguments' => [$cond], ) } }; ('for ' . ($self->{topic}->emit_lisp() . (' ( @{ ' . ($cond->emit_lisp() . ('->{_value}{_array} } )' . (' { ' . ($self->{body}->emit_lisp() . (' } ' . Main::newline())))))))) }


;
package While;
sub new { shift; bless { @_ }, "While" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $cond = $self->{cond}; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) {  } else { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<@>','namespace' => ['GLOBAL'], ),'arguments' => [$cond], ) } }; ('do { while (::DISPATCH(::DISPATCH(' . ($self->{cond}->emit_lisp() . (',"true"),"p5landish") ) ' . (' { ' . ($self->{body}->emit_lisp() . (' } }' . Main::newline())))))) }


;
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $decl = $self->{decl}; my  $name = $self->{var}->name(); do { if (($decl eq 'has')) { return(('sub ' . ($name . (' { ' . ('@_ == 1 ' . ('? ( $_[0]->{' . ($name . ('} ) ' . (': ( $_[0]->{' . ($name . ('} = $_[1] ) ' . '}'))))))))))) } else {  } }; my  $create = (', \'new\', { modified => $_MODIFIED, name => \'' . ($self->{var}->emit_lisp() . '\' } ) ')); do { if (($decl eq 'our')) { my  $s;$s = 'our ';do { if (($self->{var}->sigil() eq '$')) { return(($s . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp() . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp() . ('; ' . ('}' . Main::newline())))))))))))))))) } else {  } };do { if (($self->{var}->sigil() eq '&')) { return(($s . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Routine' . ($create . (';' . Main::newline())))))) } else {  } };do { if (($self->{var}->sigil() eq '%')) { return(($s . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Hash' . ($create . (';' . Main::newline())))))) } else {  } };do { if (($self->{var}->sigil() eq '@')) { return(($s . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Array' . ($create . (';' . Main::newline())))))) } else {  } };return(($s . ($self->{var}->emit_lisp() . Main::newline()))) } else {  } }; do { if (($self->{var}->sigil() eq '$')) { return(($self->{decl} . (' ' . ($self->{var}->emit_lisp() . ('; ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp() . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Scalar' . ($create . ('}' . Main::newline())))))))))))))))) } else {  } }; do { if (($self->{var}->sigil() eq '&')) { return(($self->{decl} . (' ' . ($self->{var}->emit_lisp() . ('; ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Routine' . ($create . (' unless defined ' . ($self->{var}->emit_lisp() . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Routine' . ($create . ('}' . Main::newline())))))))))))))))) } else {  } }; do { if (($self->{var}->sigil() eq '%')) { return(($self->{decl} . (' ' . (' ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Hash' . ($create . ('; ' . Main::newline())))))))) } else {  } }; do { if (($self->{var}->sigil() eq '@')) { return(($self->{decl} . (' ' . (' ' . ($self->{var}->emit_lisp() . (' = ::DISPATCH( $::Array' . ($create . ('; ' . Main::newline())))))))) } else {  } }; return(($self->{decl} . (' ' . $self->{var}->emit_lisp()))) }


;
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $inv = '$::Undef'; do { if (Main::isa($self->{invocant}, 'Var')) { $inv = Main::perl($self->{invocant}, ) } else {  } }; my  $pos; my  $decl; do { for my $decl ( @{$self->{positional}} ) { $pos = ($pos . (Main::perl($decl, ) . ', ')) } }; my  $named = ''; ('::DISPATCH( $::Signature, "new", { ' . ('invocant => ' . ($inv . (', ' . ('array    => ::DISPATCH( $::Array, "new", { _array => [ ' . ($pos . (' ] } ), ' . ('hash     => ::DISPATCH( $::Hash,  "new", { _hash  => { ' . ($named . (' } } ), ' . ('return   => $::Undef, ' . ('} )' . Main::newline())))))))))))) }


;
package Capture;
sub new { shift; bless { @_ }, "Capture" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; my  $s = '::DISPATCH( $::Capture, "new", { '; do { if (defined($self->{invocant})) { $s = ($s . ('invocant => ' . ($self->{invocant}->emit_lisp() . ', '))) } else { $s = ($s . 'invocant => $::Undef, ') } }; do { if (defined($self->{array})) { $s = ($s . 'array => ::DISPATCH( $::Array, "new", { _array => [ ');my  $item;do { for my $item ( @{$self->{array}} ) { $s = ($s . ($item->emit_lisp() . ', ')) } };$s = ($s . ' ] } ),') } else {  } }; do { if (defined($self->{hash})) { $s = ($s . 'hash => ::DISPATCH( $::Hash, "new", { _hash => { ');my  $item;do { for my $item ( @{$self->{hash}} ) { $s = ($s . ($item->[0]->emit_lisp() . ('->{_value} => ' . ($item->[1]->emit_lisp() . ', ')))) } };$s = ($s . ' } } ),') } else {  } }; return(($s . (' } )' . Main::newline()))) }


;
package Subset;
sub new { shift; bless { @_ }, "Subset" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( $::Subset, "new", { ' . ('base_class => ' . ($self->{base_class}->emit_lisp() . (', ' . ('block => ' . ('sub { local $_ = shift; ' . ($self->{block}->block()->emit_lisp() . (' } ' . (' } )' . Main::newline()))))))))) }


;
package Method;
sub new { shift; bless { @_ }, "Method" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( $::Code, \'new\', { ' . ('code => sub { ' . ($self->{block}->emit_declarations() . ('$self = shift; ' . ($self->{block}->emit_arguments() . ($self->{block}->emit_body() . (' }, ' . ('signature => ' . ($self->{block}->emit_signature() . (', ' . (' } )' . Main::newline()))))))))))) }


;
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('::DISPATCH( $::Code, \'new\', { ' . ('code => sub { ' . ($self->{block}->emit_declarations() . ($self->{block}->emit_arguments() . ($self->{block}->emit_body() . (' }, ' . ('signature => ' . ($self->{block}->emit_signature() . (', ' . (' } )' . Main::newline())))))))))) }


;
package Do;
sub new { shift; bless { @_ }, "Do" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('do { ' . ($self->{block}->emit_lisp() . (' }' . Main::newline()))) }


;
package BEGIN;
sub new { shift; bless { @_ }, "BEGIN" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; ('BEGIN { ' . ($self->{block}->emit_lisp() . ' }')) }


;
package Use;
sub new { shift; bless { @_ }, "Use" }
sub emit_lisp { my $self = shift; my $List__ = \@_; do { [] }; do { if (($self->{mod} eq 'v6')) { return((Main::newline() . ('#use v6' . Main::newline()))) } else {  } }; do { if ($self->{perl5}) { return(('use ' . ($self->{mod} . (';$::' . ($self->{mod} . ('= KindaPerl6::Runtime::Perl5::Wrap::use5(\'' . ($self->{mod} . '\')'))))))) } else { return(('use ' . $self->{mod})) } } }


;
1;
