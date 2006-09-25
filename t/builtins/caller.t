use v6-alpha;

use Test;

plan 19;

# L<S06/"The C<caller> function">

# caller.subname
sub a_sub { b_sub() }
sub b_sub { try { caller.subname } }
is ~a_sub(), "foo", "caller.sub works", :todo;

# caller.file
ok index(~(try { caller.file }), "caller") >= 0, "caller.file works", :todo;

# caller.line (XXX: make sure to edit the expected line number!)
is +(try { caller.line }), 19, "caller.line works", :todo;

# caller exposes a bug in the MMD mechanism where directy using autogenerated
# accessors on an object returned by a factory, rather than storing the object
# in an intermediate variable, works only when you chain methods with an
# explicit () between them: caller().subname - ok; caller.subname - error.

sub try_it {
    my ($code, $expected, $desc) = @_;
    is($code(), $expected, $desc);
}
sub try_it_caller { try_it(@_) }                                # (line 30.)
class A { method try_it_caller_A { &Main::try_it_caller(@_) } }
sub try_it_caller_caller { A.try_it_caller_A(@_) }
class B { method try_it_caller_B { &Main::try_it_caller_caller(@_) } }
sub chain { B.try_it_caller_B(@_) }

# must use parentheses after caller

# basic tests of caller object
chain({ WHAT caller() },     "Control::Caller", "caller object type");
chain({ caller().package }, "Main", "caller package");
chain({ caller().file },    $?FILE, "caller filename");
chain({ caller().line },    "30", "caller line");
chain({ caller().subname }, "&Main::try_it_caller", "caller subname");
chain({ caller().subtype }, "SubRoutine", "caller subtype"); # specme
chain({ caller().sub },     &try_it_caller, "caller sub (code)");

# select by code type
chain({ caller(Any).subname },    "&Main::try_it_caller", "code type - Any");
chain({ caller("Any").subname },  "&Main::try_it_caller", "code type - Any (string)");
chain({ caller(Method).subname }, "&A::try_it_caller_A", "code type - Method");
chain({ caller("Moose") },         undef, "code type - not found");

# :skip
chain({ caller(:skip<1>).subname }, "&A::try_it_caller_A", ":skip<1>");
chain({ caller(:skip<128>) },       undef, ":skip<128> - not found");

# type + :skip
chain({ caller(Sub, :skip<1>).subname }, "&Main::try_it_caller_caller", "Sub, :skip<1>");
chain({ caller(Sub, :skip<2>).subname }, "&Main::chain", "Sub, :skip<2>");
chain({ caller(Method, :skip<1>).subname }, "&B::try_it_caller_B", "Method, :skip<1>");

# WRITEME: label tests

