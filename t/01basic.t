use v6;

=pod

This is a test file.  Whee!

=cut

say "1..5";
say "ok 1 # Welcome to Pugs!";

sub cool { fine($_) ~ " # We've got " ~ toys }
sub fine { "ok " ~ $_ }
sub toys { "fun and games!" }

say cool 2;  # and that is it, folks!

my $foo = "Foo";
eval 'undef $foo';
if (!$foo) { say 'ok 3' } else { say 'not ok 3 # TODO' }

my $bar;
eval ' unless ($foo) { $bar = "true"; } ';
if ($bar) { say 'ok 4' } else { say 'not ok 4 # TODO' }

if (eval '(my $quux = 1) == 1)') { say "ok 5" } else { 
    say "not ok 5 # TODO my returns LHS"
}

eval 'if 1 { say "ok 6" }' or say "not ok 6 # TODO if without parens"

