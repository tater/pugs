use v6;

use Test;

plan 6;

=begin pod

Testing named capture variables nested inside each other. This doesn't appear to be tested by the ported Perl6::Rules tests. That may be because it's not specified in the synopsis, but Autrijus is sure this how it ought to work.

=end pod

# At the time of writing, these fail under Win32 so they are marked as bugs
# I haven't yet run them under UNIX but I believe they will work

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
  exit;
}

#L<S05/Nested subpattern captures>

{
  regex fishy { (.*)shark };
  "whaleshark" ~~ m/<fishy>/;
  is(eval('$/<fishy>[0]'), "whale", "named rule ordinal capture");
  is(eval('$<fishy>[0]'), "whale", "named rule ordinal capture with abbreviated variable");
};

#L<S05/Named scalar aliasing to subpatterns>

{
  my $not_really_a_mammal;
  regex fishy2 { $not_really_a_mammal = (.*)shark };
  "whaleshark" ~~ m/<fishy2>/;
  is(eval('$/<fishy2><not_really_a_mammal>'), "whale", "named rule named capture", :todo<bug>);
  is(eval('$<fishy2><not_really_a_mammal>'), "whale", "named rule named capture with abbreviated variable", :todo<bug>);
};

#L<S05/Subrule captures>

{
  regex number {
    [ $<numeral> = <roman_numeral>  { $<notation> = 'roman' }
    | $<numeral> = <arabic_numeral> { $<notation> = 'arabic' }
    ]
  };
  regex roman_numeral  { I | II | III | IV };
  regex arabic_numeral { 1 |  2 |  3  |  4 };
  2 ~~ m/<number>/;
  is(eval('$/<number><numeral>'), '2', 'binding subrule to new alias');
  is(eval('$/<number><notation>'), 'roman', 'binding to alias as side-effect');
}

