#!/usr/bin/perl -w
# Translated from pugs/t/operators/binding/scalar.t
use strict;
use Test::More tests => 28;
use Data::Bind;

use Scalar::Util 'refaddr';

sub id_eq {
    my ($x, $y) = @_;
    return refaddr($x) == refaddr($y);
}

# L<S03/"Binding" /replaces the container itself\.  For instance:/>
# Basic scalar binding tests
sub {
  my $x = 'Just Another';
  is($x, 'Just Another', 'normal assignment works');

  my $y;
  bind_op('$y', \$x);
  is($y, 'Just Another', 'y is now bound to x');

  ok(id_eq(\$y, \$x), 'y is bound to x (we checked with the =:= identity op)');

  my $z = $x;
  is($z, 'Just Another', 'z is not bound to x');

  ok(!(id_eq(\$z, \$x)), 'z is not bound to x (we checked with the =:= identity op)');

  $y = 'Perl Hacker';
  is($y, 'Perl Hacker', 'y has been changed to "Perl Hacker"');
  is($x, 'Perl Hacker', 'x has also been changed to "Perl Hacker"');

  is($z, 'Just Another', 'z is still "Just Another" because it was not bound to x');
}->();

SKIP:
{
  no warnings 'once';
  skip 'dynamic scope? are you kidding?', 1;
  sub bar {
    return $CALLER::a eq $CALLER::b;
  }

  sub foo {
    env $a = "foo";
    env $b;
    bind_op('$b', \$a);
    return bar(); # && bar2();
  }

  ok(foo(), "CALLER resolves bindings in caller's dynamic scope");
}


# Binding to swap
sub {
  my $a = "a";
  my $b = "b";

  bind_op('$a', \$b, '$b', \$a);

#  ($a, $b) := ($b, $a);
  is($a, 'b', '$a has been changed to "b"');
  is($b, 'a', '$b has been changed to "a"');

  $a = "c";
  is($a, 'c', 'binding to swap didn\'t make the vars readonly');
}->();

# More tests for binding a list
sub {
  my $a = "a";
  my $b = "b";
  my $c = "c";

#  ($a, $b) := ($c, $c);
  bind_op('$a' => \$c, '$b' => \$c);
  is($a, 'c', 'binding a list literal worked (1)');
  is($b, 'c', 'binding a list literal worked (2)');

  $c = "d";
  is($a, 'd', 'binding a list literal really worked (1)');
  is($b, 'd', 'binding a list literal really worked (2)');
}->();

# Binding subroutine parameters
# XXX! When executed in interactive Pugs, the following test works!
SKIP:
{
  skip 'not yet', 5;
  my $a;
  my $b = sub { my $arg; bind_op('$arg', \$_[0]); bind_op('$a', \$arg) };
  my $val = 42;

  $b->($val);
  is $a, 42, "bound readonly sub param was bound correctly (1)";
  $val++;
  is $a, 43, "bound readonly sub param was bound correctly (2)";

  dies_ok { $a = 23 },
    "bound readonly sub param remains readonly (1)";
  is $a, 43,
    "bound readonly sub param remains readonly (2)";
  is $val, 43,
    "bound readonly sub param remains readonly (3)";
}

SKIP:
{
  skip 'not yet', 5;
  my $a;
  my $b = sub {};
#  my $b = sub($arg is rw) { $a := $arg };
  my $val = 42;

  $b->($val);
  is $a, 42, "bound rw sub param was bound correctly (1)";
  $val++;
  is $a, 43, "bound rw sub param was bound correctly (2)";

  lives_ok { $a = 23 }, "bound rw sub param remains rw (1)";
  is $a, 23,            "bound rw sub param remains rw (2)";
  is $val, 23,          "bound rw sub param remains rw (3)";
}

# := actually takes subroutine parameter list
TODO:
sub {

  my $a;
#  eval '(+$a) := (:a<foo>)';
  my $sig = Data::Bind::Sig->new
      ({ named =>
	 { a => Data::Bind::Param->new({ container_var => '$a', name => 'a' }) } });

  $sig->bind({ positional => [],
	       named => { a => \'foo' } });

  is($a, "foo", "bound keyword");


  local $TODO = 'slurpy not yet';
  my @tail;
#  eval '($a, *@tail) := (1, 2, 3)';
  ok($a == 1 and eq_array(\@tail, [2, 3]), 'bound slurpy');
}->();
