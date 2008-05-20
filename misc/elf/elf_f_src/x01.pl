#!/usr/bin/perl -w
use strict;
no strict "subs"; # XXX remove once Type-names are quoted. # say Int.isa(Any)
use warnings;

{package AssertCurrentModuleVersions;
 use autobox 2.23;
}
{ package NoSideEffects;
  use Class::Multimethods;
  use Data::Dumper;
}

{package AssertCurrentModuleVersions;
 use Moose 0.40;
 use Moose::Autobox 0.06;
}


# Move to the Regexp prelude once that becomes part of the prelude.
{ package BacktrackMacrosKludge;
  sub _let_gen {
    my($vars) = @_;
    my $nvars = 1+($vars =~ tr/,//);
    my $tmpvars = join(",",map{"\$__tmp${_}__"}(0..($nvars-1)));
    push(@SCRATCH::_let_stack,[$vars,$tmpvars]);
    "(do{my \$__v__ ; my($tmpvars); { local($vars)=($vars); \$__v__ = do{ ";
  }
  sub _let_end {
    my $e = shift(@SCRATCH::_let_stack) || die "LET(){ }LET pairs didnt match up";
    my($vars,$tmpvars) = @$e;
    "}; if(!FAILED(\$__v__)){ ($tmpvars)=($vars); }}; if(!FAILED(\$__v__)){ ($vars)=($tmpvars) }; \$__v__ })"
  }
}

{package UNDEF;}
{package UNDEF; sub WHAT {"Undef"}}
{package UNIVERSAL; sub ref {CORE::ref($_[0]) || "SCALAR"} } # For IRx1_FromAST.pm.
{package UNIVERSAL; sub WHAT {CORE::ref($_[0]) || "SCALARISH"} }

{ package Object;
  sub can { UNIVERSAL::can($_[0],$_[1]) }
  sub isa { UNIVERSAL::isa($_[0],$_[1]) }
  sub does { UNIVERSAL::isa($_[0],$_[1]) }
}  

no warnings qw(redefine prototype);
{ package SCALAR;
  sub WHAT { my $x = $_[0]; ~$x&$x ? "Str" : $x =~ /\A\d+\z/ ? "Int" : "Num" }

  # randomness taken from autobox::Core

  sub chomp   ($)   { CORE::chomp($_[0]); }
  sub chop    ($)   { CORE::chop($_[0]); }
  sub chr     ($)   { CORE::chr($_[0]); }
  sub crypt   ($$)  { CORE::crypt($_[0], $_[1]); }
  sub index   ($@)  { CORE::index($_[0], $_[1], @_[2.. $#_]); }
  sub lc      ($)   { CORE::lc($_[0]); }
  sub lcfirst ($)   { CORE::lcfirst($_[0]); }
  sub length  ($)   { CORE::length($_[0]); }
  sub ord     ($)   { CORE::ord($_[0]); }
  sub pack    ($;@) { CORE::pack(@_); }
  sub reverse ($)   { CORE::reverse($_[0]); }
  sub rindex  ($@)  { CORE::rindex($_[0], $_[1], @_[2.. $#_]); }
  sub sprintf ($@)  { CORE::sprintf($_[0], $_[1], @_[2.. $#_]); }
  sub substr  ($@)  { CORE::substr($_[0], $_[1], @_[2 .. $#_]); }
  sub uc      ($)   { CORE::uc($_[0]); }
  sub ucfirst ($)   { CORE::ucfirst($_[0]); }
  sub unpack  ($;@) { CORE::unpack($_[0], @_[1..$#_]); }
  sub quotemeta ($) { CORE::quotemeta($_[0]); }
  sub vec     ($$$) { CORE::vec($_[0], $_[1], $_[2]); }
  sub undef   ($)   { $_[0] = undef }
  sub m       ($$)  { [ $_[0] =~ m{$_[1]} ] }
  sub nm       ($$)  { [ $_[0] !~ m{$_[1]} ] }
  sub s       ($$$) { $_[0] =~ s{$_[1]}{$_[2]} }
  sub split   ($$)  { [ split $_[1], $_[0] ] }

  sub abs     ($)  { CORE::abs($_[0]) }
  sub atan2   ($)  { CORE::atan2($_[0], $_[1]) }
  sub cos     ($)  { CORE::cos($_[0]) }
  sub exp     ($)  { CORE::exp($_[0]) }
  sub int     ($)  { CORE::int($_[0]) }
  sub log     ($)  { CORE::log($_[0]) }
  sub oct     ($)  { CORE::oct($_[0]) }
  sub hex     ($)  { CORE::hex($_[0]); }
  sub rand    ($)  { CORE::rand($_[0]) }
  sub sin     ($)  { CORE::sin($_[0]) }
  sub sqrt    ($)  { CORE::sqrt($_[0]) }

  sub to ($$) { $_[0] < $_[1] ? [$_[0]..$_[1]] : [CORE::reverse $_[1]..$_[0]]}
  sub upto ($$) { [ $_[0]..$_[1] ] }
  sub downto ($$) { [ CORE::reverse $_[1]..$_[0] ] }
}
{ package ARRAY;
  sub WHAT {"Array"}

  sub shape { my $a = CORE::shift; 0+@$a } # ?
  sub end { my $a = CORE::shift; -1+@$a } # ?
  sub elems { my $a = CORE::shift; CORE::scalar @$a }
  sub delete { my $a = CORE::shift; @_ ? CORE::delete($a->[$_[0]]) : undef }
  sub exists { my $a = CORE::shift; @_ ? CORE::exists($a->[$_[0]]) : undef }
  sub pop (\@) { CORE::pop @{$_[0]}; }
  sub shift { my $a = CORE::shift; CORE::shift(@$a) }
  sub push { my $a = CORE::shift; CORE::push(@$a,@_); $a }
  sub unshift { my $a = CORE::shift; CORE::unshift(@$a,@_) }
  sub splice {
    my $a = CORE::shift;
    my $offset = CORE::shift || 0;
    my $size = CORE::shift || 0;
    [CORE::splice(@{$a},$offset,$size,@_)]
  }
  sub keys { my $a = CORE::shift; [0..(@$a-1)] }
  sub kv { my $a = CORE::shift; my $idx = 0; [map{($idx++,$_)}@$a] }
  sub pairs { my $a = CORE::shift; my $idx = 0; [map{Pair->new("key"=>$idx++,"value"=>$_)}@$a] }
  sub values { my $a = CORE::shift; @$a }

  # Speculative

  sub clone { my $a = CORE::shift; [@$a] }

  # Non-spec

  sub grep (\@&) { my $arr = CORE::shift; my $sub = CORE::shift; [ CORE::grep { $sub->($_) } @$arr ]; }
  sub join (\@$) { my $arr = CORE::shift; my $sep = CORE::shift; CORE::join $sep, @$arr; }
  sub map (\@&) { my $arr = CORE::shift; my $sub = CORE::shift; [ CORE::map { $sub->($_) } @$arr ]; }
  sub reverse (\@) { [ CORE::reverse @{$_[0]} ] }
  sub sort (\@;&) { my $arr = CORE::shift; my $sub = CORE::shift() || sub { $a cmp $b }; [ CORE::sort { $sub->($a, $b) } @$arr ]; }
  sub max(\@) { my $arr = CORE::shift; my $max = $arr->[0]; foreach (@$arr) {$max = $_ if $_ > $max }; $max; }
  sub min(\@) { my $arr = CORE::shift; my $min = $arr->[0]; foreach (@$arr) {$min = $_ if $_ < $min }; $min; }

  sub each (\@$) {
    my $arr = CORE::shift; my $sub = CORE::shift;
    foreach my $i (@$arr) {$sub->($i);}
  }
  sub each_with_index (\@$) {
    my $arr = CORE::shift; my $sub = CORE::shift;
    for(my $i = 0; $i < $#$arr; $i++) {$sub->($i, $arr->[$i]);}
  }

  # Internal

  sub flatten (\@) { ( @{$_[0]} ) }
  sub flatten_recursively {
    map { my $ref = ref($_); ($ref && $ref eq "ARRAY") ? $_->flatten_recursively : $_ } @{$_[0]}
  }
}
{ package HASH;
  sub WHAT {"Hash"}

  # randomness taken from autobox::Core

  sub delete (\%@) { my $hash = CORE::shift; my @res = (); CORE::foreach(@_) { push @res, CORE::delete $hash->{$_}; } CORE::wantarray ? @res : \@res }
  sub exists (\%$) { my $hash = CORE::shift; CORE::exists $hash->{$_[0]}; }
  sub keys (\%) { [ CORE::keys %{$_[0]} ] }
  sub values (\%) { [ CORE::values %{$_[0]} ] }

  sub each (\%$) {
    my $hash = CORE::shift;
    my $cb = CORE::shift;
    while((my $k, my $v) = CORE::each(%$hash)) {
      $cb->($k, $v);
    }
  }

  # spec

  sub kv { my $h = CORE::shift; [map{($_,$h->{$_})} CORE::keys %$h] }
  sub pairs { my $h = CORE::shift; [map{Pair->new("key"=>$_,"value"=>$h->{$_})} CORE::keys %$h] }

  # Speculative

  sub clone {
    my $h = CORE::shift;
    # Do not simplify this to "...ift; {%$h} }".  returns 0.  autobox issue?
    my $h1 = {%$h}; $h1
  }

  # Temporary

  sub dup { my $h = CORE::shift; my $h1 = {%$h}; $h1} # obsolete
}
use warnings;

{ package Any; sub __make_not_empty_for_use_base{}}
{ package SCALAR; use base "Any";}
{ package ARRAY; use base "Any";}
{ package HASH; use base "Any";}
{ package CODE; use base "Any";}

{ package Private;
  # Taken from Perl6::Take 0.04.
  our @GATHER;
  sub gather (&) {local @GATHER = (@GATHER, []); shift->(); $GATHER[-1] }
  sub take (@) {push @{ $GATHER[-1] }, @_; undef }
}

{ package GLOBAL;
  { no warnings;
    *gather = \&Private::gather;
    *take   = \&Private::take;}

  {
    use Scalar::Util "openhandle";
    sub say {
      my $currfh = select();
      my($handle,$warning);
      {no strict "refs"; $handle = openhandle($_[0]) ? shift : \*$currfh;}
      @_ = $_ unless @_;
      my @as = @_;
      @_ = map {
        my $ref = ref($_);
        ($ref && $ref eq "ARRAY") ? ARRAY::flatten_recursively($_) : $_
      } @as;
      local $SIG{__WARN__} = sub { $warning = join q{}, @_ };
      my $res = print {$handle} @_, "\n";
      return $res if $res;
      $warning =~ s/[ ]at[ ].*//xms;
      Carp::croak $warning;
    }
  }

  our $a_ARGS = [@ARGV];

  sub undef{undef}

  use Carp;
  sub slurp{my($file)=@_; my $s = `cat $file`; $s}
  sub unslurp{
    my($text,$file)=@_; open(F,">$file") or CORE::die $!; print F $text; close F;}
  sub file_exists{-e $_[0]}
  sub system{CORE::system(@_)}
  sub eval_perl5{my($p5)=@_;my $res = eval($p5); croak($@) if $@; $res}
  sub die{croak @_}
  sub exit{CORE::exit(@_)}
  sub defined{CORE::defined($_[0])}
  sub substr ($$$){CORE::substr($_[0],$_[1],$_[2])}
  sub not ($){CORE::not $_[0]}
  sub exec{CORE::exec(@_)}
  sub sleep{CORE::sleep(@_)}

  sub split{[CORE::split($_[0],$_[1])]}
}

{ package SCALAR;
  sub re_sub         {
    my $expr = "\$_[0] =~ s/$_[1]/$_[2]/".($_[3]||"");
    eval $expr;
    Carp::confess($@) if $@;
    $_[0]
  }
  sub re_sub_g ($$$) {
    eval "\$_[0] =~ s/$_[1]/$_[2]/g";
    Carp::confess($@) if $@;
    $_[0]
  }
  # legacy
  sub re_gsub ($$$) {$_[0] =~ s/$_[1]/$_[2]/g; $_[0]}
}

{ package GLOBAL;

  sub parser_name{
    my $e = $ENV{ELF_STD_RED_RUN};
    return $e if $e;
    my $f = $0;
    $f =~ s/[^\/]+$//;
    # $f."elf_e_src/STD_red/STD_red_run"
    $f."../STD_red/STD_red_run"
  }

  our $a_INC = ["."];

  sub require {
    my($module)=@_;
    my $file = find_required_module($module);
    $file || CORE::die "Cant locate $module in ( ".CORE::join(" ",@$GLOBAL::a_INC)." ).\n";
    eval_file($file);
  };
  sub find_required_module {
    my($module)=@_;
    my @names = ($module,$module.".pm",$module.".p6");
    for my $dir (@$GLOBAL::a_INC) {
      for my $name (@names) {
        my $file = $dir."/".$name;
        if(-f $file) {
          return $file;
        }
      }
    }
    return undef;
  }
  sub mkdir {
    my($dir) = @_;
    mkdir($dir);
  }

  our $compiler0;
  our $compiler1;
  our $parser0;
  our $parser1;
  our $emitter0;
  our $emitter1;

  sub eval_file {
    my($file)=@_;
    $GLOBAL::compiler0->eval_file($file);
  }
  sub eval_perl6 {
    my($code)=@_;
    $GLOBAL::compiler0->eval_perl6($code);
  }
  sub eval {
    my($code)=@_;
    eval_perl6($code);
  }
}

package main; # -> Main once elf_d support is dropped.

use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package Any; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Object; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Bit; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Int; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'SCALAR';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Str; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'SCALAR';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Num; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'SCALAR';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Complex; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Bool; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Code; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'CODE';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Block; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Code';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package List; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Seq; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Range; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Set; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Bag; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Junction; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Object';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Pair; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
has 'key' => (is => 'rw');;
has 'value' => (is => 'rw');;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Mapping; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Signature; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Capture; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Blob; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Scalar; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Array; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Hash; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package KeyHash; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package KeySet; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package KeyBag; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Buf; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package IO; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Routine; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Code';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Sub; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Routine';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Method; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Routine';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Subethod; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Routine';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Macro; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Routine';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Regex; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Routine';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Match; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Package; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Any';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Module; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Package';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Class; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Module';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Role; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Module';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Grammar; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Module';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Any; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'Object';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package Object; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
;
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package Match; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
has 'rule' => (is => 'rw');;
has 'str' => (is => 'rw');;
has 'from' => (is => 'rw');;
has 'to' => (is => 'rw');;
has 'hash' => (is => 'rw');;
sub make_from_rsfth{my $self=CORE::shift;my($r,$s,$f,$t,$h)=@_;
my $init = {'rule', $r, 'str', $s, 'from', $f, 'to', $t, 'hash', $h};
$self->new($init)};
sub match_describe{my $self=CORE::shift;my $s = ((((((($self->rule . '<') . $self->from) . ',') . $self->to) . ',\'') . $self->str) . '\',{');
for($self->hash->keys()->flatten){
my $k = $_;
my $v = $self->hash->{$k};
my $vs = 'undef';
if(GLOBAL::defined($v)) {
($vs = $v->match_describe())
};
($s = ((((($s . '
  ') . $k) . ' => ') . $self->indent_except_top($vs)) . ','))
};
if($self->hash->keys()->elems()) {
($s = ($s . '
'))
};
($s = ($s . '}>'))};
sub indent{my $self=CORE::shift;my($s)=@_;
$s->re_gsub(qr/(?m:^(?!\Z))/, '  ')};
sub indent_except_top{my $self=CORE::shift;my($s)=@_;
$s->re_gsub(qr/(?m:^(?<!\A)(?!\Z))/, '  ')};
sub match_string{my $self=CORE::shift;$self->str};
# __PACKAGE__->meta->make_immutable();

}
;

{ package ARRAY; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub match_describe{my $self=CORE::shift;((('[
' . Match->indent($self->map(sub {my($e)=@_;
$e->match_describe()})->join(',
'))) . '
]'))};
# __PACKAGE__->meta->make_immutable();

}
;

{ package HASH; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub match_describe{my $self=CORE::shift;my $s = '{';
for($self->keys()->flatten){
my $k = $_;
my $v = $self->{$k};
my $vs = 'undef';
if(GLOBAL::defined($v)) {
($vs = $v->match_describe())
};
($s = ((((($s . '
  ') . $k) . ' => ') . Match->indent_except_top($vs)) . ','))
};
if($self->keys()->elems()) {
($s = ($s . '
'))
};
($s . '}')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package SCALAR; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub match_describe{my $self=CORE::shift;(('\'' . $self) . '\'')};
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package ARRAY; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub irx1_describe{my $self=CORE::shift;(('[' . $self->map(sub {my($e)=@_;
$e->irx1_describe()})->join(',')) . ']')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package SCALAR; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub irx1_describe{my $self=CORE::shift;($self . '')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package UNDEF; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub irx1_describe{my $self=CORE::shift;'undef'};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();

{ package IRx1::Base; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit_and_Block; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::CompUnit_and_Block';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Block; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::CompUnit_and_Block';
;
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'statements' => (is => 'rw');;
has 'filename' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$statements,$filename)=@_;
$self->new('match', $match, 'statements', $statements, 'filename', $filename)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__CompUnit($self)};
sub node_name{my $self=CORE::shift;'CompUnit'};
sub field_names{my $self=CORE::shift;['statements', 'filename']};
sub field_values{my $self=CORE::shift;[$self->statements, $self->filename]};
sub irx1_describe{my $self=CORE::shift;(((('CompUnit(' . $self->statements->irx1_describe()) . ',') . $self->filename->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Block; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'statements' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$statements)=@_;
$self->new('match', $match, 'statements', $statements)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Block($self)};
sub node_name{my $self=CORE::shift;'Block'};
sub field_names{my $self=CORE::shift;['statements']};
sub field_values{my $self=CORE::shift;[$self->statements]};
sub irx1_describe{my $self=CORE::shift;(('Block(' . $self->statements->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Use; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'kind' => (is => 'rw');;
has 'module_name' => (is => 'rw');;
has 'expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$kind,$module_name,$expr)=@_;
$self->new('match', $match, 'kind', $kind, 'module_name', $module_name, 'expr', $expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Use($self)};
sub node_name{my $self=CORE::shift;'Use'};
sub field_names{my $self=CORE::shift;['kind', 'module_name', 'expr']};
sub field_values{my $self=CORE::shift;[$self->kind, $self->module_name, $self->expr]};
sub irx1_describe{my $self=CORE::shift;(((((('Use(' . $self->kind->irx1_describe()) . ',') . $self->module_name->irx1_describe()) . ',') . $self->expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::PackageDecl; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'scope' => (is => 'rw');;
has 'plurality' => (is => 'rw');;
has 'kind' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$scope,$plurality,$kind,$name,$traits,$block)=@_;
$self->new('match', $match, 'scope', $scope, 'plurality', $plurality, 'kind', $kind, 'name', $name, 'traits', $traits, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__PackageDecl($self)};
sub node_name{my $self=CORE::shift;'PackageDecl'};
sub field_names{my $self=CORE::shift;['scope', 'plurality', 'kind', 'name', 'traits', 'block']};
sub field_values{my $self=CORE::shift;[$self->scope, $self->plurality, $self->kind, $self->name, $self->traits, $self->block]};
sub irx1_describe{my $self=CORE::shift;(((((((((((('PackageDecl(' . $self->scope->irx1_describe()) . ',') . $self->plurality->irx1_describe()) . ',') . $self->kind->irx1_describe()) . ',') . $self->name->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::MethodDecl; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'scope' => (is => 'rw');;
has 'typenames' => (is => 'rw');;
has 'plurality' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'multisig' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'sigil' => (is => 'rw');;
has 'postcircumfix' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$scope,$typenames,$plurality,$name,$multisig,$traits,$block,$sigil,$postcircumfix)=@_;
$self->new('match', $match, 'scope', $scope, 'typenames', $typenames, 'plurality', $plurality, 'name', $name, 'multisig', $multisig, 'traits', $traits, 'block', $block, 'sigil', $sigil, 'postcircumfix', $postcircumfix)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__MethodDecl($self)};
sub node_name{my $self=CORE::shift;'MethodDecl'};
sub field_names{my $self=CORE::shift;['scope', 'typenames', 'plurality', 'name', 'multisig', 'traits', 'block', 'sigil', 'postcircumfix']};
sub field_values{my $self=CORE::shift;[$self->scope, $self->typenames, $self->plurality, $self->name, $self->multisig, $self->traits, $self->block, $self->sigil, $self->postcircumfix]};
sub irx1_describe{my $self=CORE::shift;(((((((((((((((((('MethodDecl(' . $self->scope->irx1_describe()) . ',') . $self->typenames->irx1_describe()) . ',') . $self->plurality->irx1_describe()) . ',') . $self->name->irx1_describe()) . ',') . $self->multisig->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->block->irx1_describe()) . ',') . $self->sigil->irx1_describe()) . ',') . $self->postcircumfix->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::SubDecl; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'scope' => (is => 'rw');;
has 'typenames' => (is => 'rw');;
has 'plurality' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'multisig' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$scope,$typenames,$plurality,$name,$multisig,$traits,$block)=@_;
$self->new('match', $match, 'scope', $scope, 'typenames', $typenames, 'plurality', $plurality, 'name', $name, 'multisig', $multisig, 'traits', $traits, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__SubDecl($self)};
sub node_name{my $self=CORE::shift;'SubDecl'};
sub field_names{my $self=CORE::shift;['scope', 'typenames', 'plurality', 'name', 'multisig', 'traits', 'block']};
sub field_values{my $self=CORE::shift;[$self->scope, $self->typenames, $self->plurality, $self->name, $self->multisig, $self->traits, $self->block]};
sub irx1_describe{my $self=CORE::shift;(((((((((((((('SubDecl(' . $self->scope->irx1_describe()) . ',') . $self->typenames->irx1_describe()) . ',') . $self->plurality->irx1_describe()) . ',') . $self->name->irx1_describe()) . ',') . $self->multisig->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::MacroDecl; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'scope' => (is => 'rw');;
has 'typenames' => (is => 'rw');;
has 'plurality' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'multisig' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$scope,$typenames,$plurality,$name,$multisig,$traits,$block)=@_;
$self->new('match', $match, 'scope', $scope, 'typenames', $typenames, 'plurality', $plurality, 'name', $name, 'multisig', $multisig, 'traits', $traits, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__MacroDecl($self)};
sub node_name{my $self=CORE::shift;'MacroDecl'};
sub field_names{my $self=CORE::shift;['scope', 'typenames', 'plurality', 'name', 'multisig', 'traits', 'block']};
sub field_values{my $self=CORE::shift;[$self->scope, $self->typenames, $self->plurality, $self->name, $self->multisig, $self->traits, $self->block]};
sub irx1_describe{my $self=CORE::shift;(((((((((((((('MacroDecl(' . $self->scope->irx1_describe()) . ',') . $self->typenames->irx1_describe()) . ',') . $self->plurality->irx1_describe()) . ',') . $self->name->irx1_describe()) . ',') . $self->multisig->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::VarDecl; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'scope' => (is => 'rw');;
has 'typenames' => (is => 'rw');;
has 'plurality' => (is => 'rw');;
has 'var' => (is => 'rw');;
has 'postcircumfix' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'default_op' => (is => 'rw');;
has 'default_expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$scope,$typenames,$plurality,$var,$postcircumfix,$traits,$default_op,$default_expr)=@_;
$self->new('match', $match, 'scope', $scope, 'typenames', $typenames, 'plurality', $plurality, 'var', $var, 'postcircumfix', $postcircumfix, 'traits', $traits, 'default_op', $default_op, 'default_expr', $default_expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__VarDecl($self)};
sub node_name{my $self=CORE::shift;'VarDecl'};
sub field_names{my $self=CORE::shift;['scope', 'typenames', 'plurality', 'var', 'postcircumfix', 'traits', 'default_op', 'default_expr']};
sub field_values{my $self=CORE::shift;[$self->scope, $self->typenames, $self->plurality, $self->var, $self->postcircumfix, $self->traits, $self->default_op, $self->default_expr]};
sub irx1_describe{my $self=CORE::shift;(((((((((((((((('VarDecl(' . $self->scope->irx1_describe()) . ',') . $self->typenames->irx1_describe()) . ',') . $self->plurality->irx1_describe()) . ',') . $self->var->irx1_describe()) . ',') . $self->postcircumfix->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->default_op->irx1_describe()) . ',') . $self->default_expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Var; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'sigil' => (is => 'rw');;
has 'twigil' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$sigil,$twigil,$name)=@_;
$self->new('match', $match, 'sigil', $sigil, 'twigil', $twigil, 'name', $name)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Var($self)};
sub node_name{my $self=CORE::shift;'Var'};
sub field_names{my $self=CORE::shift;['sigil', 'twigil', 'name']};
sub field_values{my $self=CORE::shift;[$self->sigil, $self->twigil, $self->name]};
sub irx1_describe{my $self=CORE::shift;(((((('Var(' . $self->sigil->irx1_describe()) . ',') . $self->twigil->irx1_describe()) . ',') . $self->name->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Trait; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'verb' => (is => 'rw');;
has 'expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$verb,$expr)=@_;
$self->new('match', $match, 'verb', $verb, 'expr', $expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Trait($self)};
sub node_name{my $self=CORE::shift;'Trait'};
sub field_names{my $self=CORE::shift;['verb', 'expr']};
sub field_values{my $self=CORE::shift;[$self->verb, $self->expr]};
sub irx1_describe{my $self=CORE::shift;(((('Trait(' . $self->verb->irx1_describe()) . ',') . $self->expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::ClosureTrait; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'kind' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$kind,$block)=@_;
$self->new('match', $match, 'kind', $kind, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__ClosureTrait($self)};
sub node_name{my $self=CORE::shift;'ClosureTrait'};
sub field_names{my $self=CORE::shift;['kind', 'block']};
sub field_values{my $self=CORE::shift;[$self->kind, $self->block]};
sub irx1_describe{my $self=CORE::shift;(((('ClosureTrait(' . $self->kind->irx1_describe()) . ',') . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::ModuleName; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'pairs' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$name,$pairs)=@_;
$self->new('match', $match, 'name', $name, 'pairs', $pairs)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__ModuleName($self)};
sub node_name{my $self=CORE::shift;'ModuleName'};
sub field_names{my $self=CORE::shift;['name', 'pairs']};
sub field_values{my $self=CORE::shift;[$self->name, $self->pairs]};
sub irx1_describe{my $self=CORE::shift;(((('ModuleName(' . $self->name->irx1_describe()) . ',') . $self->pairs->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::PathName; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'path' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$path)=@_;
$self->new('match', $match, 'path', $path)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__PathName($self)};
sub node_name{my $self=CORE::shift;'PathName'};
sub field_names{my $self=CORE::shift;['path']};
sub field_values{my $self=CORE::shift;[$self->path]};
sub irx1_describe{my $self=CORE::shift;(('PathName(' . $self->path->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::SubName; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'category' => (is => 'rw');;
has 'pairs' => (is => 'rw');;
has 'desigilname' => (is => 'rw');;
has 'signature' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$category,$pairs,$desigilname,$signature)=@_;
$self->new('match', $match, 'category', $category, 'pairs', $pairs, 'desigilname', $desigilname, 'signature', $signature)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__SubName($self)};
sub node_name{my $self=CORE::shift;'SubName'};
sub field_names{my $self=CORE::shift;['category', 'pairs', 'desigilname', 'signature']};
sub field_values{my $self=CORE::shift;[$self->category, $self->pairs, $self->desigilname, $self->signature]};
sub irx1_describe{my $self=CORE::shift;(((((((('SubName(' . $self->category->irx1_describe()) . ',') . $self->pairs->irx1_describe()) . ',') . $self->desigilname->irx1_describe()) . ',') . $self->signature->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::ShapedParamName; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'ident' => (is => 'rw');;
has 'postcircumfix' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$ident,$postcircumfix)=@_;
$self->new('match', $match, 'ident', $ident, 'postcircumfix', $postcircumfix)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__ShapedParamName($self)};
sub node_name{my $self=CORE::shift;'ShapedParamName'};
sub field_names{my $self=CORE::shift;['ident', 'postcircumfix']};
sub field_values{my $self=CORE::shift;[$self->ident, $self->postcircumfix]};
sub irx1_describe{my $self=CORE::shift;(((('ShapedParamName(' . $self->ident->irx1_describe()) . ',') . $self->postcircumfix->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Call; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'invocant' => (is => 'rw');;
has 'method' => (is => 'rw');;
has 'capture' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$invocant,$method,$capture)=@_;
$self->new('match', $match, 'invocant', $invocant, 'method', $method, 'capture', $capture)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Call($self)};
sub node_name{my $self=CORE::shift;'Call'};
sub field_names{my $self=CORE::shift;['invocant', 'method', 'capture']};
sub field_values{my $self=CORE::shift;[$self->invocant, $self->method, $self->capture]};
sub irx1_describe{my $self=CORE::shift;(((((('Call(' . $self->invocant->irx1_describe()) . ',') . $self->method->irx1_describe()) . ',') . $self->capture->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Apply; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'function' => (is => 'rw');;
has 'capture' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$function,$capture)=@_;
$self->new('match', $match, 'function', $function, 'capture', $capture)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Apply($self)};
sub node_name{my $self=CORE::shift;'Apply'};
sub field_names{my $self=CORE::shift;['function', 'capture']};
sub field_values{my $self=CORE::shift;[$self->function, $self->capture]};
sub irx1_describe{my $self=CORE::shift;(((('Apply(' . $self->function->irx1_describe()) . ',') . $self->capture->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Hyper; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'operator' => (is => 'rw');;
has 'capture' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$operator,$capture)=@_;
$self->new('match', $match, 'operator', $operator, 'capture', $capture)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Hyper($self)};
sub node_name{my $self=CORE::shift;'Hyper'};
sub field_names{my $self=CORE::shift;['operator', 'capture']};
sub field_values{my $self=CORE::shift;[$self->operator, $self->capture]};
sub irx1_describe{my $self=CORE::shift;(((('Hyper(' . $self->operator->irx1_describe()) . ',') . $self->capture->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Capture; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'arguments' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$arguments)=@_;
$self->new('match', $match, 'arguments', $arguments)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Capture($self)};
sub node_name{my $self=CORE::shift;'Capture'};
sub field_names{my $self=CORE::shift;['arguments']};
sub field_values{my $self=CORE::shift;[$self->arguments]};
sub irx1_describe{my $self=CORE::shift;(('Capture(' . $self->arguments->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::MultiSig; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'signatures' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$signatures)=@_;
$self->new('match', $match, 'signatures', $signatures)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__MultiSig($self)};
sub node_name{my $self=CORE::shift;'MultiSig'};
sub field_names{my $self=CORE::shift;['signatures']};
sub field_values{my $self=CORE::shift;[$self->signatures]};
sub irx1_describe{my $self=CORE::shift;(('MultiSig(' . $self->signatures->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Signature; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'parameters' => (is => 'rw');;
has 'return_type' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$parameters,$return_type)=@_;
$self->new('match', $match, 'parameters', $parameters, 'return_type', $return_type)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Signature($self)};
sub node_name{my $self=CORE::shift;'Signature'};
sub field_names{my $self=CORE::shift;['parameters', 'return_type']};
sub field_values{my $self=CORE::shift;[$self->parameters, $self->return_type]};
sub irx1_describe{my $self=CORE::shift;(((('Signature(' . $self->parameters->irx1_describe()) . ',') . $self->return_type->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Parameter; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'type_constraints' => (is => 'rw');;
has 'quant' => (is => 'rw');;
has 'param_var' => (is => 'rw');;
has 'ident' => (is => 'rw');;
has 'traits' => (is => 'rw');;
has 'post_constraints' => (is => 'rw');;
has 'default_expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$type_constraints,$quant,$param_var,$ident,$traits,$post_constraints,$default_expr)=@_;
$self->new('match', $match, 'type_constraints', $type_constraints, 'quant', $quant, 'param_var', $param_var, 'ident', $ident, 'traits', $traits, 'post_constraints', $post_constraints, 'default_expr', $default_expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Parameter($self)};
sub node_name{my $self=CORE::shift;'Parameter'};
sub field_names{my $self=CORE::shift;['type_constraints', 'quant', 'param_var', 'ident', 'traits', 'post_constraints', 'default_expr']};
sub field_values{my $self=CORE::shift;[$self->type_constraints, $self->quant, $self->param_var, $self->ident, $self->traits, $self->post_constraints, $self->default_expr]};
sub irx1_describe{my $self=CORE::shift;(((((((((((((('Parameter(' . $self->type_constraints->irx1_describe()) . ',') . $self->quant->irx1_describe()) . ',') . $self->param_var->irx1_describe()) . ',') . $self->ident->irx1_describe()) . ',') . $self->traits->irx1_describe()) . ',') . $self->post_constraints->irx1_describe()) . ',') . $self->default_expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::TypeConstraint; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'value' => (is => 'rw');;
has 'where_expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$value,$where_expr)=@_;
$self->new('match', $match, 'value', $value, 'where_expr', $where_expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__TypeConstraint($self)};
sub node_name{my $self=CORE::shift;'TypeConstraint'};
sub field_names{my $self=CORE::shift;['value', 'where_expr']};
sub field_values{my $self=CORE::shift;[$self->value, $self->where_expr]};
sub irx1_describe{my $self=CORE::shift;(((('TypeConstraint(' . $self->value->irx1_describe()) . ',') . $self->where_expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::PostConstraint; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'multisig' => (is => 'rw');;
has 'where_expr' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$multisig,$where_expr)=@_;
$self->new('match', $match, 'multisig', $multisig, 'where_expr', $where_expr)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__PostConstraint($self)};
sub node_name{my $self=CORE::shift;'PostConstraint'};
sub field_names{my $self=CORE::shift;['multisig', 'where_expr']};
sub field_values{my $self=CORE::shift;[$self->multisig, $self->where_expr]};
sub irx1_describe{my $self=CORE::shift;(((('PostConstraint(' . $self->multisig->irx1_describe()) . ',') . $self->where_expr->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::ParamVar; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'sigil' => (is => 'rw');;
has 'twigil' => (is => 'rw');;
has 'name' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$sigil,$twigil,$name)=@_;
$self->new('match', $match, 'sigil', $sigil, 'twigil', $twigil, 'name', $name)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__ParamVar($self)};
sub node_name{my $self=CORE::shift;'ParamVar'};
sub field_names{my $self=CORE::shift;['sigil', 'twigil', 'name']};
sub field_values{my $self=CORE::shift;[$self->sigil, $self->twigil, $self->name]};
sub irx1_describe{my $self=CORE::shift;(((((('ParamVar(' . $self->sigil->irx1_describe()) . ',') . $self->twigil->irx1_describe()) . ',') . $self->name->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Undef; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match)=@_;
$self->new('match', $match)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Undef($self)};
sub node_name{my $self=CORE::shift;'Undef'};
sub field_names{my $self=CORE::shift;[]};
sub field_values{my $self=CORE::shift;[]};
sub irx1_describe{my $self=CORE::shift;('Undef(' . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::NumInt; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'text' => (is => 'rw');;
has 'base' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$text,$base)=@_;
$self->new('match', $match, 'text', $text, 'base', $base)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__NumInt($self)};
sub node_name{my $self=CORE::shift;'NumInt'};
sub field_names{my $self=CORE::shift;['text', 'base']};
sub field_values{my $self=CORE::shift;[$self->text, $self->base]};
sub irx1_describe{my $self=CORE::shift;(((('NumInt(' . $self->text->irx1_describe()) . ',') . $self->base->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::NumDec; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'intpart' => (is => 'rw');;
has 'fracpart' => (is => 'rw');;
has 'exp' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$intpart,$fracpart,$exp)=@_;
$self->new('match', $match, 'intpart', $intpart, 'fracpart', $fracpart, 'exp', $exp)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__NumDec($self)};
sub node_name{my $self=CORE::shift;'NumDec'};
sub field_names{my $self=CORE::shift;['intpart', 'fracpart', 'exp']};
sub field_values{my $self=CORE::shift;[$self->intpart, $self->fracpart, $self->exp]};
sub irx1_describe{my $self=CORE::shift;(((((('NumDec(' . $self->intpart->irx1_describe()) . ',') . $self->fracpart->irx1_describe()) . ',') . $self->exp->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::NumRad; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'radix' => (is => 'rw');;
has 'intpart' => (is => 'rw');;
has 'fracpart' => (is => 'rw');;
has 'base' => (is => 'rw');;
has 'exp' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$radix,$intpart,$fracpart,$base,$exp)=@_;
$self->new('match', $match, 'radix', $radix, 'intpart', $intpart, 'fracpart', $fracpart, 'base', $base, 'exp', $exp)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__NumRad($self)};
sub node_name{my $self=CORE::shift;'NumRad'};
sub field_names{my $self=CORE::shift;['radix', 'intpart', 'fracpart', 'base', 'exp']};
sub field_values{my $self=CORE::shift;[$self->radix, $self->intpart, $self->fracpart, $self->base, $self->exp]};
sub irx1_describe{my $self=CORE::shift;(((((((((('NumRad(' . $self->radix->irx1_describe()) . ',') . $self->intpart->irx1_describe()) . ',') . $self->fracpart->irx1_describe()) . ',') . $self->base->irx1_describe()) . ',') . $self->exp->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Array; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'array' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$array)=@_;
$self->new('match', $match, 'array', $array)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Array($self)};
sub node_name{my $self=CORE::shift;'Array'};
sub field_names{my $self=CORE::shift;['array']};
sub field_values{my $self=CORE::shift;[$self->array]};
sub irx1_describe{my $self=CORE::shift;(('Array(' . $self->array->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Hash; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'hash' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$hash)=@_;
$self->new('match', $match, 'hash', $hash)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Hash($self)};
sub node_name{my $self=CORE::shift;'Hash'};
sub field_names{my $self=CORE::shift;['hash']};
sub field_values{my $self=CORE::shift;[$self->hash]};
sub irx1_describe{my $self=CORE::shift;(('Hash(' . $self->hash->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Pair; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'key' => (is => 'rw');;
has 'value' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$key,$value)=@_;
$self->new('match', $match, 'key', $key, 'value', $value)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Pair($self)};
sub node_name{my $self=CORE::shift;'Pair'};
sub field_names{my $self=CORE::shift;['key', 'value']};
sub field_values{my $self=CORE::shift;[$self->key, $self->value]};
sub irx1_describe{my $self=CORE::shift;(((('Pair(' . $self->key->irx1_describe()) . ',') . $self->value->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Type; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'typename' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$typename)=@_;
$self->new('match', $match, 'typename', $typename)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Type($self)};
sub node_name{my $self=CORE::shift;'Type'};
sub field_names{my $self=CORE::shift;['typename']};
sub field_values{my $self=CORE::shift;[$self->typename]};
sub irx1_describe{my $self=CORE::shift;(('Type(' . $self->typename->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Rx; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'pat' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$pat)=@_;
$self->new('match', $match, 'pat', $pat)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Rx($self)};
sub node_name{my $self=CORE::shift;'Rx'};
sub field_names{my $self=CORE::shift;['pat']};
sub field_values{my $self=CORE::shift;[$self->pat]};
sub irx1_describe{my $self=CORE::shift;(('Rx(' . $self->pat->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Buf; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'buf' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$buf)=@_;
$self->new('match', $match, 'buf', $buf)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Buf($self)};
sub node_name{my $self=CORE::shift;'Buf'};
sub field_names{my $self=CORE::shift;['buf']};
sub field_values{my $self=CORE::shift;[$self->buf]};
sub irx1_describe{my $self=CORE::shift;(('Buf(' . $self->buf->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::For; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'expr' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$expr,$block)=@_;
$self->new('match', $match, 'expr', $expr, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__For($self)};
sub node_name{my $self=CORE::shift;'For'};
sub field_names{my $self=CORE::shift;['expr', 'block']};
sub field_values{my $self=CORE::shift;[$self->expr, $self->block]};
sub irx1_describe{my $self=CORE::shift;(((('For(' . $self->expr->irx1_describe()) . ',') . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Cond; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'clauses' => (is => 'rw');;
has 'default' => (is => 'rw');;
has 'invert_first_test' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$clauses,$default,$invert_first_test)=@_;
$self->new('match', $match, 'clauses', $clauses, 'default', $default, 'invert_first_test', $invert_first_test)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Cond($self)};
sub node_name{my $self=CORE::shift;'Cond'};
sub field_names{my $self=CORE::shift;['clauses', 'default', 'invert_first_test']};
sub field_values{my $self=CORE::shift;[$self->clauses, $self->default, $self->invert_first_test]};
sub irx1_describe{my $self=CORE::shift;(((((('Cond(' . $self->clauses->irx1_describe()) . ',') . $self->default->irx1_describe()) . ',') . $self->invert_first_test->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Loop; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'pretest' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'posttest' => (is => 'rw');;
has 'label' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$pretest,$block,$posttest,$label)=@_;
$self->new('match', $match, 'pretest', $pretest, 'block', $block, 'posttest', $posttest, 'label', $label)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Loop($self)};
sub node_name{my $self=CORE::shift;'Loop'};
sub field_names{my $self=CORE::shift;['pretest', 'block', 'posttest', 'label']};
sub field_values{my $self=CORE::shift;[$self->pretest, $self->block, $self->posttest, $self->label]};
sub irx1_describe{my $self=CORE::shift;(((((((('Loop(' . $self->pretest->irx1_describe()) . ',') . $self->block->irx1_describe()) . ',') . $self->posttest->irx1_describe()) . ',') . $self->label->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RegexDef; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'ident' => (is => 'rw');;
has 'pattern' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$ident,$pattern)=@_;
$self->new('match', $match, 'ident', $ident, 'pattern', $pattern)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RegexDef($self)};
sub node_name{my $self=CORE::shift;'RegexDef'};
sub field_names{my $self=CORE::shift;['ident', 'pattern']};
sub field_values{my $self=CORE::shift;[$self->ident, $self->pattern]};
sub irx1_describe{my $self=CORE::shift;(((('RegexDef(' . $self->ident->irx1_describe()) . ',') . $self->pattern->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Regex; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__Regex($self)};
sub node_name{my $self=CORE::shift;'Regex'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('Regex(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxFirst; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxFirst($self)};
sub node_name{my $self=CORE::shift;'RxFirst'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxFirst(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxEvery; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxEvery($self)};
sub node_name{my $self=CORE::shift;'RxEvery'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxEvery(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxSubmatch; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxSubmatch($self)};
sub node_name{my $self=CORE::shift;'RxSubmatch'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxSubmatch(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxAny; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxAny($self)};
sub node_name{my $self=CORE::shift;'RxAny'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxAny(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxAll; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxAll($self)};
sub node_name{my $self=CORE::shift;'RxAll'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxAll(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxSequence; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'patterns' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$patterns)=@_;
$self->new('match', $match, 'patterns', $patterns)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxSequence($self)};
sub node_name{my $self=CORE::shift;'RxSequence'};
sub field_names{my $self=CORE::shift;['patterns']};
sub field_values{my $self=CORE::shift;[$self->patterns]};
sub irx1_describe{my $self=CORE::shift;(('RxSequence(' . $self->patterns->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxQuantifiedAtom; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'atom' => (is => 'rw');;
has 'quantifier' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$atom,$quantifier)=@_;
$self->new('match', $match, 'atom', $atom, 'quantifier', $quantifier)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxQuantifiedAtom($self)};
sub node_name{my $self=CORE::shift;'RxQuantifiedAtom'};
sub field_names{my $self=CORE::shift;['atom', 'quantifier']};
sub field_values{my $self=CORE::shift;[$self->atom, $self->quantifier]};
sub irx1_describe{my $self=CORE::shift;(((('RxQuantifiedAtom(' . $self->atom->irx1_describe()) . ',') . $self->quantifier->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxBackslash; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'char' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$char)=@_;
$self->new('match', $match, 'char', $char)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxBackslash($self)};
sub node_name{my $self=CORE::shift;'RxBackslash'};
sub field_names{my $self=CORE::shift;['char']};
sub field_values{my $self=CORE::shift;[$self->char]};
sub irx1_describe{my $self=CORE::shift;(('RxBackslash(' . $self->char->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxAssertion; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'ident' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$ident)=@_;
$self->new('match', $match, 'ident', $ident)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxAssertion($self)};
sub node_name{my $self=CORE::shift;'RxAssertion'};
sub field_names{my $self=CORE::shift;['ident']};
sub field_values{my $self=CORE::shift;[$self->ident]};
sub irx1_describe{my $self=CORE::shift;(('RxAssertion(' . $self->ident->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxModInternal; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'mod' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$mod)=@_;
$self->new('match', $match, 'mod', $mod)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxModInternal($self)};
sub node_name{my $self=CORE::shift;'RxModInternal'};
sub field_names{my $self=CORE::shift;['mod']};
sub field_values{my $self=CORE::shift;[$self->mod]};
sub irx1_describe{my $self=CORE::shift;(('RxModInternal(' . $self->mod->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxCapture; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'pattern' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$pattern)=@_;
$self->new('match', $match, 'pattern', $pattern)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxCapture($self)};
sub node_name{my $self=CORE::shift;'RxCapture'};
sub field_names{my $self=CORE::shift;['pattern']};
sub field_values{my $self=CORE::shift;[$self->pattern]};
sub irx1_describe{my $self=CORE::shift;(('RxCapture(' . $self->pattern->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxGroup; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'pattern' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$pattern)=@_;
$self->new('match', $match, 'pattern', $pattern)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxGroup($self)};
sub node_name{my $self=CORE::shift;'RxGroup'};
sub field_names{my $self=CORE::shift;['pattern']};
sub field_values{my $self=CORE::shift;[$self->pattern]};
sub irx1_describe{my $self=CORE::shift;(('RxGroup(' . $self->pattern->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxBlock; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'block' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$block)=@_;
$self->new('match', $match, 'block', $block)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxBlock($self)};
sub node_name{my $self=CORE::shift;'RxBlock'};
sub field_names{my $self=CORE::shift;['block']};
sub field_values{my $self=CORE::shift;[$self->block]};
sub irx1_describe{my $self=CORE::shift;(('RxBlock(' . $self->block->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxBind; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'var' => (is => 'rw');;
has 'binding' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$var,$binding)=@_;
$self->new('match', $match, 'var', $var, 'binding', $binding)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxBind($self)};
sub node_name{my $self=CORE::shift;'RxBind'};
sub field_names{my $self=CORE::shift;['var', 'binding']};
sub field_values{my $self=CORE::shift;[$self->var, $self->binding]};
sub irx1_describe{my $self=CORE::shift;(((('RxBind(' . $self->var->irx1_describe()) . ',') . $self->binding->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxLiteral; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'text' => (is => 'rw');;
has 'quote' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$text,$quote)=@_;
$self->new('match', $match, 'text', $text, 'quote', $quote)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxLiteral($self)};
sub node_name{my $self=CORE::shift;'RxLiteral'};
sub field_names{my $self=CORE::shift;['text', 'quote']};
sub field_values{my $self=CORE::shift;[$self->text, $self->quote]};
sub irx1_describe{my $self=CORE::shift;(((('RxLiteral(' . $self->text->irx1_describe()) . ',') . $self->quote->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::RxSymbol; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
use base 'IRx1::Base';
has 'match' => (is => 'rw');;
has 'symbol' => (is => 'rw');;
has 'notes' => (is => 'rw');;
sub newp{my $self=CORE::shift;my($match,$symbol)=@_;
$self->new('match', $match, 'symbol', $symbol)};
sub callback{my $self=CORE::shift;my($emitter)=@_;
$emitter->cb__RxSymbol($self)};
sub node_name{my $self=CORE::shift;'RxSymbol'};
sub field_names{my $self=CORE::shift;['symbol']};
sub field_values{my $self=CORE::shift;[$self->symbol]};
sub irx1_describe{my $self=CORE::shift;(('RxSymbol(' . $self->symbol->irx1_describe()) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package IRx1_Build; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
has 'constructors' => (is => 'rw');;
($main::irbuilder = IRx1_Build->new());
sub add_constructor{my $self=CORE::shift;my($k,$constructor)=@_;
if($self->constructors) {

}else {
my $h = {};
$self->constructors($h)
};
($self->constructors->{$k} = $constructor)};
sub make_ir_from_Match_tree{my $self=CORE::shift;my($m)=@_;
my $rule = $m->rule();
my $constructor = $self->constructors->{$rule};
if(($constructor)) {
$constructor->($m)
}else {
GLOBAL::die((('Unknown rule: ' . $rule) . '
It needs to be added to ast_handlers.
'))
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package Match; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub make_ir_from_Match_tree{my $self=CORE::shift;$main::irbuilder->make_ir_from_Match_tree($self)};
# __PACKAGE__->meta->make_immutable();

}
;

{ package ARRAY; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub make_ir_from_Match_tree{my $self=CORE::shift;$self->map(sub {my($e)=@_;
$e->make_ir_from_Match_tree()})};
# __PACKAGE__->meta->make_immutable();

}
;

{ package SCALAR; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub make_ir_from_Match_tree{my $self=CORE::shift;$self};
# __PACKAGE__->meta->make_immutable();

}
;

{ package UNDEF; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub make_ir_from_Match_tree{my $self=CORE::shift;$self};
# __PACKAGE__->meta->make_immutable();

}
;
sub irbuild_ir{my($x)=@_;
$x->make_ir_from_Match_tree()};

{ package IRx1_Build; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub irbuild_ir{my($x)=@_;
$x->make_ir_from_Match_tree()};
$main::irbuilder->add_constructor('comp_unit', sub {my($m)=@_;
IRx1::CompUnit->newp($m, irbuild_ir($m->{'hash'}->{'statementlist'}))});
$main::irbuilder->add_constructor('statement', sub {my($m)=@_;
my $key;
for($m->{'hash'}->keys()->flatten){
if(($_ ne 'match')) {
if($key) {
GLOBAL::die('Unexpectedly more than 1 field - dont know which to choose
')
};
($key = $_)
}
};
my $one = irbuild_ir($m->{'hash'}->{$key});
$one});
$main::irbuilder->add_constructor('expect_infix', sub {my($m)=@_;
if(irbuild_ir($m->{'hash'}->{'infix'})) {
if(irbuild_ir($m->{'hash'}->{'infix_postfix_meta_operator'})) {
GLOBAL::die('Unimplemented infix_postfix_meta_operator')
};
my $op = irbuild_ir($m->{'hash'}->{'infix'}->{'hash'}->{'sym'});
IRx1::Apply->newp($m, ('infix:' . $op), IRx1::Capture->newp($m, irbuild_ir($m->{'hash'}->{'args'})))
}else {
GLOBAL::die('Unimplemented infix_prefix_meta_operator or infix_circumfix_meta_operator')
}});
$main::irbuilder->add_constructor('expect_term', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__expect_term_base'};local $::es_blackboard__expect_term_base = irbuild_ir($m->{'hash'}->{'noun'});
my $ops = [];
if($m->{'hash'}->{'pre'}) {
$ops->push($m->{'hash'}->{'pre'}->flatten())
};
if($m->{'hash'}->{'post'}) {
$ops->push($m->{'hash'}->{'post'}->flatten())
};
for($ops->flatten){
($::es_blackboard__expect_term_base = irbuild_ir($_))
};
$::es_blackboard__expect_term_base});
$main::irbuilder->add_constructor('term:expect_term', sub {my($m)=@_;
irbuild_ir($m->{'hash'}->{'noun'})});
$main::irbuilder->add_constructor('post', sub {my($m)=@_;
if($m->{'hash'}->{'args'}) {
irbuild_ir($m->{'hash'}->{'args'})->[0]
}else {
(irbuild_ir($m->{'hash'}->{'dotty'}) or irbuild_ir($m->{'hash'}->{'postop'}))
}});
$main::irbuilder->add_constructor('pre', sub {my($m)=@_;
if($m->{'hash'}->{'args'}) {
irbuild_ir($m->{'hash'}->{'args'})->[0]
}elsif($m->{'hash'}->{'prefix'}) {
irbuild_ir($m->{'hash'}->{'prefix'})
}else {
GLOBAL::die('pre without a prefix is unimplemented')
}});
$main::irbuilder->add_constructor('dotty:methodop', sub {my($m)=@_;
IRx1::Call->newp($m, $::es_blackboard__expect_term_base, irbuild_ir($m->{'hash'}->{'ident'}), IRx1::Capture->newp($m, irbuild_ir($m->{'hash'}->{'semilist'})))});
$main::irbuilder->add_constructor('dotty:postcircumfix', sub {my($m)=@_;
my $s = ($m->match_string());
my $name = ((GLOBAL::substr($s, 0, 1) . ' ') . GLOBAL::substr($s, (-1), 1));
my $ident = ('postcircumfix:' . $name);
my $args = irbuild_ir($m->{'hash'}->{'kludge_name'});
if(($args && (($args->ref() eq 'SCALAR')))) {
($args = [$args])
};
IRx1::Call->newp($m, $::es_blackboard__expect_term_base, $ident, IRx1::Capture->newp($m, $args))});
$main::irbuilder->add_constructor('postcircumfix', sub {my($m)=@_;
my $s = ($m->match_string());
my $name = ((GLOBAL::substr($s, 0, 1) . ' ') . GLOBAL::substr($s, (-1), 1));
my $ident = ('postcircumfix:' . $name);
my $args = irbuild_ir($m->{'hash'}->{'kludge_name'});
if(($args && (($args->ref() eq 'SCALAR')))) {
($args = [$args])
};
IRx1::Call->newp($m, $::es_blackboard__expect_term_base, $ident, IRx1::Capture->newp($m, $args))});
$main::irbuilder->add_constructor('postfix', sub {my($m)=@_;
my $op = ($m->match_string());
IRx1::Apply->newp($m, ('postfix:' . $op), IRx1::Capture->newp($m, [$::es_blackboard__expect_term_base]))});
$main::irbuilder->add_constructor('prefix', sub {my($m)=@_;
my $op = ($m->match_string());
IRx1::Apply->newp($m, ('prefix:' . $op), IRx1::Capture->newp($m, [$::es_blackboard__expect_term_base]))});
$main::irbuilder->add_constructor('infix', sub {my($m)=@_;
my $op = ($m->match_string());
IRx1::Apply->newp($m, ('infix:' . $op), IRx1::Capture->newp($m, [irbuild_ir($m->{'hash'}->{'left'}), irbuild_ir($m->{'hash'}->{'right'})]))});
$main::irbuilder->add_constructor('term', sub {my($m)=@_;
my $text = ($m->match_string());
if(($text eq 'self')) {
IRx1::Apply->newp($m, 'self', IRx1::Capture->newp($m, []))
}elsif(($text eq '*')) {
IRx1::Apply->newp($m, 'whatever', IRx1::Capture->newp($m, []))
}else {
GLOBAL::die('AST term partially unimplemented.
')
}});
$main::irbuilder->add_constructor('integer', sub {my($m)=@_;
IRx1::NumInt->newp($m, ($m->match_string()))});
$main::irbuilder->add_constructor('subcall', sub {my($m)=@_;
my $t = irbuild_ir($m->{'hash'}->{'subshortname'}->{'hash'}->{'twigil'});
if(($t && ($t eq '.'))) {
IRx1::Call->newp($m, IRx1::Apply->newp($m, 'self', IRx1::Capture->newp($m, [])), irbuild_ir($m->{'hash'}->{'subshortname'}->{'hash'}->{'desigilname'}->{'hash'}->{'ident'}), IRx1::Capture->newp($m, irbuild_ir($m->{'hash'}->{'semilist'})))
}else {
IRx1::Apply->newp($m, irbuild_ir($m->{'hash'}->{'subshortname'}), IRx1::Capture->newp($m, irbuild_ir($m->{'hash'}->{'semilist'})))
}});
$main::irbuilder->add_constructor('name', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('subshortname', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('statement_control:use', sub {my($m)=@_;
IRx1::Use->newp($m, 'use', irbuild_ir($m->{'hash'}->{'module_name'}), irbuild_ir($m->{'hash'}->{'EXPR'}))});
$main::irbuilder->add_constructor('module_name:depreciated', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('module_name:normal', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('statement_control:BEGIN', sub {my($m)=@_;
IRx1::ClosureTrait->newp($m, 'BEGIN', irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('term:listop', sub {my($m)=@_;
my $not_really_an_arglist = irbuild_ir($m->{'hash'}->{'arglist'});
if(irbuild_ir($m->{'hash'}->{'arglist'})) {
IRx1::Apply->newp($m, irbuild_ir($m->{'hash'}->{'ident'}), IRx1::Capture->newp($m, [$not_really_an_arglist]))
}else {
IRx1::Apply->newp($m, irbuild_ir($m->{'hash'}->{'ident'}), IRx1::Capture->newp($m, []))
}});
$main::irbuilder->add_constructor('quote:q', sub {my($m)=@_;
IRx1::Buf->newp($m, irbuild_ir($m->{'hash'}->{'text'}))});
$main::irbuilder->add_constructor('quote:qq', sub {my($m)=@_;
my $s = irbuild_ir($m->{'hash'}->{'text'});
$s->re_gsub(qr/(?<!\\)\\n/, '
');
$s->re_gsub(qr/(?<!\\)\\t/, '	');
IRx1::Buf->newp($m, $s)});
$main::irbuilder->add_constructor('quote:regex', sub {my($m)=@_;
my $s = irbuild_ir($m->{'hash'}->{'text'});
IRx1::Rx->newp($m, $s)});
$main::irbuilder->add_constructor('scope_declarator:my', sub {my($m)=@_;
my $vd = irbuild_ir($m->{'hash'}->{'scoped'})->[0];
IRx1::VarDecl->newp($m, 'my', GLOBAL::undef(), GLOBAL::undef(), $vd->[0], GLOBAL::undef(), GLOBAL::undef(), '=', $vd->[1])});
$main::irbuilder->add_constructor('scope_declarator:has', sub {my($m)=@_;
my $vd = irbuild_ir($m->{'hash'}->{'scoped'})->[0];
IRx1::VarDecl->newp($m, 'has', GLOBAL::undef(), GLOBAL::undef(), $vd->[0], GLOBAL::undef(), GLOBAL::undef(), '=', $vd->[1])});
$main::irbuilder->add_constructor('scope_declarator:our', sub {my($m)=@_;
my $vd = irbuild_ir($m->{'hash'}->{'scoped'})->[0];
IRx1::VarDecl->newp($m, 'our', GLOBAL::undef(), GLOBAL::undef(), $vd->[0], GLOBAL::undef(), GLOBAL::undef(), '=', $vd->[1])});
$main::irbuilder->add_constructor('scoped', sub {my($m)=@_;
[irbuild_ir($m->{'hash'}->{'variable_decl'}), irbuild_ir($m->{'hash'}->{'fulltypename'})]});
$main::irbuilder->add_constructor('variable_decl', sub {my($m)=@_;
[irbuild_ir($m->{'hash'}->{'variable'}), irbuild_ir($m->{'hash'}->{'default_value'})]});
$main::irbuilder->add_constructor('variable', sub {my($m)=@_;
my $tw = irbuild_ir($m->{'hash'}->{'twigil'});
if($m->{'hash'}->{'postcircumfix'}) {
if(($tw eq '.')) {
my $slf = IRx1::Apply->newp($m, 'self', IRx1::Capture->newp($m, []));
my $args = irbuild_ir($m->{'hash'}->{'postcircumfix'}->{'hash'}->{'kludge_name'});
if(($args && (($args->ref() eq 'SCALAR')))) {
($args = [$args])
};
IRx1::Call->newp($m, $slf, irbuild_ir($m->{'hash'}->{'desigilname'}), IRx1::Capture->newp($m, $args))
}else {
my $v = IRx1::Var->newp($m, irbuild_ir($m->{'hash'}->{'sigil'}), $tw, irbuild_ir($m->{'hash'}->{'desigilname'}));
{package main; use vars '$1es_blackboard__expect_term_base'};local $::es_blackboard__expect_term_base = $v;
irbuild_ir($m->{'hash'}->{'postcircumfix'})
}
}else {
IRx1::Var->newp($m, irbuild_ir($m->{'hash'}->{'sigil'}), $tw, irbuild_ir($m->{'hash'}->{'desigilname'}))
}});
$main::irbuilder->add_constructor('sigil', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('twigil', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('special_variable', sub {my($m)=@_;
my $v = ($m->match_string());
my $s = GLOBAL::substr($v, 0, 1);
my $n = GLOBAL::substr($v, 1, $v->length());
IRx1::Var->newp($m, $s, GLOBAL::undef(), $n)});
$main::irbuilder->add_constructor('circumfix', sub {my($m)=@_;
my $s = ($m->match_string());
my $name = ((GLOBAL::substr($s, 0, 1) . ' ') . GLOBAL::substr($s, (-1), 1));
my $args = irbuild_ir($m->{'hash'}->{'kludge_name'});
if(($args && (($args->ref() eq 'SCALAR')))) {
($args = [$args])
};
IRx1::Apply->newp($m, ('circumfix:' . $name), IRx1::Capture->newp($m, $args))});
$main::irbuilder->add_constructor('statement_control:for', sub {my($m)=@_;
IRx1::For->newp($m, irbuild_ir($m->{'hash'}->{'expr'}), irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('statement_control:while', sub {my($m)=@_;
IRx1::Loop->newp($m, irbuild_ir($m->{'hash'}->{'expr'}), irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('statement_control:if', sub {my($m)=@_;
my $els = irbuild_ir($m->{'hash'}->{'else'});
if($els) {
($els = $els->[0])
};
IRx1::Cond->newp($m, [[irbuild_ir($m->{'hash'}->{'if_expr'}), irbuild_ir($m->{'hash'}->{'if_block'})]]->push(irbuild_ir($m->{'hash'}->{'elsif'})->flatten()), $els)});
$main::irbuilder->add_constructor('elsif', sub {my($m)=@_;
[irbuild_ir($m->{'hash'}->{'elsif_expr'}), irbuild_ir($m->{'hash'}->{'elsif_block'})]});
$main::irbuilder->add_constructor('if__else', sub {my($m)=@_;
my $key;
for($m->{'hash'}->keys()->flatten){
if(($_ ne 'match')) {
if($key) {
GLOBAL::die('Unexpectedly more than 1 field - dont know which to choose
')
};
($key = $_)
}
};
my $one = irbuild_ir($m->{'hash'}->{$key});
$one});
$main::irbuilder->add_constructor('statement_prefix:do', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:do', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('statement_prefix:try', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:try', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('statement_prefix:gather', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:gather', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('statement_prefix:contend', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:contend', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('statement_prefix:async', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:async', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('statement_prefix:lazy', sub {my($m)=@_;
IRx1::Apply->newp($m, 'statement_prefix:lazy', irbuild_ir($m->{'hash'}->{'statement'}))});
$main::irbuilder->add_constructor('pblock', sub {my($m)=@_;
if($m->{'hash'}->{'signature'}) {
IRx1::SubDecl->newp($m, GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), irbuild_ir($m->{'hash'}->{'signature'}), GLOBAL::undef(), irbuild_ir($m->{'hash'}->{'block'}))
}else {
irbuild_ir($m->{'hash'}->{'block'})
}});
$main::irbuilder->add_constructor('block', sub {my($m)=@_;
IRx1::Block->newp($m, irbuild_ir($m->{'hash'}->{'statementlist'}))});
$main::irbuilder->add_constructor('plurality_declarator:multi', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__plurality'};local $::es_blackboard__plurality = 'multi';
irbuild_ir($m->{'hash'}->{'pluralized'})});
$main::irbuilder->add_constructor('routine_declarator:routine_def', sub {my($m)=@_;
my $plurality = $::es_blackboard__plurality;
{package main; use vars '$1es_blackboard__plurality'};local $::es_blackboard__plurality;
my $ident = '';
if($m->{'hash'}->{'ident'}) {
($ident = irbuild_ir($m->{'hash'}->{'ident'}))
};
my $sig = IRx1::Signature->newp($m, [], GLOBAL::undef());
if(irbuild_ir($m->{'hash'}->{'multisig'})) {
($sig = irbuild_ir($m->{'hash'}->{'multisig'})->[0])
};
IRx1::SubDecl->newp($m, GLOBAL::undef(), GLOBAL::undef(), $plurality, $ident, $sig, irbuild_ir($m->{'hash'}->{'trait'}), irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('routine_declarator:method_def', sub {my($m)=@_;
my $plurality = $::es_blackboard__plurality;
{package main; use vars '$1es_blackboard__plurality'};local $::es_blackboard__plurality;
IRx1::MethodDecl->newp($m, GLOBAL::undef(), GLOBAL::undef(), $plurality, irbuild_ir($m->{'hash'}->{'ident'}), irbuild_ir($m->{'hash'}->{'multisig'})->[0], GLOBAL::undef(), irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('signature', sub {my($m)=@_;
IRx1::Signature->newp($m, irbuild_ir($m->{'hash'}->{'parsep'}), GLOBAL::undef())});
$main::irbuilder->add_constructor('parameter', sub {my($m)=@_;
IRx1::Parameter->newp($m, irbuild_ir($m->{'hash'}->{'type_constraint'}), irbuild_ir($m->{'hash'}->{'quantchar'}), irbuild_ir($m->{'hash'}->{'param_var'}))});
$main::irbuilder->add_constructor('param_var', sub {my($m)=@_;
IRx1::ParamVar->newp($m, irbuild_ir($m->{'hash'}->{'sigil'}), irbuild_ir($m->{'hash'}->{'twigil'}), irbuild_ir($m->{'hash'}->{'ident'}))});
$main::irbuilder->add_constructor('colonpair', sub {my($m)=@_;
my $key;
for($m->{'hash'}->keys()->flatten){
if(($_ ne 'match')) {
if($key) {
GLOBAL::die('Unexpectedly more than 1 field - dont know which to choose
')
};
($key = $_)
}
};
my $one = irbuild_ir($m->{'hash'}->{$key});
$one});
$main::irbuilder->add_constructor('colonpair__false', sub {my($m)=@_;
IRx1::Pair->newp($m, irbuild_ir($m->{'hash'}->{'ident'}), IRx1::NumInt->newp($m, 0))});
$main::irbuilder->add_constructor('colonpair__value', sub {my($m)=@_;
my $value;
if($m->{'hash'}->{'postcircumfix'}) {
($value = irbuild_ir($m->{'hash'}->{'postcircumfix'}))
}else {
($value = IRx1::NumInt->newp($m, 1))
};
IRx1::Pair->newp($m, irbuild_ir($m->{'hash'}->{'ident'}), $value)});
$main::irbuilder->add_constructor('package_declarator:class', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__package_declarator'};local $::es_blackboard__package_declarator = 'class';
irbuild_ir($m->{'hash'}->{'package_def'})});
$main::irbuilder->add_constructor('package_declarator:module', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__package_declarator'};local $::es_blackboard__package_declarator = 'module';
irbuild_ir($m->{'hash'}->{'package_def'})});
$main::irbuilder->add_constructor('package_declarator:package', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__package_declarator'};local $::es_blackboard__package_declarator = 'package';
irbuild_ir($m->{'hash'}->{'package_def'})});
$main::irbuilder->add_constructor('package_declarator:grammar', sub {my($m)=@_;
{package main; use vars '$1es_blackboard__package_declarator'};local $::es_blackboard__package_declarator = 'grammar';
irbuild_ir($m->{'hash'}->{'package_def'})});
$main::irbuilder->add_constructor('package_def', sub {my($m)=@_;
IRx1::PackageDecl->newp($m, GLOBAL::undef(), GLOBAL::undef(), $::es_blackboard__package_declarator, irbuild_ir($m->{'hash'}->{'module_name'})->[0], irbuild_ir($m->{'hash'}->{'traits'}), irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('fulltypename', sub {my($m)=@_;
irbuild_ir($m->{'hash'}->{'typename'})->join('::')});
$main::irbuilder->add_constructor('typename', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('trait_verb:is', sub {my($m)=@_;
IRx1::Trait->newp($m, 'is', irbuild_ir($m->{'hash'}->{'ident'}))});
$main::irbuilder->add_constructor('circumfix:pblock', sub {my($m)=@_;
if((($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}->elems() == 0) or ($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}->[0]->match_string() =~ qr/^:/))) {
IRx1::Hash->newp($m, irbuild_ir($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}))
}elsif((($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}->[0]->{'hash'}->{'expr'} and $m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}->[0]->{'hash'}->{'expr'}->{'hash'}->{'sym'}) and ($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}->[0]->{'hash'}->{'expr'}->{'hash'}->{'sym'} eq ','))) {
IRx1::Hash->newp($m, irbuild_ir($m->{'hash'}->{'block'}->{'hash'}->{'statementlist'}))
}elsif((GLOBAL::not(irbuild_ir($m->{'hash'}->{'lambda'})) and GLOBAL::not(irbuild_ir($m->{'hash'}->{'signature'})))) {
my $s = IRx1::SubDecl->newp($m, GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), GLOBAL::undef(), irbuild_ir($m->{'hash'}->{'block'}));
IRx1::Apply->newp($m, $s, IRx1::Capture->newp($m, []))
}else {
GLOBAL::die('AST handler circumfix:pblock partially unimplemented')
}});
$main::irbuilder->add_constructor('regex_declarator:regex_def', sub {my($m)=@_;
IRx1::RegexDef->newp($m, irbuild_ir($m->{'hash'}->{'ident'}), irbuild_ir($m->{'hash'}->{'regex_block'}))});
$main::irbuilder->add_constructor('regex_block', sub {my($m)=@_;
irbuild_ir($m->{'hash'}->{'regex'})});
$main::irbuilder->add_constructor('regex', sub {my($m)=@_;
IRx1::Regex->newp($m, irbuild_ir($m->{'hash'}->{'pattern'}))});
$main::irbuilder->add_constructor('regex_first', sub {my($m)=@_;
IRx1::RxFirst->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_every', sub {my($m)=@_;
IRx1::RxEvery->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_submatch', sub {my($m)=@_;
IRx1::RxSubmatch->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_any', sub {my($m)=@_;
IRx1::RxAny->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_all', sub {my($m)=@_;
IRx1::RxAll->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_sequence', sub {my($m)=@_;
IRx1::RxSequence->newp($m, irbuild_ir($m->{'hash'}->{'patterns'}))});
$main::irbuilder->add_constructor('regex_quantified_atom', sub {my($m)=@_;
IRx1::RxQuantifiedAtom->newp($m, irbuild_ir($m->{'hash'}->{'regex_atom'}), irbuild_ir($m->{'hash'}->{'regex_quantifier'}))});
$main::irbuilder->add_constructor('regex_quantifier', sub {my($m)=@_;
($m->match_string())});
$main::irbuilder->add_constructor('regex_atom', sub {my($m)=@_;
my $key;
for($m->{'hash'}->keys()->flatten){
if(($_ ne 'match')) {
if($key) {
GLOBAL::die('Unexpectedly more than 1 field - dont know which to choose
')
};
($key = $_)
}
};
my $one = irbuild_ir($m->{'hash'}->{$key});
if(irbuild_ir($m->{'hash'}->{'char'})) {
IRx1::RxLiteral->newp($m, irbuild_ir($m->{'hash'}->{'char'}), '\'')
}else {
$one
}});
$main::irbuilder->add_constructor('regex_metachar:regex_backslash', sub {my($m)=@_;
IRx1::RxBackslash->newp($m, ($m->match_string()))});
$main::irbuilder->add_constructor('regex_metachar:regex_mod_internal', sub {my($m)=@_;
IRx1::RxModInternal->newp($m, ($m->match_string()))});
$main::irbuilder->add_constructor('regex_assertion:ident', sub {my($m)=@_;
IRx1::RxAssertion->newp($m, irbuild_ir($m->{'hash'}->{'ident'}))});
$main::irbuilder->add_constructor('regex_metachar:capture', sub {my($m)=@_;
IRx1::RxCapture->newp($m, irbuild_ir($m->{'hash'}->{'regex'}->{'hash'}->{'pattern'}))});
$main::irbuilder->add_constructor('regex_metachar:group', sub {my($m)=@_;
IRx1::RxGroup->newp($m, irbuild_ir($m->{'hash'}->{'regex'}->{'hash'}->{'pattern'}))});
$main::irbuilder->add_constructor('regex_metachar:block', sub {my($m)=@_;
IRx1::RxBlock->newp($m, irbuild_ir($m->{'hash'}->{'block'}))});
$main::irbuilder->add_constructor('regex_metachar:var', sub {my($m)=@_;
IRx1::RxBind->newp($m, irbuild_ir($m->{'hash'}->{'variable'}), irbuild_ir($m->{'hash'}->{'binding'}))});
$main::irbuilder->add_constructor('regex_metachar:q', sub {my($m)=@_;
IRx1::RxLiteral->newp($m, irbuild_ir($m->{'hash'}->{'text'}), '\'')});
$main::irbuilder->add_constructor('regex_metachar:qq', sub {my($m)=@_;
IRx1::RxLiteral->newp($m, irbuild_ir($m->{'hash'}->{'text'}), '"')});
$main::irbuilder->add_constructor('regex_metachar', sub {my($m)=@_;
IRx1::RxSymbol->newp($m, ($m->match_string()))});
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package IRx1::CompUnit; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub do_all_analysis{my $self=CORE::shift;$self->initialize_notes();
$self->note_parents();
$self->note_block_lexical_variable_decls();
$self->note_environment()};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Base; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub is_IR_node{my $self=CORE::shift;1};
sub initialize_notes{my $self=CORE::shift;$self->notes({});
my $a = [];
for($self->field_values()->flatten){
if($_->can('is_IR_node')) {
$a->push($_)
}elsif((($_->WHAT() eq 'ARRAY') || ($_->WHAT() eq 'Array'))) {
for($_->flatten){
if($_->can('is_IR_node')) {
$a->push($_)
}elsif((($_->WHAT() eq 'ARRAY') || ($_->WHAT() eq 'Array'))) {
for($_->flatten){
if($_->can('is_IR_node')) {
$a->push($_)
}
}
}
}
}
};
($self->notes()->{'child_nodes'} = $a);
for($self->child_nodes()->flatten){
$_->initialize_notes()
}};
sub destroy_notes{my $self=CORE::shift;for($self->notes()->{'child_nodes'}->flatten){
$_->destroy_notes()
};
$self->notes(GLOBAL::undef())};
sub child_nodes{my $self=CORE::shift;$self->notes()->{'child_nodes'}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_parents{my $self=CORE::shift;{package main; use vars '$1es_whiteboard__parent'};local $::es_whiteboard__parent = $self;
for($self->child_nodes()->flatten){
$_->note_parents()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Base; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_parents{my $self=CORE::shift;($self->notes()->{'parent'} = $::es_whiteboard__parent);
{package main; use vars '$1es_whiteboard__parent'};local $::es_whiteboard__parent = $self;
for($self->child_nodes()->flatten){
$_->note_parents()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit_and_Block; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_block_lexical_variable_decls{my $self=CORE::shift;my $a = [];
{package main; use vars '$1es_whiteboard__lexical_variable_decls'};local $::es_whiteboard__lexical_variable_decls = $a;
($self->notes()->{'lexical_variable_decls'} = $a);
for($self->child_nodes()->flatten){
$_->note_block_lexical_variable_decls()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::VarDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_block_lexical_variable_decls{my $self=CORE::shift;if($self->is_lexical()) {
$::es_whiteboard__lexical_variable_decls->push($self)
};
for($self->child_nodes()->flatten){
$_->note_block_lexical_variable_decls()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::SubDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_block_lexical_variable_decls{my $self=CORE::shift;if($_->name()) {
$::es_whiteboard__lexical_variable_decls->push($self)
};
for($self->child_nodes()->flatten){
$_->note_block_lexical_variable_decls()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Base; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_block_lexical_variable_decls{my $self=CORE::shift;for($self->child_nodes()->flatten){
$_->note_block_lexical_variable_decls()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_environment{my $self=CORE::shift;{package main; use vars '$1es_whiteboard__package_chain'};local $::es_whiteboard__package_chain = [];
{package main; use vars '$1es_whiteboard__lexical_bindings'};local $::es_whiteboard__lexical_bindings = $self->update_lexical_bindings({}, $self->notes()->{'lexical_variable_decls'});
for($self->child_nodes()->flatten){
$_->note_environment()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Block; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_environment{my $self=CORE::shift;{package main; use vars '$1es_whiteboard__lexical_bindings'};local $::es_whiteboard__lexical_bindings = $self->update_lexical_bindings($::es_whiteboard__lexical_bindings, $self->notes()->{'lexical_variable_decls'});
for($self->child_nodes()->flatten){
$_->note_environment()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::CompUnit_and_Block; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub update_lexical_bindings{my $self=CORE::shift;my($h,$decls)=@_;
my $h1 = $h->dup();
for($decls->flatten){
my $k = ($_->sigil() . $_->name());
($h1->{$k} = $_)
};
$h1};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::PackageDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_environment{my $self=CORE::shift;my $new_chain;
if($self->path_is_absolute()) {
($new_chain = [$self])
}else {
($new_chain = [$::es_whiteboard__package_chain->flatten(), $self])
};
{package main; use vars '$1es_whiteboard__package_chain'};local $::es_whiteboard__package_chain = $new_chain;
for($self->child_nodes()->flatten){
$_->note_environment()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Apply; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_environment{my $self=CORE::shift;($self->notes()->{'lexical_bindings'} = $::es_whiteboard__lexical_bindings);
for($self->child_nodes()->flatten){
$_->note_environment()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::Base; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub note_environment{my $self=CORE::shift;for($self->child_nodes()->flatten){
$_->note_environment()
}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::VarDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub is_lexical{my $self=CORE::shift;($self->scope() eq 'my')};
sub sigil{my $self=CORE::shift;$self->{'var'}->{'sigil'}};
sub name{my $self=CORE::shift;$self->{'var'}->{'name'}};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::SubDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub sigil{my $self=CORE::shift;'&'};
# __PACKAGE__->meta->make_immutable();

}
;

{ package IRx1::PackageDecl; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub path_is_absolute{my $self=CORE::shift;($self->name() && ($self->name() =~ qr/^GLOBAL\b'/))};
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package EmitSimpleP5; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub new_emitter{my $self=CORE::shift;my($ignore,$compiler)=@_;
$self->new('compiler', $compiler)};
has 'compiler' => (is => 'rw');;
sub prelude_for_entering_a_package{my $self=CORE::shift;''};
sub prelude_lexical{my $self=CORE::shift;'use autobox;use autobox UNDEF => \'UNDEF\';
      '};
sub prelude_oo{my $self=CORE::shift;'
{package AssertCurrentModuleVersions;
 use Moose 0.40;
 use Moose::Autobox 0.06;
}
'};
sub prelude{my $self=CORE::shift;my($n)=@_;
(('#!/usr/bin/perl -w
use strict;
no strict "subs"; # XXX remove once Type-names are quoted. # say Int.isa(Any)
use warnings;

{package AssertCurrentModuleVersions;
 use autobox 2.23;
}
{ package NoSideEffects;
  use Class::Multimethods;
  use Data::Dumper;
}
' . $self->prelude_oo()) . '

# Move to the Regexp prelude once that becomes part of the prelude.
{ package BacktrackMacrosKludge;
  sub _let_gen {
    my($vars) = @_;
    my $nvars = 1+($vars =~ tr/,//);
    my $tmpvars = join(",",map{"\\$__tmp${_}__"}(0..($nvars-1)));
    push(@SCRATCH::_let_stack,[$vars,$tmpvars]);
    "(do{my \\$__v__ ; my($tmpvars); { local($vars)=($vars); \\$__v__ = do{ ";
  }
  sub _let_end {
    my $e = shift(@SCRATCH::_let_stack) || die "LET(){ }LET pairs didnt match up";
    my($vars,$tmpvars) = @$e;
    "}; if(!FAILED(\\$__v__)){ ($tmpvars)=($vars); }}; if(!FAILED(\\$__v__)){ ($vars)=($tmpvars) }; \\$__v__ })"
  }
}

{package UNDEF;}
{package UNDEF; sub WHAT {"Undef"}}
{package UNIVERSAL; sub ref {CORE::ref($_[0]) || "SCALAR"} } # For IRx1_FromAST.pm.
{package UNIVERSAL; sub WHAT {CORE::ref($_[0]) || "SCALARISH"} }

{ package Object;
  sub can { UNIVERSAL::can($_[0],$_[1]) }
  sub isa { UNIVERSAL::isa($_[0],$_[1]) }
  sub does { UNIVERSAL::isa($_[0],$_[1]) }
}  

no warnings qw(redefine prototype);
{ package SCALAR;
  sub WHAT { my $x = $_[0]; ~$x&$x ? "Str" : $x =~ /\\A\\d+\\z/ ? "Int" : "Num" }

  # randomness taken from autobox::Core

  sub chomp   ($)   { CORE::chomp($_[0]); }
  sub chop    ($)   { CORE::chop($_[0]); }
  sub chr     ($)   { CORE::chr($_[0]); }
  sub crypt   ($$)  { CORE::crypt($_[0], $_[1]); }
  sub index   ($@)  { CORE::index($_[0], $_[1], @_[2.. $#_]); }
  sub lc      ($)   { CORE::lc($_[0]); }
  sub lcfirst ($)   { CORE::lcfirst($_[0]); }
  sub length  ($)   { CORE::length($_[0]); }
  sub ord     ($)   { CORE::ord($_[0]); }
  sub pack    ($;@) { CORE::pack(@_); }
  sub reverse ($)   { CORE::reverse($_[0]); }
  sub rindex  ($@)  { CORE::rindex($_[0], $_[1], @_[2.. $#_]); }
  sub sprintf ($@)  { CORE::sprintf($_[0], $_[1], @_[2.. $#_]); }
  sub substr  ($@)  { CORE::substr($_[0], $_[1], @_[2 .. $#_]); }
  sub uc      ($)   { CORE::uc($_[0]); }
  sub ucfirst ($)   { CORE::ucfirst($_[0]); }
  sub unpack  ($;@) { CORE::unpack($_[0], @_[1..$#_]); }
  sub quotemeta ($) { CORE::quotemeta($_[0]); }
  sub vec     ($$$) { CORE::vec($_[0], $_[1], $_[2]); }
  sub undef   ($)   { $_[0] = undef }
  sub m       ($$)  { [ $_[0] =~ m{$_[1]} ] }
  sub nm       ($$)  { [ $_[0] !~ m{$_[1]} ] }
  sub s       ($$$) { $_[0] =~ s{$_[1]}{$_[2]} }
  sub split   ($$)  { [ split $_[1], $_[0] ] }

  sub abs     ($)  { CORE::abs($_[0]) }
  sub atan2   ($)  { CORE::atan2($_[0], $_[1]) }
  sub cos     ($)  { CORE::cos($_[0]) }
  sub exp     ($)  { CORE::exp($_[0]) }
  sub int     ($)  { CORE::int($_[0]) }
  sub log     ($)  { CORE::log($_[0]) }
  sub oct     ($)  { CORE::oct($_[0]) }
  sub hex     ($)  { CORE::hex($_[0]); }
  sub rand    ($)  { CORE::rand($_[0]) }
  sub sin     ($)  { CORE::sin($_[0]) }
  sub sqrt    ($)  { CORE::sqrt($_[0]) }

  sub to ($$) { $_[0] < $_[1] ? [$_[0]..$_[1]] : [CORE::reverse $_[1]..$_[0]]}
  sub upto ($$) { [ $_[0]..$_[1] ] }
  sub downto ($$) { [ CORE::reverse $_[1]..$_[0] ] }
}
{ package ARRAY;
  sub WHAT {"Array"}

  sub shape { my $a = CORE::shift; 0+@$a } # ?
  sub end { my $a = CORE::shift; -1+@$a } # ?
  sub elems { my $a = CORE::shift; CORE::scalar @$a }
  sub delete { my $a = CORE::shift; @_ ? CORE::delete($a->[$_[0]]) : undef }
  sub exists { my $a = CORE::shift; @_ ? CORE::exists($a->[$_[0]]) : undef }
  sub pop (\\@) { CORE::pop @{$_[0]}; }
  sub shift { my $a = CORE::shift; CORE::shift(@$a) }
  sub push { my $a = CORE::shift; CORE::push(@$a,@_); $a }
  sub unshift { my $a = CORE::shift; CORE::unshift(@$a,@_) }
  sub splice {
    my $a = CORE::shift;
    my $offset = CORE::shift || 0;
    my $size = CORE::shift || 0;
    [CORE::splice(@{$a},$offset,$size,@_)]
  }
  sub keys { my $a = CORE::shift; [0..(@$a-1)] }
  sub kv { my $a = CORE::shift; my $idx = 0; [map{($idx++,$_)}@$a] }
  sub pairs { my $a = CORE::shift; my $idx = 0; [map{Pair->new("key"=>$idx++,"value"=>$_)}@$a] }
  sub values { my $a = CORE::shift; @$a }

  # Speculative

  sub clone { my $a = CORE::shift; [@$a] }

  # Non-spec

  sub grep (\\@&) { my $arr = CORE::shift; my $sub = CORE::shift; [ CORE::grep { $sub->($_) } @$arr ]; }
  sub join (\\@$) { my $arr = CORE::shift; my $sep = CORE::shift; CORE::join $sep, @$arr; }
  sub map (\\@&) { my $arr = CORE::shift; my $sub = CORE::shift; [ CORE::map { $sub->($_) } @$arr ]; }
  sub reverse (\\@) { [ CORE::reverse @{$_[0]} ] }
  sub sort (\\@;&) { my $arr = CORE::shift; my $sub = CORE::shift() || sub { $a cmp $b }; [ CORE::sort { $sub->($a, $b) } @$arr ]; }
  sub max(\\@) { my $arr = CORE::shift; my $max = $arr->[0]; foreach (@$arr) {$max = $_ if $_ > $max }; $max; }
  sub min(\\@) { my $arr = CORE::shift; my $min = $arr->[0]; foreach (@$arr) {$min = $_ if $_ < $min }; $min; }

  sub each (\\@$) {
    my $arr = CORE::shift; my $sub = CORE::shift;
    foreach my $i (@$arr) {$sub->($i);}
  }
  sub each_with_index (\\@$) {
    my $arr = CORE::shift; my $sub = CORE::shift;
    for(my $i = 0; $i < $#$arr; $i++) {$sub->($i, $arr->[$i]);}
  }

  # Internal

  sub flatten (\\@) { ( @{$_[0]} ) }
  sub flatten_recursively {
    map { my $ref = ref($_); ($ref && $ref eq "ARRAY") ? $_->flatten_recursively : $_ } @{$_[0]}
  }
}
{ package HASH;
  sub WHAT {"Hash"}

  # randomness taken from autobox::Core

  sub delete (\\%@) { my $hash = CORE::shift; my @res = (); CORE::foreach(@_) { push @res, CORE::delete $hash->{$_}; } CORE::wantarray ? @res : \\@res }
  sub exists (\\%$) { my $hash = CORE::shift; CORE::exists $hash->{$_[0]}; }
  sub keys (\\%) { [ CORE::keys %{$_[0]} ] }
  sub values (\\%) { [ CORE::values %{$_[0]} ] }

  sub each (\\%$) {
    my $hash = CORE::shift;
    my $cb = CORE::shift;
    while((my $k, my $v) = CORE::each(%$hash)) {
      $cb->($k, $v);
    }
  }

  # spec

  sub kv { my $h = CORE::shift; [map{($_,$h->{$_})} CORE::keys %$h] }
  sub pairs { my $h = CORE::shift; [map{Pair->new("key"=>$_,"value"=>$h->{$_})} CORE::keys %$h] }

  # Speculative

  sub clone {
    my $h = CORE::shift;
    # Do not simplify this to "...ift; {%$h} }".  returns 0.  autobox issue?
    my $h1 = {%$h}; $h1
  }

  # Temporary

  sub dup { my $h = CORE::shift; my $h1 = {%$h}; $h1} # obsolete
}
use warnings;

{ package Any; sub __make_not_empty_for_use_base{}}
{ package SCALAR; use base "Any";}
{ package ARRAY; use base "Any";}
{ package HASH; use base "Any";}
{ package CODE; use base "Any";}

{ package Private;
  # Taken from Perl6::Take 0.04.
  our @GATHER;
  sub gather (&) {local @GATHER = (@GATHER, []); shift->(); $GATHER[-1] }
  sub take (@) {push @{ $GATHER[-1] }, @_; undef }
}

{ package GLOBAL;
  { no warnings;
    *gather = \\&Private::gather;
    *take   = \\&Private::take;}

  {
    use Scalar::Util "openhandle";
    sub say {
      my $currfh = select();
      my($handle,$warning);
      {no strict "refs"; $handle = openhandle($_[0]) ? shift : \\*$currfh;}
      @_ = $_ unless @_;
      my @as = @_;
      @_ = map {
        my $ref = ref($_);
        ($ref && $ref eq "ARRAY") ? ARRAY::flatten_recursively($_) : $_
      } @as;
      local $SIG{__WARN__} = sub { $warning = join q{}, @_ };
      my $res = print {$handle} @_, "\\n";
      return $res if $res;
      $warning =~ s/[ ]at[ ].*//xms;
      Carp::croak $warning;
    }
  }

  our $a_ARGS = [@ARGV];

  sub undef{undef}

  use Carp;
  sub slurp{my($file)=@_; my $s = `cat $file`; $s}
  sub unslurp{
    my($text,$file)=@_; open(F,">$file") or CORE::die $!; print F $text; close F;}
  sub file_exists{-e $_[0]}
  sub system{CORE::system(@_)}
  sub eval_perl5{my($p5)=@_;my $res = eval($p5); croak($@) if $@; $res}
  sub die{croak @_}
  sub exit{CORE::exit(@_)}
  sub defined{CORE::defined($_[0])}
  sub substr ($$$){CORE::substr($_[0],$_[1],$_[2])}
  sub not ($){CORE::not $_[0]}
  sub exec{CORE::exec(@_)}
  sub sleep{CORE::sleep(@_)}

  sub split{[CORE::split($_[0],$_[1])]}
}

{ package SCALAR;
  sub re_sub         {
    my $expr = "\\$_[0] =~ s/$_[1]/$_[2]/".($_[3]||"");
    eval $expr;
    Carp::confess($@) if $@;
    $_[0]
  }
  sub re_sub_g ($$$) {
    eval "\\$_[0] =~ s/$_[1]/$_[2]/g";
    Carp::confess($@) if $@;
    $_[0]
  }
  # legacy
  sub re_gsub ($$$) {$_[0] =~ s/$_[1]/$_[2]/g; $_[0]}
}

{ package GLOBAL;

  sub parser_name{
    my $e = $ENV{ELF_STD_RED_RUN};
    return $e if $e;
    my $f = $0;
    $f =~ s/[^\\/]+$//;
    # $f."elf_e_src/STD_red/STD_red_run"
    $f."../STD_red/STD_red_run"
  }

  our $a_INC = ["."];

  sub require {
    my($module)=@_;
    my $file = find_required_module($module);
    $file || CORE::die "Cant locate $module in ( ".CORE::join(" ",@$GLOBAL::a_INC)." ).\\n";
    eval_file($file);
  };
  sub find_required_module {
    my($module)=@_;
    my @names = ($module,$module.".pm",$module.".p6");
    for my $dir (@$GLOBAL::a_INC) {
      for my $name (@names) {
        my $file = $dir."/".$name;
        if(-f $file) {
          return $file;
        }
      }
    }
    return undef;
  }
  sub mkdir {
    my($dir) = @_;
    mkdir($dir);
  }

  our $compiler0;
  our $compiler1;
  our $parser0;
  our $parser1;
  our $emitter0;
  our $emitter1;

  sub eval_file {
    my($file)=@_;
    $GLOBAL::compiler0->eval_file($file);
  }
  sub eval_perl6 {
    my($code)=@_;
    $GLOBAL::compiler0->eval_perl6($code);
  }
  sub eval {
    my($code)=@_;
    eval_perl6($code);
  }
}

package main; # -> Main once elf_d support is dropped.
')};
sub e{my $self=CORE::shift;my($x)=@_;
my $ref = $x->WHAT();
if(($ref eq 'Undef')) {
$x
}elsif(($ref eq 'UNDEF')) {
$x
}elsif(($ref eq 'SCALAR')) {
$x
}elsif(((($ref eq 'Str') || ($ref eq 'Int')) || ($ref eq 'Num'))) {
$x
}elsif(($ref eq 'Array')) {
$x->map(sub {my($ae)=@_;
$self->e($ae)})
}elsif(($ref eq 'ARRAY')) {
$x->map(sub {my($ae)=@_;
$self->e($ae)})
}else {
$x->callback($self)
}};
sub cb__CompUnit{my $self=CORE::shift;my($n)=@_;
$n->do_all_analysis();
{package main; use vars '$1es_whiteboard__in_package'};local $::es_whiteboard__in_package = [];
my $code = (('package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.
' . $self->prelude_for_entering_a_package()));
my $stmts = $self->e($n->{'statements'});
(($code . $stmts->join(';
')) . ';
')};
sub cb__Block{my $self=CORE::shift;my($n)=@_;
(('' . $self->e($n->{'statements'})->join(';
')) . '')};
sub cb__Use{my $self=CORE::shift;my($n)=@_;
my $module = $self->e($n->{'module_name'});
my $expr = $self->e($n->{'expr'});
if(($module eq 'v6-alpha')) {
''
}elsif(($module eq 'v6')) {
''
}elsif(($module eq 'lib')) {
my $name = $n->{'expr'}->{'buf'};
if($self->compiler->hook_for_use_lib($name)) {
''
}else {
''
}
}elsif($self->compiler->hook_for_use($module, $expr)) {
''
}else {
('use ' . $module)
}};
sub cb__ClosureTrait{my $self=CORE::shift;my($n)=@_;
((($n->{'kind'} . '{') . $self->e($n->{'block'})) . '}')};
sub cb__PackageDecl{my $self=CORE::shift;my($n)=@_;
{package main; use vars '$1es_whiteboard__in_package'};local $::es_whiteboard__in_package = [$::es_whiteboard__in_package->flatten(), $n->{'name'}];
my $name = $::es_whiteboard__in_package->join('::');
(((((((((('
{ package ' . $name) . ';
') . 'use Moose;') . ' # __PACKAGE__->meta->make_mutable();
') . $self->prelude_for_entering_a_package()) . $self->e(($n->{'traits'} || []))->join('
')) . $self->e($n->{'block'})) . ';
# __PACKAGE__->meta->make_immutable();
') . '
}
'))};
sub cb__Trait{my $self=CORE::shift;my($n)=@_;
if((($n->{'verb'} eq 'is'))) {
my $pkgname = $::es_whiteboard__in_package->join('::');
my $name = (($::es_whiteboard__in_package->splice(0, (-1))->join('::') . '::') . $self->e($n->{'expr'}));
$name->re_gsub('^::', '');
(('use base \'' . $name) . '\';
')
}else {
GLOBAL::say((('ERROR: Emitting p5 for Trait verb ' . $n->{'verb'}) . ' has not been implemented.
'));
'***Trait***'
}};
sub do_VarDecl_has{my $self=CORE::shift;my($n)=@_;
my $default = '';
my $default_expr = $self->e($n->{'default_expr'});
if($default_expr) {
($default = ((', default => sub{ ' . $default_expr) . ' }'))
}else {
if((($n->{'var'}->{'sigil'} eq '@'))) {
($default = ', default => sub{ [] }')
};
if((($n->{'var'}->{'sigil'} eq '%'))) {
($default = ', default => sub{ {} }')
}
};
(((('has \'' . $self->e($n->{'var'}->{'name'})) . '\' => (is => \'rw\'') . $default) . ');')};
sub cb__VarDecl{my $self=CORE::shift;my($n)=@_;
if((($n->{'scope'} eq 'has'))) {
$self->do_VarDecl_has($n)
}else {
my $default = '';
if($n->{'default_expr'}) {
($default = (' = ' . $self->e($n->{'default_expr'})))
}else {
if((($n->{'var'}->{'sigil'} eq '@'))) {
($default = ' = [];')
};
if((($n->{'var'}->{'sigil'} eq '%'))) {
($default = ' = {};')
}
};
if((($n->{'var'}->{'twigil'} eq '^'))) {
my $name = $self->e($n->{'var'});
$name->re_gsub('^(.)::', '$1');
((((((('{package main; use vars \'' . $name) . '\'};') . 'local') . ' ') . $self->e($n->{'var'})) . $default))
}else {
((($n->{'scope'} . ' ') . $self->e($n->{'var'})) . $default)
}
}};
sub multimethods_using_hack{my $self=CORE::shift;my($n,$name,$type0)=@_;
my $stem = (('_mmd__' . $name) . '__');
my $branch_name = ($stem . $type0);
my $setup_name = ('_reset' . $stem);
my $code = '';
($code = ((((((((((((($code . '
{ my $setup = sub {
    my @meths = __PACKAGE__->meta->compute_all_applicable_methods;
    my $h = {};
    for my $m (@meths) {
      next if not $m->{name} =~ /^') . $stem) . '(\\w+)/;
      my $type = $1;
      $h->{$type} = $m->{code}{q{&!body}};
    };
    my $s = eval q{sub {
      my $ref = ref($_[1]) || $_[1]->WHAT;
      my $f = $h->{$ref}; goto $f if $f;
      Carp::croak "multi method ') . $name) . ' cant dispatch on type: ".$ref."\\n";
    }};
    die $@ if $@;
    eval q{{no warnings; *') . $name) . ' = $s;}};
    die $@ if $@;
    goto &') . $name) . ';
  };
  eval q{{no warnings; *') . $setup_name) . ' = $setup;}};
  die $@ if $@;
  eval q{{no warnings; *') . $name) . ' = $setup;}};
  die $@ if $@;
};
'));
(((((('sub ' . $branch_name) . '{my $self=CORE::shift;') . $self->e($n->{'multisig'})) . $self->e($n->{'block'})) . '}') . $code)};
sub multimethods_using_CM{my $self=CORE::shift;my($n,$name,$type0)=@_;
my $n_args = $n->{'multisig'}->{'parameters'}->elems();
($type0 = $type0->re_gsub('^Any$', '*'));
($type0 = $type0->re_gsub('^Int$', '#'));
($type0 = $type0->re_gsub('^Num$', '#'));
($type0 = $type0->re_gsub('^Str$', '\\$'));
my $param_padding = '';
my $i = 1;
while(($i < $n_args)) {
($i = ($i + 1));
($param_padding = ($param_padding . ' * '))
};
((((((((('Class::Multimethods::multimethod ' . $name) . ' =>qw( * ') . $type0) . $param_padding) . ' ) => ') . 'sub {my $self=CORE::shift;') . $self->e($n->{'multisig'})) . $self->e($n->{'block'})) . '};')};
sub cb__MethodDecl{my $self=CORE::shift;my($n)=@_;
if(($n->{'plurality'} && ($n->{'plurality'} eq 'multi'))) {
my $name = $self->e($n->{'name'});
my $param_types = $n->{'multisig'}->{'parameters'}->map(sub {my($p)=@_;
my $types = $self->e($p->{'type_constraints'});
if($types) {
if(($types->elems() != 1)) {
GLOBAL::die('only limited multi method support')
};
$types->[0]
}else {
GLOBAL::undef()
}});
my $type0 = $param_types->[0];
if(GLOBAL::not($type0)) {
GLOBAL::die((('implementation limitation: a multi method\'s first parameter must have a type: ' . $name) . '
'))
};
$self->multimethods_using_CM($n, $name, $type0)
}else {
((((('sub ' . $self->e($n->{'name'})) . '{my $self=CORE::shift;') . $self->e($n->{'multisig'})) . $self->e($n->{'block'})) . '}')
}};
sub cb__SubDecl{my $self=CORE::shift;my($n)=@_;
my $name = $n->{'name'};
if($name) {
($name = $self->e($name))
}else {
($name = '')
};
my $sig = $n->{'multisig'};
if($sig) {
($sig = $self->e($sig))
}else {
($sig = '')
};
if((($n->{'traits'} && $n->{'traits'}->[0]->{'expr'}) && ($n->{'traits'}->[0]->{'expr'} eq 'p5'))) {
((((('sub ' . $name) . '{') . $sig) . $n->{'block'}->{'statements'}->[0]->{'buf'}) . '}')
}else {
((((('sub ' . $name) . '{') . $sig) . $self->e($n->{'block'})) . '}')
}};
sub cb__Signature{my $self=CORE::shift;my($n)=@_;
if((($n->{'parameters'}->elems() == 0))) {
''
}else {
((('my(' . $self->e($n->{'parameters'})->join(',')) . ')=@_;') . '
')
}};
sub cb__Parameter{my $self=CORE::shift;my($n)=@_;
$self->e($n->{'param_var'})};
sub cb__ParamVar{my $self=CORE::shift;my($n)=@_;
($n->{'sigil'} . $self->e($n->{'name'}))};
sub cb__Call{my $self=CORE::shift;my($n)=@_;
my $method = $self->e($n->{'method'});
if((($method =~ 'postcircumfix:< >'))) {
(((($self->e($n->{'invocant'}) . '->') . '{\'') . $self->e($n->{'capture'})) . '\'}')
}elsif((($method =~ 'postcircumfix:(.*)'))) {
my $op = $1;
my $arg = $self->e($n->{'capture'});
$op->re_gsub(' ', $arg);
(($self->e($n->{'invocant'}) . '->') . $op)
}else {
((((($self->e($n->{'invocant'}) . '->') . $self->e($n->{'method'})) . '(') . $self->e($n->{'capture'})) . ')')
}};
sub cb__Apply{my $self=CORE::shift;my($n)=@_;
if(($n->{'function'} =~ qr/^infix:(.+)$/)) {
my $op = $1;
my $a = $self->e($n->{'capture'}->{'arguments'});
my $l = $a->[0];
my $r = $a->[1];
if((($op eq '~'))) {
(((('(' . $l) . ' . ') . $r) . ')')
}elsif((($op eq ','))) {
my $s = $a->shift();
while($a->elems()) {
($s = (($s . ', ') . $a->shift()))
};
$s
}elsif((($op eq '='))) {
my $t = $self->e($n->{'capture'}->{'arguments'}->[0]->{'twigil'});
if((($t && ($t eq '.')))) {
((($l . '(') . $r) . ')')
}else {
(((((('(' . $l) . ' ') . $op) . ' ') . $r) . ')')
}
}else {
(((((('(' . $l) . ' ') . $op) . ' ') . $r) . ')')
}
}elsif(($n->{'function'} =~ qr/^prefix:(.+)$/)) {
my $op = $1;
my $a = $self->e($n->{'capture'}->{'arguments'});
my $x = $a->[0];
if(0) {

}elsif(($op eq '?')) {
(('((' . $x) . ')?1:0)')
}else {
(((('(' . $op) . '') . $x) . ')')
}
}elsif(($n->{'function'} =~ qr/^postfix:(.+)$/)) {
my $op = $1;
my $a = $self->e($n->{'capture'}->{'arguments'});
my $x = $a->[0];
if(0) {

}else {
(((('(' . $x) . '') . $op) . ')')
}
}elsif((($self->e($n->{'function'}) =~ qr/^circumfix:(.+)/))) {
my $op = $1;
if(($op eq '< >')) {
my $s = $n->{'capture'}->{'arguments'}->[0];
my $words = $s->split(qr/\s+/);
if(($words->elems() == 0)) {
'[]'
}else {
(('[\'' . $words->join('\',\'')) . '\']')
}
}else {
my $arg = $self->e($n->{'capture'});
$op->re_gsub(' ', $arg)
}
}elsif((($self->e($n->{'function'}) =~ qr/^statement_prefix:gather$/))) {
(('GLOBAL::gather' . $self->e($n->{'capture'})) . '')
}else {
my $f = $self->e($n->{'function'});
if((($f =~ qr/^\$\w+$/))) {
((($f . '->(') . $self->e($n->{'capture'})) . ')')
}elsif((($f eq 'self'))) {
'$self'
}elsif((($f eq 'last'))) {
'last'
}elsif((($f eq 'return'))) {
(('return(' . $self->e($n->{'capture'})) . ')')
}elsif((($f =~ qr/^sub\s*{/))) {
(((('(' . $f) . ')->(') . $self->e($n->{'capture'})) . ')')
}elsif((($f =~ qr/^\w/))) {
if($n->notes()->{'lexical_bindings'}->{('&' . $f)}) {
(((('' . $f) . '(') . $self->e($n->{'capture'})) . ')')
}else {
(((('GLOBAL::' . $f) . '(') . $self->e($n->{'capture'})) . ')')
}
}else {
((($f . '(') . $self->e($n->{'capture'})) . ')')
}
}};
sub cb__Capture{my $self=CORE::shift;my($n)=@_;
$self->e(($n->{'arguments'} || []))->join(',')};
sub cb__For{my $self=CORE::shift;my($n)=@_;
(((('for(' . $self->e($n->{'expr'})) . '->flatten){
') . $self->e($n->{'block'})) . '
}')};
sub cb__Cond{my $self=CORE::shift;my($n)=@_;
my $els = '';
if($n->{'default'}) {
($els = (('else {
' . $self->e($n->{'default'})) . '
}'))
};
my $clauses = $self->e($n->{'clauses'});
my $first = $clauses->shift();
my $first_test = $first->[0];
if($n->{'invert_first_test'}) {
($first_test = (('not(' . $first_test) . ')'))
};
((((((('if(' . $first_test) . ') {
') . $first->[1]) . '
}') . $clauses->map(sub {my($e)=@_;
(((('elsif(' . $e->[0]) . ') {
') . $e->[1]) . '
}')})->join('')) . $els))};
sub cb__Loop{my $self=CORE::shift;my($n)=@_;
(((('while(' . $self->e($n->{'pretest'})) . ') {
') . $self->e($n->{'block'})) . '
}')};
sub cb__Var{my $self=CORE::shift;my($n)=@_;
my $s = $n->{'sigil'};
my $t = ($n->{'twigil'} || '');
my $env = '';
my $pre = '';
if(($t eq '^')) {
($env = 'e')
};
if((($s eq '$') && ($env eq 'e'))) {
($pre = 's_')
};
if(($s eq '@')) {
($pre = 'a_')
};
if(($s eq '%')) {
($pre = 'h_')
};
my $name = (($env . $pre) . $self->e($n->{'name'}));
if((($t eq '.'))) {
('$self->' . $name)
}elsif((($t eq '^'))) {
$name->re_gsub('::', '__');
(('$' . '::') . $name)
}elsif((($t eq '*'))) {
$name->re_gsub('::', '__');
(('$' . 'GLOBAL::') . $name)
}else {
('$' . $name)
}};
sub cb__NumInt{my $self=CORE::shift;my($n)=@_;
$self->e($n->{'text'})};
sub cb__Hash{my $self=CORE::shift;my($n)=@_;
(('{' . $self->e(($n->{'hash'} || []))->join(',')) . '}')};
sub cb__Buf{my $self=CORE::shift;my($n)=@_;
my $s = GLOBAL::eval_perl5('sub{local $Data::Dumper::Terse = 1; Data::Dumper::Dumper($_[0])}')->($n->{'buf'});
$s->chomp();
$s};
sub cb__Rx{my $self=CORE::shift;my($n)=@_;
(('qr/' . $n->{'pat'}) . '/')};
sub cb__Pair{my $self=CORE::shift;my($n)=@_;
(((('(' . $self->e($n->{'key'})) . '=>') . $self->e($n->{'value'})) . ')')};
# __PACKAGE__->meta->make_immutable();

}
;
if(GLOBAL::not($GLOBAL::emitter0)) {
($GLOBAL::emitter0 = EmitSimpleP5->new())
};
($GLOBAL::emitter1 = EmitSimpleP5->new());

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.
sub header{use Math::Trig qw();};
header();

{ package Num; #use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub pi{Math::Trig::pi();};
# __PACKAGE__->meta->make_immutable();

}
;

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package Parser; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
has 'is_for_active_runtime' => (is => 'rw');;
sub parse{my $self=CORE::shift;my($p6_code,$claim_as_filename)=@_;
GLOBAL::unslurp($p6_code, 'deleteme.p6');
my $parser = $self->parser_name();
my $msg = (('Parse error in: ' . $claim_as_filename) . '
');
my $cmd = ((($parser . ' --error-message=\'') . $msg) . '\' -q --format=p5a deleteme.p6 > deleteme.dump');
((GLOBAL::system($cmd) == 0) or GLOBAL::die('Parse failed.
'));
my $dump5 = GLOBAL::slurp('deleteme.dump');
my $tree = GLOBAL::eval_perl5(('package Fastdump;' . $dump5));
$tree};
sub parser_name{my $self=CORE::shift;GLOBAL::parser_name()};
# __PACKAGE__->meta->make_immutable();

}
;
GLOBAL::eval_perl5('
{ package Fastdump;
  sub match {my($r,$s,$f,$t,$h)=@_; Match->make_from_rsfth($r,$s,$f,$t,$h)}
}');
if(GLOBAL::not($GLOBAL::parser0)) {
($GLOBAL::parser0 = Parser->new('is_for_active_runtime', 1))
};
($GLOBAL::parser1 = Parser->new());

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.

{ package Compiler; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
has 'is_for_active_runtime' => (is => 'rw');;
sub eval_perl6{my $self=CORE::shift;my($code)=@_;
$self->eval_fragment($code, '-e', 0)};
sub eval_file{my $self=CORE::shift;my($file)=@_;
$self->eval_fragment(GLOBAL::slurp($file), $file, 0)};
sub eval_fragment{my $self=CORE::shift;my($code,$filename,$verbose)=@_;
my $p5 = $self->compile_fragment($code, $filename, $verbose);
GLOBAL::eval_perl5($p5)};
sub compile_fragment_cache_get{my $self=CORE::shift;my($code,$filename)=@_;
GLOBAL::undef()};
sub compile_fragment_cache_set{my $self=CORE::shift;my($code,$filename,$value)=@_;
};
sub compile_fragment{my $self=CORE::shift;my($code,$filename,$verbose)=@_;
my $tree;
my $cached = $self->compile_fragment_cache_get($code, $filename);
if($cached) {
$cached
}else {
if($self->is_for_active_runtime) {
($tree = $GLOBAL::parser0->parse($code, $filename))
}else {
($tree = $GLOBAL::parser1->parse($code, $filename))
};
if($verbose) {
GLOBAL::say($tree->match_describe())
};
my $ir = $tree->make_ir_from_Match_tree();
if($verbose) {
GLOBAL::say($ir->irx1_describe())
};
my $p5;
if($self->is_for_active_runtime) {
($p5 = ($GLOBAL::emitter0->prelude_lexical() . $ir->callback($GLOBAL::emitter0->new_emitter('compiler', $self))))
}else {
($p5 = ($GLOBAL::emitter1->prelude_lexical() . $ir->callback($GLOBAL::emitter1->new_emitter('compiler', $self))))
};
if($verbose) {
GLOBAL::say($p5)
};
$self->compile_fragment_cache_set($code, $filename, $p5);
$p5
}};
has 'todo' => (is => 'rw', default => sub{ [] });;
sub compile_executable{my $self=CORE::shift;my($sources,$output_file)=@_;
$self->todo([]);
my $p5 = ($self->prelude() . '
');
for($sources->flatten){
my $code = $_->[0];
my $file = $_->[1];
my $verbose = $_->[2];
my $more_p5 = $self->compile_fragment($code, $file, $verbose);
while(($self->todo->elems() > 0)) {
my $filename = $self->todo->shift();
my $module_p5 = $self->compile_fragment(GLOBAL::slurp($filename), $filename, $verbose);
($p5 = (($p5 . $module_p5) . '
;
'))
};
($p5 = (($p5 . $more_p5) . '
;
'))
};
if(($output_file eq '-')) {
GLOBAL::say($p5)
}else {
GLOBAL::unslurp($p5, $output_file)
};
['perl', $output_file]};
sub prelude{my $self=CORE::shift;if($self->is_for_active_runtime) {
$GLOBAL::emitter0->prelude()
}else {
$GLOBAL::emitter1->prelude()
}};
sub hook_for_use_lib{my $self=CORE::shift;my($expr)=@_;
$GLOBAL::a_INC->unshift($expr);
if($self->is_for_active_runtime) {
1
}else {
0
}};
sub hook_for_use{my $self=CORE::shift;my($module,$expr)=@_;
if($self->is_for_active_runtime) {
GLOBAL::require($module)
}else {
my $filename = (GLOBAL::find_required_module($module) || GLOBAL::die((((('Didnt find ' . $module) . ' in ( ') . $GLOBAL::a_INC->join(' ')) . ' ).
')));
$self->todo->push($filename)
};
1};
# __PACKAGE__->meta->make_immutable();

}
;
if(GLOBAL::not($GLOBAL::compiler0)) {
($GLOBAL::compiler0 = Compiler->new('is_for_active_runtime', 1))
};
($GLOBAL::compiler1 = Compiler->new());

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.


{ package Any; __PACKAGE__->meta->make_immutable(); }
{ package Array; __PACKAGE__->meta->make_immutable(); }
{ package ARRAY; __PACKAGE__->meta->make_immutable(); }
{ package Bag; __PACKAGE__->meta->make_immutable(); }
{ package Bit; __PACKAGE__->meta->make_immutable(); }
{ package Blob; __PACKAGE__->meta->make_immutable(); }
{ package Block; __PACKAGE__->meta->make_immutable(); }
{ package Bool; __PACKAGE__->meta->make_immutable(); }
{ package Buf; __PACKAGE__->meta->make_immutable(); }
{ package Capture; __PACKAGE__->meta->make_immutable(); }
{ package Class; __PACKAGE__->meta->make_immutable(); }
{ package Code; __PACKAGE__->meta->make_immutable(); }
{ package CODE; __PACKAGE__->meta->make_immutable(); }
{ package Compiler; __PACKAGE__->meta->make_immutable(); }
{ package Complex; __PACKAGE__->meta->make_immutable(); }
{ package EmitSimpleP5; __PACKAGE__->meta->make_immutable(); }
{ package Fastdump; __PACKAGE__->meta->make_immutable(); }
{ package GLOBAL; __PACKAGE__->meta->make_immutable(); }
{ package Grammar; __PACKAGE__->meta->make_immutable(); }
{ package Hash; __PACKAGE__->meta->make_immutable(); }
{ package HASH; __PACKAGE__->meta->make_immutable(); }
{ package Int; __PACKAGE__->meta->make_immutable(); }
{ package IO; __PACKAGE__->meta->make_immutable(); }
{ package IRx1; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Apply; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Array; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Base; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Block; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Buf; __PACKAGE__->meta->make_immutable(); }
{ package IRx1_Build; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Call; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Capture; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::ClosureTrait; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::CompUnit; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::CompUnit_and_Block; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Cond; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::For; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Hash; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Hyper; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Loop; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::MacroDecl; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::MethodDecl; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::ModuleName; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::MultiSig; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::NumDec; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::NumInt; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::NumRad; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::PackageDecl; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Pair; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Parameter; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::ParamVar; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::PathName; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::PostConstraint; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Regex; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RegexDef; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Rx; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxAll; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxAny; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxAssertion; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxBackslash; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxBind; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxBlock; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxCapture; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxEvery; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxFirst; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxGroup; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxLiteral; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxModInternal; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxQuantifiedAtom; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxSequence; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxSubmatch; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::RxSymbol; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::ShapedParamName; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Signature; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::SubDecl; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::SubName; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Trait; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Type; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::TypeConstraint; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Undef; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Use; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::Var; __PACKAGE__->meta->make_immutable(); }
{ package IRx1::VarDecl; __PACKAGE__->meta->make_immutable(); }
{ package Junction; __PACKAGE__->meta->make_immutable(); }
{ package KeyBag; __PACKAGE__->meta->make_immutable(); }
{ package KeyHash; __PACKAGE__->meta->make_immutable(); }
{ package KeySet; __PACKAGE__->meta->make_immutable(); }
{ package List; __PACKAGE__->meta->make_immutable(); }
{ package Macro; __PACKAGE__->meta->make_immutable(); }
{ package Mapping; __PACKAGE__->meta->make_immutable(); }
{ package Match; __PACKAGE__->meta->make_immutable(); }
{ package Method; __PACKAGE__->meta->make_immutable(); }
{ package Module; __PACKAGE__->meta->make_immutable(); }
{ package Num; __PACKAGE__->meta->make_immutable(); }
{ package Object; __PACKAGE__->meta->make_immutable(); }
{ package Package; __PACKAGE__->meta->make_immutable(); }
{ package Pair; __PACKAGE__->meta->make_immutable(); }
{ package Parser; __PACKAGE__->meta->make_immutable(); }
{ package Private; __PACKAGE__->meta->make_immutable(); }
{ package Program; __PACKAGE__->meta->make_immutable(); }
{ package Range; __PACKAGE__->meta->make_immutable(); }
{ package Regex; __PACKAGE__->meta->make_immutable(); }
{ package Role; __PACKAGE__->meta->make_immutable(); }
{ package Routine; __PACKAGE__->meta->make_immutable(); }
{ package Scalar; __PACKAGE__->meta->make_immutable(); }
{ package SCALAR; __PACKAGE__->meta->make_immutable(); }
{ package Seq; __PACKAGE__->meta->make_immutable(); }
{ package Set; __PACKAGE__->meta->make_immutable(); }
{ package Signature; __PACKAGE__->meta->make_immutable(); }
{ package Str; __PACKAGE__->meta->make_immutable(); }
{ package Sub; __PACKAGE__->meta->make_immutable(); }
{ package Subethod; __PACKAGE__->meta->make_immutable(); }
{ package UNDEF; __PACKAGE__->meta->make_immutable(); }





{ package Program; use Moose;#X3X
 # __PACKAGE__->meta->make_mutable();
sub print_usage_and_die{my $self=CORE::shift;GLOBAL::say('
Usage: [-v] [-s0|-s|-x|-xr] [-o OUTPUT_FILE] [-I dir]
         [ P6_FILE | -e P6_CODE ]+ [ -- ARGS* ]

Unlike p5, multiple P6_FILE\'s and -e P6_CODE\'s and can be mixed.
Use -- to stop.

 -v                verbose.

 default  Compile0 and eval.
 -s0      Compile0 and show the resulting framgent.
 -s       Compile1 and show the resulting fragment.
 -x       Compile1 to an executable form.
 -xr      Compile1 to an executable form, and run.

One can also do
 [ P6_FILE | -e P6_CODE ]+  these are evaled,
 -x
 [ P6_FILE | -e P6_CODE ]+  these are compiled.

');
GLOBAL::exit(2)};
sub main{my $self=CORE::shift;my($args)=@_;
if(($args->elems() == 0)) {
$self->print_usage_and_die()
};
my $verbose;
my $mode = 'r';
my $output_file;
my $incs = [];
my $output = sub {my($text)=@_;
if($output_file) {
GLOBAL::unslurp($text, $output_file)
}else {
GLOBAL::say($text)
}};
my $sources = [];
my $handle = sub {my($filename,$code)=@_;
if(($mode eq 'r')) {
$GLOBAL::compiler0->eval_fragment($code, $filename, $verbose)
}elsif((($mode eq 's0') || ($mode eq 's1'))) {
my $comp;
if(($mode eq 's0')) {
($comp = $GLOBAL::compiler0)
}else {
($comp = $GLOBAL::compiler1)
};
$output->($comp->compile_fragment($code, $filename, $verbose))
}else {
$sources->push([$code, $filename, $verbose])
}};
my $at_end = sub {if((($mode eq 'x') && ($sources->elems() != 0))) {
if(GLOBAL::not($output_file)) {
($output_file = '-')
};
my $exec_args = $GLOBAL::compiler1->compile_executable($sources, $output_file)
}elsif((($mode eq 'xr') && ($sources->elems() != 0))) {
if(GLOBAL::not($output_file)) {
($output_file = 'deleteme_exe')
};
my $exec_args = $GLOBAL::compiler1->compile_executable($sources, $output_file);
GLOBAL::say(((('# ' . $exec_args->join(' ')) . ' ') . $args->join(' ')));
GLOBAL::exec($exec_args->flatten(), $args)
}};
while($args->elems()) {
my $arg = $args->shift();
if(($arg eq '-v')) {
($verbose = 1)
}elsif(($arg eq '-s0')) {
($mode = 's0')
}elsif(($arg eq '-s')) {
($mode = 's1')
}elsif(($arg eq '-x')) {
($mode = 'x')
}elsif(($arg eq '-xr')) {
($mode = 'xr')
}elsif(($arg eq '-o')) {
($output_file = ($args->shift() || $self->print_usage_and_die()))
}elsif(($arg eq '-e')) {
$GLOBAL::a_INC->unshift($incs->reverse()->flatten());
($incs = []);
my $p6_code = ($args->shift() || $self->print_usage_and_die());
$handle->('-e', $p6_code)
}elsif(GLOBAL::file_exists($arg)) {
$GLOBAL::a_INC->unshift($incs->reverse()->flatten());
($incs = []);
$handle->($arg, GLOBAL::slurp($arg))
}elsif(($arg eq '-I')) {
my $dir = ($args->shift() || $self->print_usage_and_die());
$incs->unshift($dir)
}elsif(($arg eq '--')) {
last
}else {
$self->print_usage_and_die()
}
};
$at_end->()};
# __PACKAGE__->meta->make_immutable();

}
;
Program->new()->main($GLOBAL::a_ARGS);

;
use autobox;use autobox UNDEF => 'UNDEF';
      package main; # not Main, otherwise ::foo() hack for sub()s doesnt work.
;
;
;
;
;
;
;
;
;
;

;