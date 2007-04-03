use v6-alpha;

use Test;

plan 18;

{
    my $capture = \(1,2,3);
    
    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    my sub foo ($a, $b, $c) { "$a!$b!$c" }
    is try { &foo.callwith(|$capture) }, "1!2!3",
        "simply capture creation with \\( works (1)";
}

{
    my $capture = \(1,2,3,'too','many','args');
    
    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    my sub foo ($a, $b, $c) { "$a!$b!$c" }
    dies_ok { &foo.callwith(|$capture) },
        "simply capture creation with \\( works (2)";
}

{
    my $capture = \(1, named => "arg");
    
    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    my sub foo ($a, :$named) { "$a!$named" }
    is try { &foo.callwith(|$capture) }, "1!arg",
        "simply capture creation with \\( works (3)";
}

{
    my $capture = try { \(1, 'positional' => "pair") };
    
    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    my sub foo ($a, $pair) { "$a!$pair" }
    is try { &foo.callwith(|$capture) }, "1!positional\tpair",
        "simply capture creation with \\( works (4)";
}

{
    my @array   = <a b c>;
    my $capture = try { \(@array) };

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    my sub foo (@arr) { ~@arr }
    is try { &foo.callwith(|$capture) }, "a b c",
        "capture creation with \\( works";
}

# L<S06/Argument list binding/single scalar parameter marked>
{
    my sub bar ($a, $b, $c) { "$a!$b!$c" }
    my sub foo (|$capture)  { &bar.callwith(|$capture) }

    is try { foo(1,2,3) }, "1!2!3",
        "capture creation with \\$ works (1)", :todo<feature>;
    dies_ok { foo(1,2,3,4) },  # too many args
        "capture creation with \\$ works (2)";
    dies_ok { foo(1,2) },      # too few args
        "capture creation with \\$ works (3)";
    is try { foo(a => 1, b => 2, c => 3) }, "1!2!3",
        "capture creation with \\$ works (4)", :todo<feature>;
    is try { foo(1, b => 2, c => 3) }, "1!2!3",
        "capture creation with \\$ works (5)", :todo<feature>;
}

# Arglists are first-class objects
{
    my $capture;
    my sub foo (|$args) { $capture = $args }

    lives_ok { foo(1,2,3,4) }, "captures are first-class objects (1)";
    ok $capture,               "captures are first-class objects (2)", :todo<feature>;

    my $old_capture = $capture;
    lives_ok { foo(5,6,7,8) }, "captures are first-class objects (3)";
    ok $capture,               "captures are first-class objects (4)", :todo<feature>;
    ok !($capture === $old_capture), "captures are first-class objects (5)", :todo<feature>;
}

{
    my $capture1;
    my sub foo ($args) { $capture1 = $args }

    my $capture2 = \(1,2,3);
    try { foo $capture2 };  # note: no |$args here

    cmp_ok $capture1, &infix:<===>, $capture2,
        "unflattened captures can be passed to subs";
}

# Mixing ordinary args with captures
{
    my $capture = \(:foo<bar>, :baz<grtz>);
    my sub foo ($a,$b, :$foo, :$baz) { "$a!$b!$foo!$baz" }

    dies_ok { &foo.callwith(|$capture) },  # too few args
        "mixing ordinary args with captures (1)";
    is &foo.callwith(1, 2, |$capture), "1!2!bar!grtz",
        "mixing ordinary args with captures (2)";
}
