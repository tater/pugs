use v6-alpha;

class KindaPerl6::Visitor::EmitLisp {

    # This visitor is a list emitter
    # TODO !!!
    
    method visit ( $node ) {
        $node.emit_lisp($.visitor_args{'secure'});
    };

}

class CompUnit {
    sub set_secure_mode( $args_secure ) {
        if ($args_secure != 0) {
            return '(pushnew :kp6-lisp-secure *features*)' ~ Main::newline();
        } else {
            return '';
        }
    };

    method emit_lisp( $args_secure ) {
        my $interpreter := '|' ~ $.name ~ '|';

          ';; Do not edit this file - Lisp generated by ' ~ $Main::_V6_COMPILER_NAME ~ Main::newline()
        ~ '(eval-when (:compile-toplevel :load-toplevel :execute)' ~ Main::newline()
        ~ '  (when (null (find-package \'kp6-lisp))' ~ Main::newline()
        ~ '   ' ~ set_secure_mode($args_secure)
        ~ '   (load "src/KindaPerl6/Runtime/Lisp/Runtime.lisp")))' ~ Main::newline()
        ~ '(in-package #:kp6-lisp-user)' ~ Main::newline()
        ~ '(kp6-add-program (' ~ $interpreter ~ ')' ~ Main::newline()
        ~ ' (kp6-ensure-package ' ~ $interpreter ~ ' "' ~ $.name ~ '")' ~ Main::newline()
        ~ ' (with-kp6-package (' ~ $interpreter ~ ' "' ~ $.name ~ '")' ~ Main::newline()
        ~ $.body.emit_lisp($interpreter, 3) ~ '))' ~ Main::newline()
    }
}

class Val::Int {
    method emit_lisp ($interpreter, $indent) { 
        "(make-instance \'kp6-Int :value " ~ $.int ~ ")";
    }
}

class Val::Bit {
    method emit_lisp ($interpreter, $indent) { 
        "(make-instance \'kp6-Bit :value " ~ $.bit ~ ")";
    }
}

class Val::Num {
    method emit_lisp ($interpreter, $indent) { 
        "(make-instance \'kp6-Num :value " ~ $.num ~ ")";
    }
}

class Val::Buf {
    method emit_lisp ($interpreter, $indent) { 
        "(make-instance \'kp6-Str :value " ~ '"' ~ Main::mangle_string( $.buf ) ~ '"' ~ ")";
    }
}

class Val::Char {
    method emit_lisp ($interpreter, $indent) { 
        '(make-instance \'kp6-Char :value (code-char ' ~ $.char ~ '))'
    }
}

class Val::Undef {
    method emit_lisp ($interpreter, $indent) { 
        "(make-instance \'kp6-Undef)";
    }
}

class Val::Object {
    method emit_lisp ($interpreter, $indent) {
	'(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "literal objects")';
    }
}

class Native::Buf {
    method emit_lisp ($interpreter, $indent) { 
	'(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "Native::Buf objects")';
    }
}

class Lit::Seq {
    method emit_lisp ($interpreter, $indent) {
        '(list ' ~ (@.seq.>>emit_lisp($interpreter, $indent)).join(' ') ~ ')';
    }
}

class Lit::Array {
    method emit_lisp ($interpreter, $indent) {
        "(make-instance \'kp6-Array :value (list " ~ (@.array.>>emit_lisp($interpreter, $indent)).join(' ') ~ "))";
    }
}

class Lit::Hash {
    method emit_lisp ($interpreter, $indent) {
        my $fields := @.hash;
        my $str := ''; # XXX (' ' x ($indent + 1))
        my $field;
        for @$fields -> $field { 
            $str := $str ~ '(kp6-dispatch hash ' ~ $interpreter ~ ' :store ' ~ ($field[0]).emit_lisp($interpreter, $indent) ~ ' ' ~ ($field[1]).emit_lisp($interpreter, $indent) ~ ')' ~ Main::newline(); # XXX (' ' x ($indent + 1))
        }; 
  
	'(let ((hash (make-instance \'kp6-Hash)))' ~ Main::newline() ~ $str ~ ' hash)';
    }
}

class Lit::Pair {
    method emit_lisp ($interpreter, $indent) {
        "(make-instance \'kp6-pair :key " ~ $.key.emit_lisp($interpreter, $indent) ~ " :value " ~ $.value.emit_lisp($interpreter, $indent) ~ ")";
    }
}

class Lit::NamedArgument {
    method emit_lisp ($interpreter, $indent) {
	'(make-kp6-argument \'named (make-instance \'kp6-pair :key ' ~ $.key.emit_lisp($interpreter, $indent) ~ ' :value ' ~ $.value.emit_lisp($interpreter, $indent) ~ '))';
    }
}

class Lit::Code {
    method emit_lisp ($interpreter, $indent) {
          '(with-kp6-pad ('
        ~ $interpreter
	~ ')'
        ~ Main::newline()
        ~ self.emit_declarations($interpreter, $indent)
	~ Main::newline()
        ~ self.emit_body($interpreter, $indent)
        ~ ')';
    };
    method emit_body ($interpreter, $indent) {
        (@.body.>>emit_lisp($interpreter, $indent)).join(Main::newline());
    };
    method emit_signature ($interpreter, $indent) {
        $.sig.emit_lisp($interpreter, $indent)
    };
    method emit_declarations ($interpreter, $indent) {
        my $s := '';
        my $name;
        for @($.pad.variable_names) -> $name {
            my $decl := ::Decl(
                decl => 'my',
                type => '',
                var  => ::Var(
                    sigil     => '',
                    twigil    => '',
                    name      => $name,
                    namespace => [ ],
                ),
            );

            if $s ne '' {
                $s := $s ~ Main::newline();
            }

            $s := $s ~ $name.emit_lisp($interpreter, $indent); # XXX ~ (' ' x $indent)
        };
        return $s;
    };
}

class Lit::Object {
    method emit_lisp ($interpreter, $indent) {
	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "literal objects")';
    }
}

class Index {
    method emit_lisp ($interpreter, $indent) {
        '(kp6-lookup ' ~ $.obj.emit_lisp($interpreter, $indent) ~ ' (perl->cl ' ~ $.index.emit_lisp($interpreter, $indent) ~ '))'
    }
}

class Lookup {
    method emit_lisp ($interpreter, $indent) {
        '(kp6-lookup ' ~ $.obj.emit_lisp($interpreter, $indent) ~ ' (perl->cl ' ~ $.index.emit_lisp($interpreter, $indent) ~ '))'
    }
}

class Assign {
    method emit_lisp ($interpreter, $indent) {
        my $node := $.parameters;
        
	if $node.isa('Var') {
	    return $node.emit_lisp_assignment($.arguments.emit_lisp($interpreter, $indent));
	}

	if ($node.isa('Lookup') || $node.isa('Index')) && ($node.obj).isa('Var') {
	    return '(kp6-store ' ~ ($node.obj).emit_lisp ~ ' (perl->cl ' ~ ($node.index).emit_lisp ~ ') ' ~ $.arguments.emit_lisp($interpreter, $indent) ~ ')';
	}

	if $node.isa('Call') && ($node.invocant).isa('Var')
	    && ((($node.method) eq 'INDEX') || (($node.method) eq 'LOOKUP')) {
	    return '(kp6-dispatch '
		~ ($node.invocant).emit_lisp($interpreter, $indent)
        ~ ' ' ~ $interpreter ~ ' '
		~ ' :store '
		~ (($node.arguments)[0]).emit_lisp($interpreter, $indent)
		~ ' '
		~ $.arguments.emit_lisp($interpreter, $indent)
		~ ')';
	}
	
	'(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "assigning to anything other than variables")';
    }
}

class Var {
    method emit_lisp ($interpreter, $indent) {
	return self.emit_lisp_lookup(0)
    };

    method emit_lisp_name {
	'(kp6-generate-variable "' ~ $.sigil ~ '" "' ~ $.name ~ '")'
    }

    method emit_lisp_namespace {
	'"' ~ $.namespace.join('::') ~ '"';
    }

    method emit_lisp_lookup ($cell) {
	my $variant := $cell ?? '/c' !! '';

	if @($.namespace) {
	    return '(lookup-package-variable' ~ $variant ~ ' ' ~ self.emit_lisp_name ~ ' ' ~ self.emit_lisp_namespace ~ ')';
	} else {
	    return '(lookup-lexical-variable' ~ $variant ~ ' ' ~ self.emit_lisp_name ~ ')';
	}
    }

    method emit_lisp_assignment ($value, $cell, $constant) {
	my $variant := $cell ?? '/c' !! ($constant ?? '/k' !! '');

	if @($.namespace) {
	    return '(set-package-variable' ~ $variant ~ ' ' ~ self.emit_lisp_name ~ ' ' ~ $value ~ ' ' ~ self.emit_lisp_namespace ~ ')';
	} else {
	    return '(set-lexical-variable' ~ $variant ~ ' ' ~ self.emit_lisp_name ~ ' ' ~ $value ~ ')';
	}
    }
}

class Bind {
    method emit_lisp ($interpreter, $indent) {
        if $.arguments.isa('Var') {
            return $.parameters.emit_lisp_assignment($.arguments.emit_lisp_lookup(1), 1);
        }

	if $.arguments.isa('Sub') {
	    return $.parameters.emit_lisp_assignment($.arguments.emit_lisp($interpreter, $indent));
	}

        # XXX: TODO
	return $.parameters.emit_lisp_assignment($.arguments.emit_lisp($interpreter, $indent), False, 1)
    }
}

class Proto {
    method emit_lisp ($interpreter, $indent) {
	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "proto-objects")';
    }
}

class Call {
    method emit_lisp ($interpreter, $indent) {
        if $.invocant.isa('Var') && (($.method eq 'LOOKUP') || ($.method eq 'INDEX')) {
            return '(kp6-dispatch ' ~ $.invocant.emit_lisp($interpreter, $indent) ~ ' ' ~ $interpreter ~ ' :lookup ' ~ (($.arguments)[0]).emit_lisp($interpreter, $indent) ~ ')';
        }

        my $invocant;
        if $.invocant.isa( 'Proto' ) {

            if $.invocant.name eq 'self' {
                $invocant := '$self';
            }
            else {
                $invocant := $.invocant.emit_lisp;
            }
            
        }
        else {
            $invocant := $.invocant.emit_lisp;
        };
        if $invocant eq 'self' {
            $invocant := '$self';
        };

        my $meth := $.method;
        if  $meth eq 'postcircumfix:<( )>'  {
             $meth := '';  
        };
	
        my $call := (@.arguments.>>emit_lisp($interpreter, $indent)).join(' ');
	
        if ($.hyper) {
            return 'XXX: Hyper';
        }
        else {
            if ( $meth eq '' ) {
                # $var.()
                '(kp6-dispatch ' ~ $invocant ~ ' ' ~ $interpreter ~ ' :APPLY ' ~ $call ~ ')' ~ Main::newline()
            }
            else {
                ###  XXX: HACK: TODO: ZOMGWTFISGOINGON ###
                ## Under:
                # echo 'say ((1).true).Str' | perl script/kp6 -lisp
                ## Then :true has *no interpreter*, why the crap is
                ## this? hack one in until this is fixed
                if $interpreter eq '' {
                    $interpreter := '|Main|';
                }
                  '(kp6-dispatch '
                ~ $invocant ~ ' '
                ~ $interpreter ~' '
                ~ ':' ~ $meth ~ ' '
                ~ $call
                ~ ')'
                ~ Main::newline()
            };
        }
    }
}

class Apply {
    method emit_lisp ($interpreter, $indent) {
        my $name := $.code.name;

        if ($name eq 'infix:<//>') {
            # Hack this is the code generated by C<defined()>
            my $apply_func :=
            '(kp6-apply-function ' ~ $interpreter ~ ' '
            ~ '(perl->cl (lookup-package-variable (kp6-generate-variable "&" "defined") "GLOBAL")) '
            ~ '(list ';
            return '(make-instance \'kp6-Bit :value (or (kp6-true ' ~ $apply_func ~ (@.arguments.>>emit_lisp($interpreter, $indent)).join('))) (kp6-true ') ~ ')))';
        }

        if ($name eq 'infix:<&&>') {
            return
            '(make-instance \'kp6-Bit :value (and (kp6-dispatch (kp6-dispatch ' ~ (@.arguments.>>emit_lisp($interpreter, $indent)).join(' ' ~ $interpreter ~ ' :true) ' ~ $interpreter ~ ' :cl-landish) (kp6-dispatch (kp6-dispatch ') ~ ' ' ~ $interpreter ~ ' :true) ' ~ $interpreter ~ ' :cl-landish)))';
        }

        if ($name eq 'infix:<||>') {
            return '(make-instance \'kp6-Bit :value (or (kp6-dispatch (kp6-dispatch ' ~ (@.arguments.>>emit_lisp($interpreter, $indent)).join(' ' ~ $interpreter ~ ' :true) ' ~ $interpreter ~ ' :cl-landish) (kp6-dispatch (kp6-dispatch ') ~ ' :true) ' ~ $interpreter ~ ' :cl-landish)))';
        }

        if ($name eq 'ternary:<?? !!>') {
            return '(if (kp6-dispatch (kp6-dispatch ' ~ (@.arguments[0]).emit_lisp($interpreter, $indent) ~ ' ' ~ $interpreter ~ ' ' ~ ':true) ' ~ $interpreter ~ ' :cl-landish) (progn ' ~ (@.arguments[1]).emit_lisp($interpreter, $indent) ~ ') (progn ' ~ (@.arguments[2]).emit_lisp($interpreter, $indent) ~ '))';
        }

        my $op := $.code.emit_lisp($interpreter, $indent);

        my $str := '(kp6-apply-function ' ~ $interpreter ~ ' (perl->cl ' ~ $op ~ ') (list';
    
        for @.arguments -> $arg {
            $str := $str ~ ' (make-instance \'kp6-positional-parameter :value ';

            if $arg.isa('Var') {
                $str := $str ~ $arg.emit_lisp_lookup(1);
            } else {
                $str := $str ~ '(make-kp6-cell ' ~ $arg.emit_lisp($interpreter, $indent) ~ ')';
            }

            $str := $str ~ ')'
        }

        $str := $str ~ '))';
        return $str;
    }
}

class Return {
    method emit_lisp ($interpreter, $indent) {
        return
        #'do { print Main::perl(caller(),' ~ $.result.emit_lisp ~ '); return(' ~ $.result.emit_lisp ~ ') }';
        'return(' ~ $.result.emit_lisp($interpreter, $indent) ~ ')';
    }
}

class If {
    method emit_lisp ($interpreter, $indent) {
        my $cond :=
        '(kp6-dispatch'
           ~ ' ' ~ '(kp6-dispatch'
           ~ ' ' ~ $.cond.emit_lisp($interpreter, $indent)
           ~ ' ' ~ $interpreter
           ~ ' ' ~ ':true)'
         ~ ' ' ~ $interpreter
         ~ ' ' ~ ':cl-landish)';

        '(cond ' ~ Main::newline()
          ~ '(' ~ $cond ~ ' '
            ~ ($.body ?? $.body.emit_lisp($interpreter, $indent) !! 'nil')
          ~ ')'
          ~ ($.otherwise
             ?? Main::newline() ~ '(t ' ~ $.otherwise.emit_lisp($interpreter, $indent) ~ ')'
             !! '')
          ~ ')';
    }
}

class For {
    method emit_lisp ($interpreter, $indent) {
        my $cond := $.cond;
        if   $cond.isa( 'Var' ) 
          && ($cond.sigil eq '@')
        {
        } else {
            $cond := ::Apply( code => ::Var(sigil=>'&',twigil=>'',name=>'prefix:<@>',namespace => [ 'GLOBAL' ],), arguments => [$cond] );
        }
        '(kp6-for-loop-structure ('
        ~ $interpreter
        ~ ' ' ~ $.topic.emit_lisp_name()
        ~ ' ' ~ $cond.emit_lisp($interpreter, $indent)
        ~ ')' ~ Main::newline()
        ~ ' ' ~ $.body.emit_lisp($interpreter, $indent) 
        ~ ')';
    }
}

class While {
    method emit_lisp ($interpreter, $indent) {
        my $cond := $.cond;
        if   $cond.isa( 'Var' ) 
          && $cond.sigil eq '@' 
        {
        } else {
            $cond := ::Apply( code => ::Var(sigil=>'&',twigil=>'',name=>'prefix:<@>',namespace => [ 'GLOBAL' ],), arguments => [$cond] );
        }
        '(loop :while (kp6-dispatch' ~ Main::newline()
        ~ '  (kp6-dispatch '
        ~     $.cond.emit_lisp($interpreter, $indent)
        ~ ' ' ~ $interpreter ~ ' :true) ' ~ Main::newline()
        ~ $interpreter
        ~ ' :cl-landish)' ~ Main::newline()
        ~ ' :do '
        ~     $.body.emit_lisp($interpreter, $indent)
        ~ ')'
        ~ Main::newline()
    }
}

class Decl {
    method emit_lisp ($interpreter, $indent) {
        my $decl := $.decl;
        my $name := $.var.name;

	if $decl eq 'our' {
	    return '(define-package-variable ' ~ $.var.emit_lisp_name ~ ' (enclosing-package))' ~ Main::newline()
		 ~ '(define-lexical-variable ' ~ $.var.emit_lisp_name ~ ')' ~ Main::newline()
		 ~ '(set-lexical-variable/c ' ~ $.var.emit_lisp_name ~ ' (lookup-package-variable/c ' ~ $.var.emit_lisp_name ~ ' (enclosing-package)))';
	}
	if $decl eq 'my' {
	    return '(define-lexical-variable ' ~ $.var.emit_lisp_name ~ ')';
	}

	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "\\"' ~ $decl ~ '\\" variables")';
    }
}

class Sig {
    method emit_lisp ($interpreter, $indent) {
	my $str := '(make-instance \'kp6-signature';

	if $.invocant {
	    $str := $str ~ ' :invocant ' ~ $.invocant.emit_lisp($interpreter, $indent);
	}

	$str := $str ~ ' :positional (list';

	for @($.positional) -> $decl {
	    $str := $str ~ ' (make-instance \'kp6-named-parameter :name ' ~ $decl.emit_lisp_name($interpreter, $indent) ~ ')';
	}

	$str := $str ~ ')';

	$str := $str ~ ')';

	return $str;
    };
}

class Capture {
    method emit_lisp ($interpreter, $indent) {
        my $s := '(kp6-new \'capture ';
        if defined $.invocant {
           $s := $s ~ 'invocant: ' ~ $.invocant.emit_lisp($interpreter, $indent) ~ ', ';
        }
        else {
            $s := $s ~ 'invocant: $::Undef, '
        };
        if defined $.array {
           $s := $s ~ 'array: ::DISPATCH( $::Array, "new", { _array => [ ';
                            my $item;
           for @.array -> $item { 
                $s := $s ~ $item.emit_lisp($interpreter, $indent) ~ ', ';
            }
            $s := $s ~ ' ] } ),';
        };
        if defined $.hash {
           $s := $s ~ 'hash: ::DISPATCH( $::Hash, "new", { _hash => { ';
                           my $item;
           for @.hash -> $item { 
                $s := $s ~ ($item[0]).emit_lisp($interpreter, $indent) ~ '->{_value} => ' ~ ($item[1]).emit_lisp($interpreter) ~ ', ';
            }
            $s := $s ~ ' } } ),';
        };
        return $s ~ ')';
    };
}

class Subset {
    method emit_lisp ($interpreter, $indent) {
	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "subsets")';
    }
}

class Method {
    method emit_lisp ($interpreter, $indent) {
	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "methods")';
    }
}

class Sub {
    method emit_lisp ($interpreter, $indent) {
	return '(make-kp6-sub (' ~ $.block.emit_signature($interpreter, $indent) ~ ')' ~ Main::newline() ~ $.block.emit_body($interpreter, $indent) ~ ')';
    }
}

class Do {
    # Everything's an expression in lisp so do {} is implicit:)
    method emit_lisp ($interpreter, $indent) {
        $.block.emit_lisp($interpreter, $indent);
    }
}

class BEGIN {
    method emit_lisp ($interpreter, $indent) {
	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "BEGIN blocks")';
    }
}

class Use {
    method emit_lisp ($interpreter, $indent) {
        if ($.mod eq 'v6') {
	    return;
        }

	return '(kp6-error ' ~ $interpreter ~ ' \'kp6-not-implemented :feature "importing modules")';
    }
}

=begin

=head1 NAME 

KindaPerl6::Perl5::Lisp - Code generator for KindaPerl6-in-Lisp

=head1 DESCRIPTION

This module generates Common Lisp code for the KindaPerl6
compiler. The runtime is located in F<src/KindaPerl6/Runtime/Lisp/>.

=head1 CONFORMANCE

sbcl is currently the primary runtime being used to develop this,
clisp is also tested occasionally.

=head1 AUTHORS

The Pugs Team E<lt>perl6-compiler@perl.orgE<gt>.

=head1 SEE ALSO

The Perl 6 homepage at L<http://dev.perl.org/perl6>.

The Pugs homepage at L<http://pugscode.org/>.

=head1 COPYRIGHT

Copyright 2007 by Flavio Soibelmann Glock and others.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=end