use nodes;
use analysis;
use emit5;

sub inline_remains is p5 {'use remains_of_Regexp_ModuleA;
'}
inline_remains();

sub test is p5 {'
    if($ARGV[-1] eq "--repl") {
      shift;
      Regexp::ModuleA::Interactive::repl();
      exit;
    }
    if($ARGV[-1] eq "--repl6") {
      shift;
      Regexp::ModuleA::Interactive::repl(6);
      exit;
    }

   print "re_tests\n\n";
   require "./t/re_tests.pl";
   Pkg_re_tests::test(&Regexp::ModuleA::test_target);

   print "\n\n";
   print "rx_tests\n\n";
   require "./t/rx.pl";
   Pkg_re_tests::test6(&Regexp::ModuleA::test_target6);
'}
test();
