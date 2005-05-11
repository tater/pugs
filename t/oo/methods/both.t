#!/usr/bin/pugs

use v6;
use Test;

plan 4;

# L<A12/"Class|object Invocant">

class Foo {
    method bar (Class|Foo $class: $arg) { return 100 + $arg }
}

{
    my $val;
    lives_ok {
        $val = Foo.bar(42);
    }, '... class|instance methods work for class', :todo<feature>;
    is($val, 142, '... basic class method access worked', :todo<feature>);
}

{
    my $foo = Foo.new();
    my $val;
    lives_ok {
        $val = $foo.bar(42);
    }, '... class|instance methods work for instance', :todo<feature>;
    is($val, 142, '... basic instance method access worked', :todo<feature>);
}
