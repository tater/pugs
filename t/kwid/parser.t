#!/usr/bin/pugs
use v6;
require Test;

plan 1;
skip("No Kwid parser yet");

# I need to learn Perl6.
# This is psuedo code:

=pod
use Test;

use Kwid::Parser;
use Kwid::Formatter::bytecode;

for (sort <t/kwid/parser/*>) -> IO $file {
    ($comment, $kwid, $bytecode) = $file.all.split("...\n");
    ($abstract, $description) = $comment.split("\n");
    $formatter = Kwid::Formatter::bytecode.new;
    Kwid::Parser.new($formatter).parse;
    is($formatter.result, $bytecode, $abstract);
}

=cut
