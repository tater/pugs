#!/usr/bin/pugs

use v6;
use Test;

plan 22;

=pod

Basic submethod tests. See L<S12/"Submethods">

=cut

{
  my $was_in_foo_build = 0;
  my $was_in_bar_build = 0;

  eval_ok '
    class Foo        { submethod BUILD() { $was_in_foo_build++ } }
    class Bar is Foo { submethod BUILD() { $was_in_bar_build++ } }
  ', "class definitions were parsed/run/compiled", :todo<feature>;

  my $a;
  ok eval('$a = Foo.new()'),    "Foo.new() worked (1)", :todo<feature>;
  is $was_in_foo_build, 1,      "Foo's BUILD was called", :todo<feature>;
  # is instead of todo_is to avoid unexpected succeedings
  is $was_in_bar_build, 0,      "Bar's BUILD was not called";

  ok eval('$b = Bar.new()'),    "Bar.new() worked", :todo<feature>;
  is $was_in_foo_build, 2,      "Foo's BUILD was called again", :todo<feature>;
  is $was_in_bar_build, 1,      "Bar's BUILD was called, too", :todo<feature>;

  # The next three tests are basically exactly the same as the first three tests
  # (not counting the initial class definition). This is to verify our call to
  # Bar.new didn't removed/changed some internal structures which'd prevent
  # Foo.BUILD of getting called.
  my $c;
  ok eval('my $c = Foo.new()'), "Foo.new() worked (2)", :todo<feature>;
  is $was_in_foo_build, 3,      "Foo's BUILD was called again", :todo<feature>;
  is $was_in_bar_build, 1,      "Bar's BUILD was not called again", :todo<feature>;
}

{
  my $was_in_baz_submethod  = 0;
  my $was_in_grtz_submethod = 0;

  eval '
    class Baz         { submethod blarb() { $was_in_baz_submethod++ } }
    class Grtz is Baz { submethod blarb() { $was_in_grtz_submethod++ } }
  ';

  my ($baz, $grtz);
  ok eval('$baz  = Baz.new'),  "Baz.new() worked",  :todo<feature>;
  ok eval('$grtz = Grtz.new'), "Grtz.new() worked", :todo<feature>;

  try { $baz.blarb }
  is $was_in_baz_submethod,  1, "Baz's submethod blarb was called", :todo<feature>;
  # No :todo to avoid unexpected suceedings
  is $was_in_grtz_submethod, 0, "Grtz's submethod blarb was not called";

  try { $grtz.blarb }
  is $was_in_baz_submethod,  1, "Baz's submethod blarb was not called again", :todo<feature>;
  # No :todo to avoid unexpected suceedings
  is $was_in_grtz_submethod, 1, "Grtz's submethod blarb was now called, too", :todo<feature>;
}

# Roles with BUILD
# See thread "Roles and BUILD" on p6l
# L<http://www.nntp.perl.org/group/perl.perl6.language/21277>
{
  my $was_in_a1_build = 0;
  my $was_in_a2_build = 0;
  role RoleA1  { submethod BUILD() { $was_in_a1_build++ } }
  role RoleA2  { submethod BUILD() { $was_in_a2_build++ } }
  class ClassA does RoleA1 does RoleA2 {}
  ClassA.new;

  is $was_in_a1_build, 1, "roles' BUILD submethods were called when mixed in a class (1)";
  is $was_in_a2_build, 2, "roles' BUILD submethods were called when mixed in a class (2)";
}

{
  my $was_in_b1_build = 0;
  my $was_in_b2_build = 0;
  role RoleB1  { submethod BUILD() { $was_in_b1_build++ } }
  role RoleB2  { submethod BUILD() { $was_in_b2_build++ } }
  class ClassB {}

  my $B = ClassB.new;
  is $was_in_b1_build, 0, "roles' BUILD submethods were not yet called (1)";
  is $was_in_b2_build, 0, "roles' BUILD submethods were not yet called (2)";

  eval '$B does RoleB1 does RoleB2';
  is $was_in_b1_build, 1, "roles' BUILD submethods were called now (1)";
  is $was_in_b2_build, 1, "roles' BUILD submethods were called now (2)";
}
