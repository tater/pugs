use v6;

use Test;

plan 2;

=begin pod

$0 should not be defined.

Pcre is doing the right thing:
  $ pcretest
...
    re> /a|(b)/
  data> a
   0: a
  data>
so it looks like a pugs-pcre interface bug.

=end pod

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

"a" ~~ rx:Perl5/a|(b)/;
is($0, undef, 'An unmatched capture should be false.');
my $str = "http://foo.bar/";
ok(($str ~~ rx:Perl5 {http{0,1}}));
