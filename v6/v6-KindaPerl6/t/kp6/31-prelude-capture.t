use v6-alpha;


module Main {

    say '1..1';
    
    my $m = Capture.new; 
    $m.invocant = 123;

    if $m.invocant == 123 {
        say "ok 1 - invocant";
    }
    else {
        say "not ok - got ", $m.invocant;
    };

}