use v6;

use Test;

plan 3;

=begin pod

Test for rules as references

=end pod

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

my $rule = rx:P5/\s+/;
isa_ok($rule, 'Regex');

ok("hello world" ~~ $rule, '... applying rule object returns true');
ok(!("helloworld" ~~ $rule), '... applying rule object returns false (correctly)');
