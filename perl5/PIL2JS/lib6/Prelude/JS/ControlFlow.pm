sub statement_control:<loop>($pre, Code $cond, Code $body, Code $post) is primitive {
  JS::inline('(
    function (pre, cond, body, post) {
      try {
        for(pre; cond(); post()) {
          try {
            while(1) {
              var redo = 0;
              try { body() } catch(err) {
                if(err instanceof PIL2JS.ControlException.redo) {
                  redo++;
                } else {
                  throw err;
                }
              }
              if(!redo) break;
            }
          } catch(err) {
            if(err instanceof PIL2JS.ControlException.next) {
              // Ok;
            } else {
              throw err;
            }
          }
        }
      } catch(err) {
        if(err instanceof PIL2JS.ControlException.last) {
          return undefined;
        } else {
          throw err;
        }
      }
      return undefined;
    }
  )')($pre, {?$cond()}, $body, $post);
}

for <last next redo> -> $name {
  Pugs::Internals::eval "
    sub JS::Root::$name () is primitive \{
      JS::inline '
        (function () \{
          throw(new PIL2JS.ControlException.{$name}());
        \})()
      ';
    \}
  ";
}

sub statement_control:<while>(Code $cond, Code $body) is primitive {
  my $ret;
  loop 1; $ret = $cond(); 1 { $body() }
  $ret;
}

sub statement_control:<until>(Code $cond, Code $body) is primitive {
  my $ret;
  loop 1; !($ret = $cond()); 1 { $body() }
  $ret;
}

sub statement_control:<postwhile>(Code $cond, Code $body) is primitive {
  my $first_run_done = 0;

  while($first_run_done ?? $cond() :: ++$first_run_done) { $body() }
}

sub statement_control:<postuntil>(Code $cond, Code $body) is primitive {
  my $first_run_done = 0;

  until($first_run_done ?? $cond() :: $first_run_done++) { $body() }
}

sub statement_control:<if>(Bool|Junction $cond, Code $true, Code $false) is primitive {
  JS::inline('(
    function (cond, t, f) {
      return cond ? t() : f();
    }
  )')(?$cond, $true, $false);
}

sub statement_control:<unless>(Bool|Junction $cond, Code $true, Code $false) is primitive {
  statement_control:<if>(!$cond, $true, $false);
}

# XXX: Handle redo() correctly!
sub statement_control:<for>(@array is rw, Code $code) is primitive {
  my $arity = $code.arity;
  # die "Can't use 0-ary subroutine as \"for\" body!" if $arity == 0;
  $arity ||= 1;

  my $idx = 0;
  while $idx < +@array {
    my @args = ();
    my $i; loop $i = 0; $i < $arity; $i++ {
      # Slighly hacky
      push @args: undef;
      @args[-1] := @array[$idx++];
    }
    $code(*@args);
  }

  undef;
}

sub JS::Root::try(Code $code) is primitive {
  JS::inline('new PIL2JS.Box.Constant(function (args) {
    var cxt = args[0], code = args[1], cc = args.pop();
    var ret = new PIL2JS.Box.Constant(undefined);
    try { ret = PIL2JS.cps2normal(code.FETCH(), [PIL2JS.Context.ItemAny]) } catch(err) {
      // Set $!
      _24main_3a_3a_21.STORE(
        err.pil2js_orig_msg
          ? err.pil2js_orig_msg
          : new PIL2JS.Box.Constant(err.toString())
      );
      return cc(new PIL2JS.Box.Constant(undefined));
    }
    cc(ret);
  })')($code);
}

sub JS::Root::warn(*@msg) is primitive {
  my $arg = @msg > 1  ?? join "", @msg
         :: @msg == 1 ?? @msg[0]
         :: "Warning: something's wrong";
  JS::inline('new PIL2JS.Box.Constant(function (args) {
    var cc = args.pop();
    PIL2JS.warn(args[1]);
    cc(new PIL2JS.Box.Constant(undefined));
  })')($arg);
  ?1;
}
sub JS::Root::die(*@msg)  is primitive {
  my $arg = @msg > 1  ?? join "", @msg
         :: @msg == 1 ?? @msg[0]
         :: "Died";
  JS::inline('new PIL2JS.Box.Constant(function (args) { PIL2JS.die(args[1]) })')($arg);
}

sub JS::Root::nothing() is primitive {}
