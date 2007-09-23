# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Grammar;
sub new { shift; bless { @_ }, "KindaPerl6::Grammar" }
sub term { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { (do { my  $m2 = $grammar->var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'var'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'var'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->arrow_sub($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'arrow_sub'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'arrow_sub'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->prefix_op($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'prefix_op'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->exp($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'exp'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => ('prefix:<' . ($MATCH->{'prefix_op'} . '>')),'namespace' => [], ),'arguments' => [${$MATCH->{'exp'}}], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) } || (do { $MATCH->to($pos1); ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->exp($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'exp'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'exp'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->pair($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'pair'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Lit::Pair->new( 'key' => ${$MATCH->{'pair'}}->[0],'value' => ${$MATCH->{'pair'}}->[1], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->exp_mapping($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'exp_mapping'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Lit::Hash->new( 'hash' => ${$MATCH->{'exp_mapping'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); ((('[' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->exp_seq($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'exp_seq'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Lit::Array->new( 'array' => ${$MATCH->{'exp_seq'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->capture($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'capture'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'capture'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))))) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->exp_seq($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'exp_seq'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Capture->new( 'invocant' => (undef),'array' => ${$MATCH->{'exp_seq'}},'hash' => [], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))))) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'var'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Capture->new( 'invocant' => (undef),'array' => [${$MATCH->{'var'}}],'hash' => [], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) } || (do { $MATCH->to($pos1); ((('$' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->sub_or_method_name($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'sub_or_method_name'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Lookup->new( 'obj' => Var->new( 'sigil' => '$','twigil' => '','name' => '/','namespace' => [], ),'index' => Val::Buf->new( 'buf' => ${$MATCH->{'sub_or_method_name'}}, ), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('d' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('o' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->block1($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'block1'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Do->new( 'block' => ${$MATCH->{'block1'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('u' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('s' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->full_ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'full_ident'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->use_from_perl5($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'use_from_perl5'} = $m2;1 } else { 0 } } } && (do { my  $pos1 = $MATCH->to(); (do { ((('-' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $m2 = $grammar->ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'ident'} = $m2;1 } else { 0 } } }) } || do { $MATCH->to($pos1); 1 }) } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Use->new( 'mod' => ${$MATCH->{'full_ident'}},'perl5' => ${$MATCH->{'use_from_perl5'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))))) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->val($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'val'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'val'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->lit($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'lit'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'lit'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->token_sym($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'token_sym'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'token_sym'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->token($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'token'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'token'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->token_P5($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'token_P5'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'token_P5'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->proto($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'proto'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'proto'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->multi_method($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'multi_method'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'multi_method'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->method($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'method'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'method'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->multi_sub($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'multi_sub'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'multi_sub'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->subset($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'subset'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { do { if ((${$MATCH->{'subset'}}->name() ne '')) { my  $bind = Bind->new( 'parameters' => Proto->new( 'name' => ${$MATCH->{'subset'}}->name(), ),'arguments' => Subset->new( 'name' => '','base_class' => ${$MATCH->{'subset'}}->base_class(),'block' => ${$MATCH->{'subset'}}->block(), ), );COMPILER::begin_block($bind);return($bind) } else {  } }; return(${$MATCH->{'subset'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->opt_declarator($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'opt_declarator'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->sub($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'sub'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { do { if ((${$MATCH->{'sub'}}->name() eq '')) { do { if ((${$MATCH->{'opt_declarator'}} eq '')) { return(${$MATCH->{'sub'}}) } else { Main::print('Error: subroutines with declarators should have a name');die('Error: subroutines with declarators should have a name') } } } else {  } }; my  $decl; do { if ((${$MATCH->{'opt_declarator'}} eq '')) { $decl = 'our' } else { $decl = ${$MATCH->{'opt_declarator'}} } }; $List_COMPILER::PAD->[0]->add_lexicals([Decl->new( 'decl' => $decl,'var' => Var->new( 'name' => ${$MATCH->{'sub'}}->name(),'twigil' => '','sigil' => '&','namespace' => [], ),'type' => '', )]); my  $bind = Bind->new( 'parameters' => Var->new( 'name' => ${$MATCH->{'sub'}}->name(),'twigil' => '','sigil' => '&','namespace' => [], ),'arguments' => ${$MATCH->{'sub'}}, ); return($bind) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->opt_declarator($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'opt_declarator'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->coro($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'coro'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { do { if ((${$MATCH->{'coro'}}->name() eq '')) { do { if ((${$MATCH->{'opt_declarator'}} eq '')) { return(${$MATCH->{'coro'}}) } else { Main::print('Error: subroutines with declarators should have a name');die('Error: subroutines with declarators should have a name') } } } else {  } }; my  $decl; do { if ((${$MATCH->{'opt_declarator'}} eq '')) { $decl = 'our' } else { $decl = ${$MATCH->{'opt_declarator'}} } }; $List_COMPILER::PAD->[0]->add_lexicals([Decl->new( 'decl' => $decl,'var' => Var->new( 'name' => ${$MATCH->{'coro'}}->name(),'twigil' => '','sigil' => '&','namespace' => [], ),'type' => '', )]); my  $bind = Bind->new( 'parameters' => Var->new( 'name' => ${$MATCH->{'coro'}}->name(),'twigil' => '','sigil' => '&','namespace' => [], ),'arguments' => ${$MATCH->{'coro'}}, ); return($bind) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->declarator($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'declarator'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_type($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'opt_type'} = $m2;1 } else { 0 } } } && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->undeclared_var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'undeclared_var'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { do { if ((${$MATCH->{'declarator'}} eq 'my')) { $List_COMPILER::PAD->[0]->add_lexicals([Decl->new( 'decl' => ${$MATCH->{'declarator'}},'type' => ${$MATCH->{'opt_type'}},'var' => ${$MATCH->{'undeclared_var'}}, )]);return(${$MATCH->{'undeclared_var'}}) } else {  } }; do { if ((${$MATCH->{'declarator'}} eq 'our')) { $List_COMPILER::PAD->[0]->add_lexicals([Decl->new( 'decl' => ${$MATCH->{'declarator'}},'type' => ${$MATCH->{'opt_type'}},'var' => ${$MATCH->{'undeclared_var'}}, )]);return(${$MATCH->{'undeclared_var'}}) } else {  } }; return(Decl->new( 'decl' => ${$MATCH->{'declarator'}},'type' => ${$MATCH->{'opt_type'}},'var' => ${$MATCH->{'undeclared_var'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->begin_block($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'begin_block'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'begin_block'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->check_block($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'check_block'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'check_block'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('i' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('s' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->full_ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'full_ident'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { die('<is> not implemented') }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('d' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('o' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('s' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my  $m2 = $grammar->full_ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'full_ident'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { die('<does> not implemented') }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })))))) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->control($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'control'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'control'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->apply($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'apply'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'apply'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->angle_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'angle_quoted'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'qw','namespace' => [], ),'arguments' => [Val::Buf->new( 'buf' => ("" . $MATCH->{'angle_quoted'}), )], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))) })))))))))))))))))))))))))))))))) }); return($MATCH) }


;
1;
