# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Traverse; sub new { shift; bless { @_ }, "KindaPerl6::Traverse" } sub visit { my $List__ = \@_; my $visitor; my $node; my $node_name; do {  $visitor = $List__->[0];  $node = $List__->[1];  $node_name = $List__->[2]; [$visitor, $node, $node_name] }; do { if (Main::isa($node, 'Array')) { my  $result = [];my  $i = 0;do { for my $subitem ( @{$node} ) { $result->[$i] = $subitem->emit($visitor);$i = ($i + 1) } };return($result) } else {  } }; do { if (Main::isa($node, 'Hash')) { my  $result = {  };do { for my $subitem ( keys(%{$node}) ) { $result->{$subitem} = $node->{$subitem}->emit($visitor) } };return($result) } else {  } }; do { if (Main::isa($node, 'Str')) { return($node) } else {  } }; my  $result = $visitor->visit($node, $node_name); do { if ($result) { return($result) } else {  } }; my  $result = {  }; my  $data = $node->attribs(); do { for my $item ( keys(%{$data}) ) { $result->{$item} = visit($visitor, $data->{$item}) } }; return($node->new(%{$result})) }
;
package Module; sub new { shift; bless { @_ }, "Module" } sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Module') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'name' => $self->{name},'body' => $self->{body}, } }
;
package CompUnit; sub new { shift; bless { @_ }, "CompUnit" } sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub attributes { @_ == 1 ? ( $_[0]->{attributes} ) : ( $_[0]->{attributes} = $_[1] ) }; sub methods { @_ == 1 ? ( $_[0]->{methods} ) : ( $_[0]->{methods} = $_[1] ) }; sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'CompUnit') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'name' => $self->{name},'attributes' => $self->{attributes},'methods' => $self->{methods},'body' => $self->{body}, } }
;
package Val::Int; sub new { shift; bless { @_ }, "Val::Int" } sub int { @_ == 1 ? ( $_[0]->{int} ) : ( $_[0]->{int} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Int') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'int' => $self->{int}, } }
;
package Val::Bit; sub new { shift; bless { @_ }, "Val::Bit" } sub bit { @_ == 1 ? ( $_[0]->{bit} ) : ( $_[0]->{bit} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Bit') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'bit' => $self->{bit}, } }
;
package Val::Num; sub new { shift; bless { @_ }, "Val::Num" } sub num { @_ == 1 ? ( $_[0]->{num} ) : ( $_[0]->{num} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Num') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'num' => $self->{num}, } }
;
package Val::Buf; sub new { shift; bless { @_ }, "Val::Buf" } sub buf { @_ == 1 ? ( $_[0]->{buf} ) : ( $_[0]->{buf} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Buf') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'buf' => $self->{buf}, } }
;
package Val::Undef; sub new { shift; bless { @_ }, "Val::Undef" } sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Undef') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; {  } }
;
package Val::Object; sub new { shift; bless { @_ }, "Val::Object" } sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) }; sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Val::Object') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'class' => $self->{class},'fields' => $self->{fields}, } }
;
package Lit::Seq; sub new { shift; bless { @_ }, "Lit::Seq" } sub seq { @_ == 1 ? ( $_[0]->{seq} ) : ( $_[0]->{seq} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lit::Seq') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'seq' => $self->{seq}, } }
;
package Lit::Array; sub new { shift; bless { @_ }, "Lit::Array" } sub array { @_ == 1 ? ( $_[0]->{array} ) : ( $_[0]->{array} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lit::Array') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'array' => $self->{array}, } }
;
package Lit::Hash; sub new { shift; bless { @_ }, "Lit::Hash" } sub hash { @_ == 1 ? ( $_[0]->{hash} ) : ( $_[0]->{hash} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lit::Hash') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'hash' => $self->{hash}, } }
;
package Lit::Code; sub new { shift; bless { @_ }, "Lit::Code" } sub pad { @_ == 1 ? ( $_[0]->{pad} ) : ( $_[0]->{pad} = $_[1] ) }; sub state { @_ == 1 ? ( $_[0]->{state} ) : ( $_[0]->{state} = $_[1] ) }; sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) }; sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lit::Code') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'pad' => $self->{pad},'state' => $self->{state},'sig' => $self->{sig},'body' => $self->{body}, } }
;
package Lit::Object; sub new { shift; bless { @_ }, "Lit::Object" } sub class { @_ == 1 ? ( $_[0]->{class} ) : ( $_[0]->{class} = $_[1] ) }; sub fields { @_ == 1 ? ( $_[0]->{fields} ) : ( $_[0]->{fields} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lit::Object') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'class' => $self->{class},'fields' => $self->{fields}, } }
;
package Index; sub new { shift; bless { @_ }, "Index" } sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) }; sub index { @_ == 1 ? ( $_[0]->{index} ) : ( $_[0]->{index} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Index') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'obj' => $self->{obj},'index' => $self->{index}, } }
;
package Lookup; sub new { shift; bless { @_ }, "Lookup" } sub obj { @_ == 1 ? ( $_[0]->{obj} ) : ( $_[0]->{obj} = $_[1] ) }; sub index { @_ == 1 ? ( $_[0]->{index} ) : ( $_[0]->{index} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Lookup') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'obj' => $self->{obj},'index' => $self->{index}, } }
;
package Var; sub new { shift; bless { @_ }, "Var" } sub sigil { @_ == 1 ? ( $_[0]->{sigil} ) : ( $_[0]->{sigil} = $_[1] ) }; sub twigil { @_ == 1 ? ( $_[0]->{twigil} ) : ( $_[0]->{twigil} = $_[1] ) }; sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Var') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'sigil' => $self->{sigil},'twigil' => $self->{twigil},'name' => $self->{name}, } }
;
package Bind; sub new { shift; bless { @_ }, "Bind" } sub parameters { @_ == 1 ? ( $_[0]->{parameters} ) : ( $_[0]->{parameters} = $_[1] ) }; sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Bind') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, } }
;
package Assign; sub new { shift; bless { @_ }, "Assign" } sub parameters { @_ == 1 ? ( $_[0]->{parameters} ) : ( $_[0]->{parameters} = $_[1] ) }; sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Assign') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'parameters' => $self->{parameters},'arguments' => $self->{arguments}, } }
;
package Proto; sub new { shift; bless { @_ }, "Proto" } sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Proto') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'name' => $self->{name}, } }
;
package Call; sub new { shift; bless { @_ }, "Call" } sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) }; sub hyper { @_ == 1 ? ( $_[0]->{hyper} ) : ( $_[0]->{hyper} = $_[1] ) }; sub method { @_ == 1 ? ( $_[0]->{method} ) : ( $_[0]->{method} = $_[1] ) }; sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Call') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'invocant' => $self->{invocant},'hyper' => $self->{hyper},'method' => $self->{method},'arguments' => $self->{arguments}, } }
;
package Apply; sub new { shift; bless { @_ }, "Apply" } sub code { @_ == 1 ? ( $_[0]->{code} ) : ( $_[0]->{code} = $_[1] ) }; sub arguments { @_ == 1 ? ( $_[0]->{arguments} ) : ( $_[0]->{arguments} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Apply') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'code' => $self->{code},'arguments' => $self->{arguments}, } }
;
package Return; sub new { shift; bless { @_ }, "Return" } sub result { @_ == 1 ? ( $_[0]->{result} ) : ( $_[0]->{result} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Return') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'result' => $self->{result}, } }
;
package If; sub new { shift; bless { @_ }, "If" } sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) }; sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) }; sub otherwise { @_ == 1 ? ( $_[0]->{otherwise} ) : ( $_[0]->{otherwise} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'If') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'cond' => $self->{cond},'body' => $self->{body},'otherwise' => $self->{otherwise}, } }
;
package For; sub new { shift; bless { @_ }, "For" } sub cond { @_ == 1 ? ( $_[0]->{cond} ) : ( $_[0]->{cond} = $_[1] ) }; sub body { @_ == 1 ? ( $_[0]->{body} ) : ( $_[0]->{body} = $_[1] ) }; sub topic { @_ == 1 ? ( $_[0]->{topic} ) : ( $_[0]->{topic} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'For') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'cond' => $self->{cond},'body' => $self->{body},'topic' => $self->{topic}, } }
;
package Decl; sub new { shift; bless { @_ }, "Decl" } sub decl { @_ == 1 ? ( $_[0]->{decl} ) : ( $_[0]->{decl} = $_[1] ) }; sub type { @_ == 1 ? ( $_[0]->{type} ) : ( $_[0]->{type} = $_[1] ) }; sub var { @_ == 1 ? ( $_[0]->{var} ) : ( $_[0]->{var} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Decl') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'decl' => $self->{decl},'type' => $self->{type},'var' => $self->{var}, } }
;
package Sig; sub new { shift; bless { @_ }, "Sig" } sub invocant { @_ == 1 ? ( $_[0]->{invocant} ) : ( $_[0]->{invocant} = $_[1] ) }; sub positional { @_ == 1 ? ( $_[0]->{positional} ) : ( $_[0]->{positional} = $_[1] ) }; sub named { @_ == 1 ? ( $_[0]->{named} ) : ( $_[0]->{named} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Sig') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'invocant' => $self->{invocant},'positional' => $self->{positional},'named' => $self->{named}, } }
;
package Method; sub new { shift; bless { @_ }, "Method" } sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) }; sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Method') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'name' => $self->{name},'sig' => $self->{sig},'block' => $self->{block}, } }
;
package Sub; sub new { shift; bless { @_ }, "Sub" } sub name { @_ == 1 ? ( $_[0]->{name} ) : ( $_[0]->{name} = $_[1] ) }; sub sig { @_ == 1 ? ( $_[0]->{sig} ) : ( $_[0]->{sig} = $_[1] ) }; sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Sub') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'name' => $self->{name},'sig' => $self->{sig},'block' => $self->{block}, } }
;
package Do; sub new { shift; bless { @_ }, "Do" } sub block { @_ == 1 ? ( $_[0]->{block} ) : ( $_[0]->{block} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Do') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'block' => $self->{block}, } }
;
package Use; sub new { shift; bless { @_ }, "Use" } sub mod { @_ == 1 ? ( $_[0]->{mod} ) : ( $_[0]->{mod} = $_[1] ) }; sub emit { my $self = shift; my $List__ = \@_; my $visitor; do {  $visitor = $List__->[0]; [$visitor] }; KindaPerl6::Traverse::visit($visitor, $self, 'Use') }; sub attribs { my $self = shift; my $List__ = \@_; do { [] }; { 'mod' => $self->{mod}, } }
;
1;
