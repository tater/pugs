use v6;

use Test;

plan 5;

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

my $rule = '\d+';
ok('2342' ~~ rx:P5/$rule/, 'interpolated rule applied successfully');

my $rule2 = 'he(l)+o';
ok('hello' ~~ rx:P5/$rule2/, 'interpolated rule applied successfully');

my $rule3 = 'r+';
my $subst = 'z';
my $bar = "barrrr"; 
$bar ~~ s:P5:g{$rule3}=qq{$subst}; 
is($bar, "baz", 'variable interpolation in substitute regexp works with :g modifier');

my $a = 'a:';
$a ~~ s:P5 [(..)]=qq[{uc $0}];
is($a, 'A:', 'closure interpolation with qq[] as delimiter');

my $b = 'b:';
$b ~~ s:P5{(..)} = uc $0;
is($b, 'B:', 'closure interpolation with no delimiter');
