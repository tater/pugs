$io.print("1..1\n");
$hash{'foo'}.STORE("ok 1\n");
$io.print($hash{'foo'}.FETCH);