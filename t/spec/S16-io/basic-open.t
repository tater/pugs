use v6;
use Test;

plan 9;

#?DOES 3
sub test_lines(@lines) {
    #?rakudo todo 'IO bugs'
    is @lines.elems, 3, 'Three lines read';
    is @lines[0], 
       'Please do not remove this file, used by S16-io/basic-open.t',
       'Retrieved first line';
    #?rakudo todo 'IO bugs'
    is @lines[2], 
       'This is a test line.',
       'Retrieved last line';
}

{
    my $fh = open('t/spec/S16-io/test-data');
    my $count = 0;
    while !$fh.eof {
        my $x = $fh.readline;
        $count++ if $x;
    }
    is $count, 3, 'Read three lines with while !$hanlde.eof';
}

# test that we can interate over =$fh
{
    my $fh =  open('t/spec/S16-io/test-data');

    ok defined($fh), 'Could open test file';
    my @lines;
    for =$fh -> $x {
        push @lines, $x;
    }
    test_lines(@lines);
}

# test that we can get all items in list context:
{
    my $fh =  open('t/spec/S16-io/test-data');
    ok defined($fh), 'Could open test file (again)';
    my @lines = =$fh;
    test_lines(@lines);
}

# vim: ft=perl6
