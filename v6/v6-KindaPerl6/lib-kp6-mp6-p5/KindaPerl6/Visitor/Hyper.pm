# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Visitor::Hyper; sub new { shift; bless { @_ }, "KindaPerl6::Visitor::Hyper" } sub visit { my $self = shift; my $List__ = \@_; my $node; my $node_name; do {  $node = $List__->[0];  $node_name = $List__->[1]; [$node, $node_name] }; do { if ((($node_name eq 'Call') && $node->hyper())) { return(Apply->new( 'code' => 'map','arguments' => [Sub->new( 'sig' => Sig->new( 'positional' => [],'named' => [], ),'block' => [Call->new( 'invocant' => Var->new( 'sigil' => '$','twigil' => '','name' => '_', ),'method' => $node->method(),'arguments' => $node->arguments(), )], ), $node->invocant()], )) } else {  } }; return((undef)) }
;
1;
