#!/usr/bin/pugs

use v6;
require Test;

=kwid

loop statement tests

=cut

plan 6;

# basic loop

my $i = 0;
is($i, 0, 'verify our starting condition');
loop ($i = 0; $i < 10; $i++) {}
is($i, 10, 'verify our ending condition');

# loop with last()

my $i = 0;
is($i, 0, 'verify our starting condition');
loop ($i = 0; $i < 10; $i++) {
    if ($i == 5) { 
        last(); # should this really need the ()
    }
}
is($i, 5, 'verify our ending condition');

# infinite loop

my $i = 0;
is($i, 0, 'verify our starting condition');
loop (;;) { $i++; last(); }
is($i, 1, 'verify our ending condition');