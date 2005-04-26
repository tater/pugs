#!/usr/bin/pugs

use v6;
use Test;

plan 2;

{ # from t/03-operator.t, as noted by afbach on #perl6, 2005-03-06
	my @oldval  = (5, 8, 12);
	my @newval1 = (17, 15, 14); # all greater
	my @newval2 = (15, 7,  20); # some less some greater
	ok(eval 'all(@newval2) < any(@oldval); all(@newval1) > all(@oldval);', "parses correctly, second statement is true", :todo(1));

	my %hash = ("foo", "bar");
	ok(!(eval '%hash <foo>'), '%hash \s+ <subscript> doesnt parse');
};

