use v6-alpha;

use Test;

=pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/null.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=cut

plan 4;

# L<S05/Nothing is illegal/To match the zero-width string, use>

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
} else {

ok("" ~~ m/<?>/, 'Simple null as <?>');
ok("" ~~ m/''/, "Simple null as ''");
ok("a" ~~ m/<?>/, 'Simple null A');

ok("ab" ~~ m{a<?>b}, 'Compound null AB');

}

