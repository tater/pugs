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
sub set_secure_mode { my $List__ = \@_; my $args_secure; do {  $args_secure = $List__->[0]; [$args_secure] }; do { if (($args_secure != 0)) { return(('(pushnew :kp6-cl-secure *features*)' . Main::newline())) } else { return('') } } };
sub emit_lisp { my $self = shift; my $List__ = \@_; my $args_secure; do {  $args_secure = $List__->[0]; [$args_secure] }; my  $interpreter = ('|' . ($self->{name} . '|')); (';; Do not edit this file - Lisp generated by ' . ($Main::_V6_COMPILER_NAME . (Main::newline() . ('(in-package #:cl-user)' . (Main::newline() . (set_secure_mode($args_secure) . ('(load "lib/KindaPerl6/Runtime/Lisp/Runtime.lisp")' . (Main::newline() . ('(defpackage #:' . ($self->{name} . (Main::newline() . ('  (:use #:cl #:kp6-cl))' . (Main::newline() . ('(in-package #:' . ($self->{name} . (')' . (Main::newline() . ('(defun Main ()' . (Main::newline() . (' (with-kp6-interpreter (' . ($interpreter . (')' . (Main::newline() . ('  (with-kp6-package (' . ($interpreter . (' "GLOBAL" kp6-pad)' . (Main::newline() . ($self->{body}->emit_lisp($interpreter, 3) . (')))' . (Main::newline() . '(Main::Main)')))))))))))))))))))))))))))))) }


;
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Int :value ' . ($self->{int} . ')')) }


;
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Bit :value ' . ($self->{bit} . ')')) }


;
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Num :value ' . ($self->{num} . ')')) }


;
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Str :value ' . ('"' . (Main::mangle_string($self->{buf}) . ('"' . ')')))) }


;
package Val::Char;
sub new { shift; bless { @_ }, "Val::Char" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Char :value (code-char ' . ($self->{char} . '))')) }


;
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; '(make-instance \'kp6-Undef)' }


;
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; die('Emitting of Val::Object not implemented') }


;
package Native::Buf;
sub new { shift; bless { @_ }, "Native::Buf" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; die('Emitting of Native::Buf not implemented') }


;
package Lit::Seq;
sub new { shift; bless { @_ }, "Lit::Seq" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(list ' . (Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{seq} } ], ' ') . ')')) }


;
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-Array :value (list ' . (Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{array} } ], ' ') . '))')) }


;
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $fields = $self->{hash}; my  $str = ''; my  $field; do { for my $field ( @{$fields} ) { $str = ($str . ('(kp6-store hash ' . ($field->[0]->emit_lisp($interpreter, $indent) . (' ' . ($field->[1]->emit_lisp($interpreter, $indent) . (')' . Main::newline())))))) } }; ('(let ((hash (make-instance \'kp6-Hash)))' . (Main::newline() . ($str . ' hash)'))) }


;
package Lit::Pair;
sub new { shift; bless { @_ }, "Lit::Pair" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-pair :key ' . ($self->{key}->emit_lisp($interpreter, $indent) . (' :value ' . ($self->{value}->emit_lisp($interpreter, $indent) . ')')))) }


;
package Lit::NamedArgument;
sub new { shift; bless { @_ }, "Lit::NamedArgument" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(make-instance \'kp6-named-argument :_argument_name_ ' . ($self->{key}->emit_lisp($interpreter, $indent) . (' :value ' . ($self->{value}->emit_lisp($interpreter, $indent) . ')')))) }


;
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(with-kp6-pad (' . ($interpreter . (' kp6-pad :parent kp6-pad)' . (Main::newline() . ($self->emit_declarations($interpreter, $indent) . ($self->emit_body($interpreter, $indent) . ')')))))) };
sub emit_body { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{body} } ], Main::newline()) };
sub emit_signature { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; $self->{sig}->emit_lisp($interpreter, $indent) };
sub emit_declarations { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $s = ''; my  $name; do { for my $name ( @{$self->{pad}->variable_names()} ) { my  $decl = Decl->new( 'decl' => 'my','type' => '','var' => Var->new( 'sigil' => '','twigil' => '','name' => $name,'namespace' => [], ), );do { if (($s ne '')) { $s = ($s . Main::newline()) } else {  } };$s = ($s . $name->emit_lisp($interpreter, $indent)) } }; return($s) };
sub emit_arguments { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $array_ = Var->new( 'sigil' => '@','twigil' => '','name' => '_','namespace' => [], ); my  $hash_ = Var->new( 'sigil' => '%','twigil' => '','name' => '_','namespace' => [], ); my  $CAPTURE = Var->new( 'sigil' => '$','twigil' => '','name' => 'CAPTURE','namespace' => [], ); my  $CAPTURE_decl = Decl->new( 'decl' => 'my','type' => '','var' => $CAPTURE, ); my  $str = ''; $str = ($str . $CAPTURE_decl->emit_lisp($interpreter, $indent)); $str = ($str . '::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));'); my  $bind_ = Bind->new( 'parameters' => $array_,'arguments' => Call->new( 'invocant' => $CAPTURE,'method' => 'array','arguments' => [], ), ); $str = ($str . ($bind_->emit_lisp($interpreter, $indent) . ' ')); my  $bind_hash = Bind->new( 'parameters' => $hash_,'arguments' => Call->new( 'invocant' => $CAPTURE,'method' => 'hash','arguments' => [], ), ); $str = ($str . ($bind_hash->emit_lisp($interpreter, $indent) . ' ')); my  $i = 0; my  $field; do { for my $field ( @{$self->{sig}->positional()} ) { my  $bind = Bind->new( 'parameters' => $field,'arguments' => Index->new( 'obj' => $array_,'index' => Val::Int->new( 'int' => $i, ), ), );$str = ($str . ($bind->emit_lisp($interpreter, $indent) . ' '));$i = ($i + 1) } }; return($str) }


;
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $fields = $self->{fields}; my  $str = ''; my  $field; do { for my $field ( @{$fields} ) { $str = ($str . ($field->[0]->emit_lisp($interpreter, $indent) . (' => ' . ($field->[1]->emit_lisp($interpreter, $indent) . ',')))) } }; ('(kp6-new \'kp6-' . ($self->{class} . (' ' . ($str . ')')))) }


;
package Index;
sub new { shift; bless { @_ }, "Index" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(kp6-lookup ' . ($self->{obj}->emit_lisp($interpreter, $indent) . (' (perl->cl ' . ($self->{index}->emit_lisp($interpreter, $indent) . '))')))) }


;
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(kp6-lookup ' . ($self->{obj}->emit_lisp($interpreter, $indent) . (' (perl->cl ' . ($self->{index}->emit_lisp($interpreter, $indent) . '))')))) }


;
package Assign;
sub new { shift; bless { @_ }, "Assign" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $node = $self->{parameters}; do { if (Main::isa($node, 'Var')) { do { if (@{$node->namespace()}) { (Main::join(return(('(set-package-variable (kp6-generate-variable "' . ($node->sigil() . ('" "' . ($node->name() . ('") ' . ($self->{arguments}->emit_lisp($interpreter, $indent) . (' "' . $node->namespace())))))))), '::') . '")') } else {  } };return(('(set-lexical-variable/p (kp6-generate-variable "' . ($node->sigil() . ('" "' . ($node->name() . ('") ' . ($self->{arguments}->emit_lisp($interpreter, $indent) . ')'))))))) } else {  } }; ('(kp6-error ' . ($interpreter . ' \'kp6-not-implemented :feature "assigning to anything other than variables")')) }


;
package Var;
sub new { shift; bless { @_ }, "Var" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $namespace = $self->{namespace}; do { if ((@{$namespace} ? 0 : 1)) { return(('(lookup-lexical-variable/p (kp6-generate-variable "' . ($self->{sigil} . ('" "' . ($self->{name} . '"))'))))) } else {  } }; return(('(kp6-lookup (kp6-lookup (kp6-packages ' . ($interpreter . (') "' . (join('::', @{$namespace}) . ('") (kp6-generate-variable "' . ($self->{sigil} . ('" "' . ($self->{name} . '"))'))))))))) };
sub perl { my $self = shift; my $List__ = \@_; do { [] }; ('(kp6-new \'signature-item ' . ('sigil: \'' . ($self->{sigil} . ('\', ' . ('twigil: \'' . ($self->{twigil} . ('\', ' . ('name: \'' . ($self->{name} . ('\', ' . ('namespace: [ ], ' . ')'))))))))))) }


;
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; do { if (Main::isa($self->{parameters}, 'Var')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp($interpreter, $indent)) } else {  } }; do { if (Main::isa($self->{parameters}, 'Call')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp($interpreter, $indent)) } else {  } }; do { if (Main::isa($self->{parameters}, 'Lookup')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp($interpreter, $indent)) } else {  } }; do { if (Main::isa($self->{parameters}, 'Index')) { return(Assign->new( 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, )->emit_lisp($interpreter, $indent)) } else {  } }; my  $str = ''; $str = ($str . ('(setf ' . ($self->{parameters}->emit_lisp($interpreter, $indent) . (' ' . ($self->{arguments}->emit_lisp($interpreter, $indent) . ')'))))); return($str) }


;
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; return(('\'' . $self->{name})) }


;
package Call;
sub new { shift; bless { @_ }, "Call" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $invocant; do { if (Main::isa($self->{invocant}, 'Proto')) { do { if (($self->{invocant}->name() eq 'self')) { $invocant = '$self' } else { $invocant = $self->{invocant}->emit_lisp($interpreter, $indent) } } } else { $invocant = $self->{invocant}->emit_lisp($interpreter, $indent) } }; do { if (($invocant eq 'self')) { $invocant = '$self' } else {  } }; my  $meth = $self->{method}; do { if (($meth eq 'postcircumfix:<( )>')) { $meth = '' } else {  } }; my  $call = Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{arguments} } ], ' '); do { if ($self->{hyper}) { ('[ map { $_' . ('->' . ($meth . ('(' . ($call . (') } @{ ' . ($invocant . ' } ]'))))))) } else { do { if (($meth eq '')) { ('(kp6-APPLY \'' . ($invocant . (' (list ' . ($call . '))')))) } else { ('(' . ($meth . (' \'' . ($invocant . (' (list ' . ($call . '))')))))) } } } } }


;
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $name = $self->{code}->name(); do { if (($name eq 'infix:<&&>')) { return(('(and (perl->cl ' . (Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{arguments} } ], ') (perl->cl ') . '))'))) } else {  } }; do { if (($name eq 'infix:<||>')) { return(('(or (perl->cl ' . (Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{arguments} } ], ') (perl->cl ') . '))'))) } else {  } }; do { if (($name eq 'ternary:<?? !!>')) { return(('(if (kp6-true ' . ($self->{arguments}->[0]->emit_lisp($interpreter, $indent) . (') (progn ' . ($self->{arguments}->[1]->emit_lisp($interpreter, $indent) . (') (progn ' . ($self->{arguments}->[2]->emit_lisp($interpreter, $indent) . '))'))))))) } else {  } }; my  $op = $self->{code}->emit_lisp($interpreter, $indent); return(('(kp6-apply-function ' . ($interpreter . (' (perl->cl ' . ($op . (') (list ' . (Main::join([ map { $_->emit_lisp($interpreter, $indent) } @{ $self->{arguments} } ], ' ') . '))'))))))) }


;
package Return;
sub new { shift; bless { @_ }, "Return" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; return(('return(' . ($self->{result}->emit_lisp($interpreter, $indent) . ')'))) }


;
package If;
sub new { shift; bless { @_ }, "If" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(if (kp6-true ' . ($self->{cond}->emit_lisp($interpreter, $indent) . (')' . (($self->{body} ? ('(progn ' . ($self->{body}->emit_lisp($interpreter, $indent) . ') ')) : '(progn)') . (($self->{otherwise} ? (' (progn ' . ($self->{otherwise}->emit_lisp($interpreter, $indent) . ')')) : '') . ')'))))) }


;
package For;
sub new { shift; bless { @_ }, "For" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $cond = $self->{cond}; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) {  } else { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<@>','namespace' => ['GLOBAL'], ),'arguments' => [$cond], ) } }; ('for ' . ($self->{topic}->emit_lisp($interpreter, $indent) . (' ( @{ ' . ($cond->emit_lisp($interpreter, $indent) . ('->{_value}{_array} } )' . (' { ' . ($self->{body}->emit_lisp($interpreter, $indent) . ' } '))))))) }


;
package While;
sub new { shift; bless { @_ }, "While" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $cond = $self->{cond}; do { if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) {  } else { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<@>','namespace' => ['GLOBAL'], ),'arguments' => [$cond], ) } }; ('(loop :while (kp6-true ' . ($self->{cond}->emit_lisp($interpreter, $indent) . (')' . (Main::newline() . (' :do ' . ($self->{body}->emit_lisp($interpreter, $indent) . (')' . Main::newline()))))))) }


;
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $decl = $self->{decl}; my  $name = $self->{var}->name(); do { if (($decl eq 'our')) { ('(define-our-variable (kp6-generate-variable "' . ($self->{var}->sigil() . ('" "' . ($name . '"))')))) } else {  } }; do { if (($decl eq 'my')) { return(('(define-lexical-variable (kp6-generate-variable "' . ($self->{var}->sigil() . ('" "' . ($name . '"))'))))) } else {  } }; return(('(kp6-error ' . ($interpreter . (' \'kp6-not-implemented :feature "\\"' . ($decl . '\\" variables")'))))); do { if (($decl eq 'has')) { return(('sub ' . ($name . (' { ' . ('@_ == 1 ' . ('? ( $_[0]->{' . ($name . ('} ) ' . (': ( $_[0]->{' . ($name . ('} = $_[1] ) ' . '}'))))))))))) } else {  } }; my  $create = (', \'new\', { modified => $_MODIFIED, name => \'' . ($self->{var}->emit_lisp($interpreter, $indent) . '\' } ) ')); do { if (($decl eq 'our')) { my  $s;$s = 'our ';do { if (($self->{var}->sigil() eq '$')) { return(($s . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . '}'))))))))))))))) } else {  } };do { if (($self->{var}->sigil() eq '&')) { return(($s . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Routine' . ($create . ';'))))) } else {  } };do { if (($self->{var}->sigil() eq '%')) { return(($s . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Hash' . ($create . ';'))))) } else {  } };do { if (($self->{var}->sigil() eq '@')) { return(($s . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Array' . ($create . ';'))))) } else {  } };return(($s . $self->{var}->emit_lisp($interpreter, $indent))) } else {  } }; do { if (($self->{var}->sigil() eq '$')) { return(($self->{decl} . (' ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Scalar' . ($create . (' unless defined ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Scalar' . ($create . '}'))))))))))))))) } else {  } }; do { if (($self->{var}->sigil() eq '&')) { return(($self->{decl} . (' ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Routine' . ($create . (' unless defined ' . ($self->{var}->emit_lisp($interpreter, $indent) . ('; ' . ('BEGIN { ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Routine' . ($create . '}'))))))))))))))) } else {  } }; do { if (($self->{var}->sigil() eq '%')) { return(($self->{decl} . (' ' . (' ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Hash' . ($create . '; '))))))) } else {  } }; do { if (($self->{var}->sigil() eq '@')) { return(($self->{decl} . (' ' . (' ' . ($self->{var}->emit_lisp($interpreter, $indent) . (' = ::DISPATCH( $::Array' . ($create . '; '))))))) } else {  } }; return(($self->{decl} . (' ' . $self->{var}->emit_lisp($interpreter, $indent)))) }


;
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $inv = '$::Undef'; do { if (Main::isa($self->{invocant}, 'Var')) { $inv = Main::perl($self->{invocant}, ) } else {  } }; my  $pos; my  $decl; do { for my $decl ( @{$self->{positional}} ) { $pos = ($pos . (Main::perl($decl, ) . ', ')) } }; my  $named = ''; ('(kp6-new \'signature ' . ('invocant: ' . ($inv . (', ' . ('array: ::DISPATCH( $::Array, "new", { _array => [ ' . ($pos . (' ] } ), ' . ('hash: ::DISPATCH( $::Hash,  "new", { _hash  => { ' . ($named . (' } } ), ' . ('return: $::Undef, ' . ')'))))))))))) }


;
package Capture;
sub new { shift; bless { @_ }, "Capture" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; my  $s = '(kp6-new \'capture '; do { if (defined($self->{invocant})) { $s = ($s . ('invocant: ' . ($self->{invocant}->emit_lisp($interpreter, $indent) . ', '))) } else { $s = ($s . 'invocant: $::Undef, ') } }; do { if (defined($self->{array})) { $s = ($s . 'array: ::DISPATCH( $::Array, "new", { _array => [ ');my  $item;do { for my $item ( @{$self->{array}} ) { $s = ($s . ($item->emit_lisp($interpreter, $indent) . ', ')) } };$s = ($s . ' ] } ),') } else {  } }; do { if (defined($self->{hash})) { $s = ($s . 'hash: ::DISPATCH( $::Hash, "new", { _hash => { ');my  $item;do { for my $item ( @{$self->{hash}} ) { $s = ($s . ($item->[0]->emit_lisp($interpreter, $indent) . ('->{_value} => ' . ($item->[1]->emit_lisp($interpreter) . ', ')))) } };$s = ($s . ' } } ),') } else {  } }; return(($s . ')')) }


;
package Subset;
sub new { shift; bless { @_ }, "Subset" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(kp6-new \'subset ' . ('base_class: ' . ($self->{base_class}->emit_lisp($interpreter, $indent) . (', ' . ('block: ' . ('sub { local $_ = shift; ' . ($self->{block}->block()->emit_lisp($interpreter, $indent) . (' } ' . ')')))))))) }


;
package Method;
sub new { shift; bless { @_ }, "Method" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(kp6-new \'code ' . ('code: sub { ' . ($self->{block}->emit_declarations($interpreter, $indent) . ('$self = shift; ' . ($self->{block}->emit_arguments($interpreter, $indent) . ($self->{block}->emit_body($interpreter, $indent) . (' ' . ('signature: ' . ($self->{block}->emit_signature($interpreter, $indent) . ')'))))))))) }


;
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('(kp6-new \'code ' . ('code: sub { ' . ($self->{block}->emit_declarations($interpreter, $indent) . ($self->{block}->emit_arguments($interpreter, $indent) . ($self->{block}->emit_body($interpreter, $indent) . (' } ' . ('signature: ' . ($self->{block}->emit_signature($interpreter, $indent) . ')')))))))) }


;
package Do;
sub new { shift; bless { @_ }, "Do" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; $self->{block}->emit_lisp($interpreter, $indent) }


;
package BEGIN;
sub new { shift; bless { @_ }, "BEGIN" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; ('BEGIN { ' . ($self->{block}->emit_lisp($interpreter, $indent) . ' }')) }


;
package Use;
sub new { shift; bless { @_ }, "Use" }
sub emit_lisp { my $self = shift; my $List__ = \@_; my $interpreter; my $indent; do {  $interpreter = $List__->[0];  $indent = $List__->[1]; [$interpreter, $indent] }; do { if (($self->{mod} eq 'v6')) { return((Main::newline() . ('#use v6' . Main::newline()))) } else {  } }; do { if ($self->{perl5}) { return(('use ' . ($self->{mod} . (';$::' . ($self->{mod} . ('= KindaPerl6::Runtime::Perl5::Wrap::use5(\'' . ($self->{mod} . '\')'))))))) } else { return(('use ' . $self->{mod})) } } }


;
1;
