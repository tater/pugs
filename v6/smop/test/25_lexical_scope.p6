$*OUT.FETCH.print("1..3\n");
$*inner.STORE($SMOP__S1P__LexicalScope.new());
$*inner.FETCH.outer.STORE($SMOP__S1P__LexicalScope.new());
$*inner.FETCH.outer.FETCH.outer.STORE($SMOP__S1P__LexicalScope.new());
$*inner.FETCH.outer.FETCH.outer.FETCH.{'$a'}.STORE($SMOP__S1P__Scalar.new());
$*inner.FETCH.outer.FETCH.outer.FETCH.{'$a'}.FETCH.STORE("ok 1\n");
$*OUT.FETCH.print($*inner.FETCH.lookup('$a').FETCH.FETCH());
$*inner.FETCH.outer.FETCH.{'$a'}.STORE($SMOP__S1P__Scalar.new());
$*inner.FETCH.outer.FETCH.{'$a'}.FETCH.STORE("ok 2\n");
$*OUT.FETCH.print($*inner.FETCH.lookup('$a').FETCH.FETCH());
$*inner.FETCH.{'$a'}.STORE($SMOP__S1P__Scalar.new());
$*inner.FETCH.{'$a'}.FETCH.STORE("ok 3\n");
$*OUT.FETCH.print($*inner.FETCH.lookup('$a').FETCH.FETCH());