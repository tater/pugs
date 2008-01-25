use v6-alpha;
use Test;
plan 51;

# L<S29/"The :Trig tag">

#?rakudo skip 'Cannot parse pod'
{
=head1 DESCRIPTION

Basic tests for trigonometric functions.

=cut
}

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510;

# -- pi
is_approx((pi, $PI), "pi()");
is_approx((pi + 3, $PI + 3), "'pi() + 3' may drop its parentheses before +3");

# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx((atan(1)           / $PI * 180, 45));
is_approx((atan(1/3*sqrt(3)) / $PI * 180, 30));
is_approx((atan(sqrt(3))     / $PI * 180, 60));

# Quadrants II, IV
is_approx((atan(-1)           / $PI * 180, -45));
is_approx((atan(-1/3*sqrt(3)) / $PI * 180, -30));
is_approx((atan(-sqrt(3))     / $PI * 180, -60));

# S29: This second form of C<atan> computes the arctangent of $y/$x, and
# **takes the quadrant into account**.
# Quadrant I
is_approx((atan(1, 1)           / $PI * 180, 45));
is_approx((atan(1, sqrt(3))     / $PI * 180, 30));
is_approx((atan(1, 1/3*sqrt(3)) / $PI * 180, 60));

# Quadrant II
is_approx((atan(1, -1)           / $PI * 180, 135));
is_approx((atan(1, -1/3*sqrt(3)) / $PI * 180, 120));
is_approx((atan(1, -sqrt(3))     / $PI * 180, 150));

# Quadrant III
is_approx((atan(-1, -1)           / $PI * 180 + 360, 225));
is_approx((atan(-1, -sqrt(3))     / $PI * 180 + 360, 210));
is_approx((atan(-1, -1/3*sqrt(3)) / $PI * 180 + 360, 240));

# Quadrant IV
is_approx((atan(-1, 1)           / $PI * 180 + 360, 315));
is_approx((atan(-1, sqrt(3))     / $PI * 180 + 360, 330));
is_approx((atan(-1, 1/3*sqrt(3)) / $PI * 180 + 360, 300));

# -- sin, cos, tan
# sin
is_approx((sin(0/4*$PI), 0));
is_approx((sin(1/4*$PI), 1/2*sqrt(2)));
is_approx((sin(2/4*$PI), 1));
is_approx((sin(3/4*$PI), 1/2*sqrt(2)));
is_approx((sin(4/4*$PI), 0));
is_approx((sin(5/4*$PI), -1/2*sqrt(2)));
is_approx((sin(6/4*$PI), -1));
is_approx((sin(7/4*$PI), -1/2*sqrt(2)));
is_approx((sin(8/4*$PI), 0));

# cos
is_approx((cos(0/4*$PI), 1));
is_approx((cos(1/4*$PI), 1/2*sqrt(2)));
is_approx((cos(2/4*$PI), 0));
is_approx((cos(3/4*$PI), -1/2*sqrt(2)));
is_approx((cos(4/4*$PI), -1));
is_approx((cos(5/4*$PI), -1/2*sqrt(2)));
is_approx((cos(6/4*$PI), 0));
is_approx((cos(7/4*$PI), 1/2*sqrt(2)));
is_approx((cos(8/4*$PI), 1));

# tan
is_approx((tan(0/4*$PI), 0));
is_approx((tan(1/4*$PI), 1));
is_approx((tan(3/4*$PI), -1));
is_approx((tan(4/4*$PI), 0));
is_approx((tan(5/4*$PI), 1));
is_approx((tan(7/4*$PI), -1));
is_approx((tan(8/4*$PI), 0));

# asin
is_approx((try {asin(0)},            0));
#?pugs 2 todo 'feature'
is_approx((try {asin(1/2*sqrt(2))},  1/4*$PI));
is_approx((try {asin(1)},            2/4*$PI));

# acos
#?pugs 2 todo 'feature'
is_approx((try {acos(0)},            2/4*$PI));
is_approx((try {acos(1/2*sqrt(2))},  1/4*$PI));
is_approx((try {acos(1)},            0/4*$PI));