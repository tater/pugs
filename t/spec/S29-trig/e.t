use v6-alpha;
use Test;
plan 6;

# L<S29/"The :Trig tag">

#?rakudo skip 'Cannot parse pod'
{
=head1 DESCRIPTION

Basic tests for trigonometric functions.

=cut
}

# See also: L<"http://en.wikipedia.org/wiki/E_%28mathematical_constant%29"> :)
my $e = 2.71828182845904523536;

is_approx(e      , $e),   "e, as a bareword");
is_approx(e()    , $e),   "e(), as a sub");
is_approx(1 + e(), $e+1), "1+e(), as a sub");
is_approx(e() + 1, $e+1), "e()+1, as a sub");
is_approx(1 + e,   $e+1), "1+e, as a bareword");
is_approx(e + 1,   $e+1), "e+1, as a bareword");