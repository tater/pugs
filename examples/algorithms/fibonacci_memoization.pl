use v6;

my $n = @*ARGS[0] // 42;
say fib($n);

sub fib (UInt $n) {
    (state $seen = [0,1,1]).[$n] //= fib($n-1) + fib($n-2);
}

# XXX following currently doesn't successfully memoize
#
# sub fib (UInt $n) {
#     (state @seen = 0,1,1).[$n] //= fib($n-1) + fib($n-2);
# }
