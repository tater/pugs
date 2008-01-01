
use v6-alpha;

class KindaPerl6::Visitor::Emit::Perl5V6 {
    has $.visitor_args;
    # This visitor is a v6 style perl5 emitter

    method visit ( $node ) {
        $node.emit_perl5v6($.visitor_args{'secure'});
    };

}

class CompUnit {
    method emit_perl5v6() {
        $KindaPerl6::Visitor::Emit::Perl5::current_compunit := $.name;
        my $source := '';
        if ($.body) {
            $source := $.body.emit_perl5v6;
        };

          '{ package ' ~ $.name ~ '; ' ~ Main::newline()
        ~ '# Do not edit this file - Perl 5 generated by ' ~ $Main::_V6_COMPILER_NAME ~ Main::newline()
        ~ '# AUTHORS, COPYRIGHT: Please look at the source file.' ~ Main::newline()
        ~ 'use v5;' ~ Main::newline()
        ~ 'use strict;' ~ Main::newline()
        ~ 'use Data::Bind;' ~ Main::newline()
        ~ 'use KindaPerl6::Runtime::Perl5V6::Runtime;' ~ Main::newline()
        ~ 'sub {' ~ $source ~ '}->()' ~ Main::newline()
        ~ '; 1 }' ~ Main::newline();
    }
}

class Val::Int {
    method emit_perl5v6 {
        # $.int
         $.int;
    }
}

class Val::Bit {
    method emit_perl5v6 {
        # $.bit
         $.bit;
    }
}

class Val::Num {
    method emit_perl5v6 {
        #$.num
         $.num;
    }
}

class Val::Buf {
    method emit_perl5v6 {
        # '\'' ~ $.buf ~ '\''
        Main::singlequote() ~ Main::mangle_string( $.buf ) ~ Main::singlequote;
    }
}

class Val::Char {
    method emit_perl5v6 {
        'chr( ' ~ $.char ~ ' )';
    }
}

class Val::Undef {
    method emit_perl5v6 {
        #'(undef)'
        '(undef)'
    }
}

class Val::Object {
    method emit_perl5v6 {
        die 'Emitting of Val::Object not implemented';
        # 'bless(' ~ %.fields.perl ~ ', ' ~ $.class.perl ~ ')';
    }
}

class Native::Buf {
    method emit_perl5v6 {
        die 'Emitting of Native::Buf not implemented';
        # '\'' ~ $.buf ~ '\''
    }
}

class Lit::Seq {
    method emit_perl5v6 {
        '(' ~ (@.seq.>>emit_perl5v6).join(', ') ~ ')';
    }
}

class Lit::Array {
    method emit_perl5v6 {
        # this is not a Perl 6 object, objects are created with a high-level Array.new or List.new
        '{ _array => [' ~ (@.array.>>emit_perl5v6).join(', ') ~ '] }' ~ Main::newline();
    }
}

class Lit::Hash {
    method emit_perl5v6 {
        # this is not a Perl 6 object, objects are created with a high-level Hash.new
        my $fields := @.hash;
        my $str := '';
        my $field;
        for @$fields -> $field {
            $str := $str ~ '[ ' ~ ($field[0]).emit_perl5v6 ~ ', ' ~ ($field[1]).emit_perl5v6 ~ ' ],';
        };
        $str ~ Main::newline();
    }
}

class Lit::Pair {
    method emit_perl5v6 {
        '::DISPATCH( $::Pair, \'new\', '
        ~ '{ key => '   ~ $.key.emit_perl5v6
        ~ ', value => ' ~ $.value.emit_perl5v6
        ~ ' } )' ~ Main::newline();
    }
}

class Lit::NamedArgument {
    method emit_perl5v6 {
        '::DISPATCH( $::NamedArgument, \'new\', '
        ~ '{ _argument_name_ => '   ~ $.key.emit_perl5v6
        ~ ', value => ' ~ ( defined($.value) ?? $.value.emit_perl5v6 !! 'undef' )   # XXX
        ~ ' } )' ~ Main::newline();
    }
}

class Lit::SigArgument {
    method emit_perl5v6 {

        '::DISPATCH( $::Signature::Item, \'new\', '
        ~ '{ '

        ~     'sigil  => \'' ~ $.key.sigil  ~ '\', '
        ~     'twigil => \'' ~ $.key.twigil ~ '\', '
        ~     'name   => \'' ~ $.key.name   ~ '\', '

        ~     'value  => ' ~ ( defined($.value) ?? $.value.emit_perl5v6 !! 'undef' ) ~ ', '  # XXX

        ~     'has_default    => ' ~ $.has_default.emit_perl5v6  ~ ', '
        ~     'is_named_only  => ' ~ $.is_named_only.emit_perl5v6  ~ ', '
        ~     'is_optional    => ' ~ $.is_optional.emit_perl5v6    ~ ', '
        ~     'is_slurpy      => ' ~ $.is_slurpy.emit_perl5v6      ~ ', '
        ~     'is_multidimensional  => ' ~ $.is_multidimensional.emit_perl5v6  ~ ', '
        ~     'is_rw          => ' ~ $.is_rw.emit_perl5v6          ~ ', '
        ~     'is_copy        => ' ~ $.is_copy.emit_perl5v6        ~ ', '

        ~ ' } )' ~ Main::newline();
    }
}

class Lit::Code {
    method emit_perl5v6 {
        if ($.CATCH) {
          'do { eval {'
        ~ self.emit_declarations ~ self.emit_body
        ~ '};if ($@) {' ~ $.CATCH.emit_perl5v6 ~ '}}';
        }
        else {
            'do {' ~ self.emit_declarations ~ self.emit_body ~ '}'
        }
    };
    method emit_body {
        (@.body.>>emit_perl5v6).join('; ');
    };
    method emit_signature {
        $.sig.emit_perl5v6
    };
    method emit_declarations {
        my $s;
        my $name;
        for @($.pad.lexicals) -> $name {
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
            $s := $s ~ $name.emit_perl5v6 ~ ';' ~ Main::newline();
        };
        return $s;
    };
    method emit_arguments {
        my $array_  := ::Var( sigil => '@', twigil => '', name => '_',       namespace => [ ], );
        my $hash_   := ::Var( sigil => '%', twigil => '', name => '_',       namespace => [ ], );
        my $CAPTURE := ::Var( sigil => '$', twigil => '', name => 'CAPTURE', namespace => [ ],);
        my $CAPTURE_decl := ::Decl(decl=>'my',type=>'',var=>$CAPTURE);
        my $str := '';
        $str := $str ~ $CAPTURE_decl.emit_perl5v6;
        $str := $str ~ ::Decl(decl=>'my',type=>'',var=>$array_).emit_perl5v6;
        $str := $str ~ '::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));';

        # XXX s/assign/bind/ ?
        my $bind_array :=
                    ::Assign(parameters=>$array_,arguments=>::Call(invocant => $CAPTURE,method => 'array',arguments => []));
        $str := $str ~ $bind_array.emit_perl5v6 ~ ';';

        my $bind_hash :=
                    ::Bind(parameters=>$hash_, arguments=>::Call(invocant => $CAPTURE,method => 'hash', arguments => []));
        $str := $str ~ $bind_hash.emit_perl5v6 ~ ';';

        my $i := 0;
        my $field;
        $str := $str ~ '{ my $_param_index = 0; ';
        for @($.sig.positional) -> $field {

            my $bind_named := ::Bind(
                    parameters => $field.key,
                    arguments  => ::Call(
                            invocant  => $hash_,
                            arguments => [ ::Val::Buf( buf => ($field.key).name ) ],
                            method    => 'LOOKUP',
                        ),
                );
            my $bind_default := ::Bind(
                    parameters => $field.key,
                    arguments  => $field.value,
                );

            $str := $str
                    ~ ' if ( ::DISPATCH( $GLOBAL::Code_exists, '
                    ~   ' \'APPLY\', '
                    ~   ' ::DISPATCH( '
                    ~       ' $Hash__, \'LOOKUP\', '
                    ~       ' ::DISPATCH( $::Str, \'new\', \'' ~ ($field.key).name ~ '\' ) '
                    ~   ' ) )->{_value} '
                    ~ ' ) '
                    ~ ' { '
                    ~     $bind_named.emit_perl5v6
                    ~ ' } '
                    ~ ' elsif ( ::DISPATCH( $GLOBAL::Code_exists, '
                    ~   ' \'APPLY\', '
                    ~   ' ::DISPATCH( '
                    ~       ' $List__, \'INDEX\', '
                    ~       ' ::DISPATCH( $::Int, \'new\', $_param_index ) '
                    ~   ' ) )->{_value} '
                    ~ ' ) '
                    ~ ' { '
                    ~     ($field.key).emit_perl5v6
                    ~         ' = ::DISPATCH( '
                    ~       ' $List__, \'INDEX\', '
                    ~       ' ::DISPATCH( $::Int, \'new\', $_param_index++ ) '
                    ~   ' ); '
                    ~ ' } ';
            if ($field.has_default).bit {
                $str := $str
                    ~ ' else { '
                    ~     $bind_default.emit_perl5v6
                    ~ ' } ';
            }
            $i := $i + 1;
        };
        $str := $str ~ '} ';

        return $str;
    };
}

class Lit::Object {
    method emit_perl5v6 {
        # $.class ~ '->new( ' ~ @.fields.>>emit_perl5v6.join(', ') ~ ' )';
        my $fields := @.fields;
        my $str := '';
        # say @fields.map(sub { $_[0].emit_perl5v6 ~ ' => ' ~ $_[1].emit_perl5v6}).join(', ') ~ ')';
        my $field;
        for @$fields -> $field {
            $str := $str
                ~ '::DISPATCH( $::NamedArgument, "new", '
                ~ '{ '
                ~    '_argument_name_ => ' ~ ($field[0]).emit_perl5v6 ~ ', '
                ~    'value           => ' ~ ($field[1]).emit_perl5v6 ~ ', '
                ~ ' } ), '
                ;
        };
        '::DISPATCH( $::' ~ $.class ~ ', \'new\', ' ~ $str ~ ' )' ~ Main::newline();
    }
}


class Assign {
    method emit_perl5v6 {
        # TODO - same as ::Bind

        $.parameters.emit_perl5v6 ~ ' = ' ~ $.arguments.emit_perl5v6 ~ Main::newline();
    }
}

class Var {
    method emit_perl5v6 {
        # Normalize the sigil here into $
        # $x    => $x
        # @x    => $List_x
        # %x    => $Hash_x
        # &x    => $Code_x
        my $table := {
            '$' => '$',
            '@' => '$List_',
            '%' => '$Hash_',
            '&' => '$Code_',
        };

        if $.twigil eq '.' {
            return '::DISPATCH( $self, "' ~ $.name ~ '" )'  ~ Main::newline()
        };
        if $.twigil eq '!' {
            return '$self->{_value}{"' ~ $.name ~ '"}'  ~ Main::newline()
        };

        if $.name eq '/' {
            return $table{$.sigil} ~ 'MATCH'
        };

        return $table{$.sigil} ~ Main::mangle_ident($.name);
        #Main::mangle_name( $.sigil, $.twigil, $.name, $.namespace );
    };
    #method perl {
    #    # this is used by the signature emitter
    #    # XXX rename this node, it may clash with a User class
    #      '::DISPATCH( $::Var, "new", { '
    #    ~     'sigil  => \'' ~ $.sigil  ~ '\', '
    #    ~     'twigil => \'' ~ $.twigil ~ '\', '
    #    ~     'name   => \'' ~ $.name   ~ '\', '
    #    ~     'namespace => [ ], '
    #    ~ '} )' ~ Main::newline()
    #}
}

class Bind {
    method emit_perl5v6 {
        if ($.parameters.isa('Var')) {
            if ( $.parameters.sigil eq '$') {
                return 'bind_op('
                    ~ Main::singlequote
                    ~ $.parameters.emit_perl5v6
                    ~ Main::singlequote 
                    ~ ' => \\'
                    ~ $.arguments.emit_perl5v6
                    ~ ')';
           };
          return '(' ~ $.parameters.emit_perl5v6 ~ ' = ' ~ $.arguments.emit_perl5v6 ~ ' )';
        };
        die 'TODO';
    }
}

class Proto {
    method emit_perl5v6 {
        return '$::'~$.name;
    }
}

class Call {
    method emit_perl5v6 {
        my $invocant;
        if $.invocant.isa( 'Proto' ) {

            if $.invocant.name eq 'self' {
                $invocant := '$self';
            }
            else {
                $invocant := $.invocant.emit_perl5v6;
            }

        }
        else {
            $invocant := $.invocant.emit_perl5v6;
        };
        if $invocant eq 'self' {
            $invocant := '$self';
        };

        my $meth := $.method;
        if  $meth eq 'postcircumfix:<( )>'  {
             $meth := '';
        };

        my $call := (@.arguments.>>emit_perl5v6).join(', ');
        if ($.hyper) {
            # TODO - hyper + role
              '::DISPATCH( $::List, "new", { _array => [ '
            ~     'map { ::DISPATCH( $_, "' ~ $meth ~ '", ' ~ $call ~ ') } '
            ~          '@{ ::DISPATCH( ' ~ $invocant ~ ', "array" )->{_value}{_array} } '
            ~ '] } )' ~ Main::newline();
        }
        else {
            if ( $meth eq '' ) {
                # $var.()
                '::DISPATCH( ' ~ $invocant ~ ', \'APPLY\', ' ~ $call ~ ' )' ~ Main::newline()
            }
            else {
                  '::DISPATCH( '
                ~ $invocant ~ ', '
                ~ '\'' ~ $meth ~ '\', '
                ~ $call
                ~ ' )'
                ~ Main::newline()
            };
        };


    }
}

class Apply {
    method emit_perl5v6 {


        if  ( $.code.isa('Var') ) && ( $.code.name eq 'self' )
        {
            # dlocaus @ #perl6 irc.freenode.net
            # fglock's comment on this work around
            # http://irclog.perlgeek.de/perl6/2007-11-21#i_148959
            # He stated that the code is return $self, instead of trying to parse
            # self().
            # Removing this hack breaks the test cases when you do:
            # perl Makefile.PL ; make forcerecompile ; make test
            # November 21st, 2007 10:51am PDT.
            return '$self';
        }


        if  ( $.code.isa('Var') ) && ( $.code.name eq 'make' )
        {
            # hack for "make" (S05)
            return  '::DISPATCH_VAR( '
                        ~ '$GLOBAL::_REGEX_RETURN_, "STORE", ' ~ ((@.arguments[0]).emit_perl5v6) ~ ''
                ~ ' )' ~ Main::newline();
        }

        my $ops := {
            'infix:<~>' => '.',
            'infix:<+>' => '+',
            'infix:<==>' => '==',
            'infix:<!=>' => 'ne',
            'infix:<eq>' => 'eq',
            'infix:<ne>' => 'ne',
            'infix:<&&>' => '&&',
            'infix:<||>' => '||',
        };
        if  ($.code.isa('Var') && ($ops{$.code.name})) {
            return  '(' 
                ~ (@.arguments[0]).emit_perl5v6
                ~ ' ' ~ $ops{$.code.name} ~ ' '
                ~ (@.arguments[1]).emit_perl5v6
                ~ ')';
        }


        return  '(' ~ $.code.emit_perl5v6 ~ ')->(' ~ (@.arguments.>>emit_perl5v6).join(', ') ~ ' )' ~ Main::newline();
    }
}

class Return {
    method emit_perl5v6 {
        # call .FETCH just in case it's a Container
        # 'return( ::DISPATCH(' ~ $.result.emit_perl5v6 ~ ', "FETCH" ) )' ~ Main::newline();

        #'do { print Main::perl(caller(),' ~ $.result.emit_perl5v6 ~ '); return(' ~ $.result.emit_perl5v6 ~ ') }';
        'return(' ~ $.result.emit_perl5v6 ~ ')' ~ Main::newline();
    }
}

class If {
    method emit_perl5v6 {
        'do { if (' ~ $.cond.emit_perl5v6 ~ ') '
        ~ ( $.body
            ?? '{ ' ~ $.body.emit_perl5v6 ~ ' } '
            !! '{ } '
          )
        ~ ( $.otherwise
            ?? ' else { ' ~ $.otherwise.emit_perl5v6 ~ ' }'
            !! ' else { 0 }'
          )
        ~ ' }' ~ Main::newline();
    }
}

class While {
    method emit_perl5v6 {
        my $cond := $.cond;
        if   $cond.isa( 'Var' )
          && $cond.sigil eq '@'
        {
        } else {
            $cond := ::Apply( code => ::Var(sigil=>'&',twigil=>'',name=>'prefix:<@>',namespace => [ 'GLOBAL' ],), arguments => [$cond] );
        }
        'do { while (::DISPATCH(::DISPATCH(' ~ $.cond.emit_perl5v6 ~ ',"true"),"p5landish") ) '
        ~ ' { '
        ~     $.body.emit_perl5v6
        ~ ' } }'
        ~ Main::newline();
    }
}

class Decl {
    method emit_perl5v6 {
        my $decl := $.decl;
        my $name := $.var.name;
        if $decl eq 'has' {
            # obsolete - "has" is handled by Visitor::MetaClass / Perl5::MOP
            return 'sub ' ~ $name ~ ' { ' ~
            '@_ == 1 ' ~
                '? ( $_[0]->{' ~ $name ~ '} ) ' ~
                ': ( $_[0]->{' ~ $name ~ '} = $_[1] ) ' ~
            '}';
        };
        return $.decl ~ ' '
            # ~ $.type ~ ' '
            ~ $.var.emit_perl5v6;
    }
}

class Sig {
    method emit_perl5v6 {
        my $inv := '$::Undef';
        if $.invocant.isa( 'Var' ) {
            $inv := $.invocant.perl;
        }

        my $pos;
        my $decl;
        for @($.positional) -> $decl {
            $pos := $pos ~ $decl.emit_perl5v6 ~ ', ';
        };

        my $named := '';  # TODO

          '::DISPATCH( $::Signature, "new", { '
        ~     'invocant => ' ~ $inv ~ ', '
        ~     'array    => ::DISPATCH( $::List, "new", { _array => [ ' ~ $pos   ~ ' ] } ), '
        # ~     'hash     => ::DISPATCH( $::Hash,  "new", { _hash  => { ' ~ $named ~ ' } } ), '
        ~     'return   => $::Undef, '
        ~ '} )'
        ~ Main::newline();
    };
}

class Lit::Capture {
    method emit_perl5v6 {
        my $s := '::DISPATCH( $::Capture, "new", { ';
        if defined $.invocant {
           $s := $s ~ 'invocant => ' ~ $.invocant.emit_perl5v6 ~ ', ';
        }
        else {
            $s := $s ~ 'invocant => $::Undef, '
        };
        if defined $.array {
           $s := $s ~ 'array => ::DISPATCH( $::List, "new", { _array => [ ';
                            my $item;
           for @.array -> $item {
                $s := $s ~ $item.emit_perl5v6 ~ ', ';
            }
            $s := $s ~ ' ] } ),';
        };
        if defined $.hash {
            $s := $s ~ 'hash => ::DISPATCH( $::Hash, "new", ';
            my $item;
            for @.hash -> $item {
                $s := $s ~ '[ ' ~ ($item[0]).emit_perl5v6 ~ ', ' ~ ($item[1]).emit_perl5v6 ~ ' ], ';
            }
            $s := $s ~ ' ),';
        };
        return $s ~ ' } )' ~ Main::newline();
    };
}

class Lit::Subset {
    method emit_perl5v6 {
          '::DISPATCH( $::Subset, "new", { '
        ~ 'base_class => ' ~ $.base_class.emit_perl5v6
        ~ ', '
        ~ 'block => '
        ~       'sub { local $_ = shift; ' ~ ($.block.block).emit_perl5v6 ~ ' } '    # XXX
        ~ ' } )' ~ Main::newline();
    }
}

class Method {
    method emit_perl5v6 {
        die "TODO methods";
          '::DISPATCH( $::Code, \'new\', { '
        ~   'code => sub { '                 ~ Main::newline()
        ~     '# emit_declarations'          ~ Main::newline()
        ~     $.block.emit_declarations      ~ Main::newline()
        ~     '# get $self'                  ~ Main::newline()
        ~     '$self = shift; '              ~ Main::newline()
        ~     '# emit_arguments'             ~ Main::newline()
        ~     $.block.emit_arguments         ~ Main::newline()
        ~     '# emit_body'                  ~ Main::newline()
        ~     $.block.emit_body
        ~    ' }, '
        ~   'signature => '
        ~       $.block.emit_signature
        ~    ', '
        ~ ' } )'
        ~ Main::newline();
    }
}

class Sub {
    method emit_perl5v6 {
        'sub {' 
        ~       $.block.emit_declarations
        ~       $.block.emit_body
        ~ ' }'
        ~ Main::newline();

#          '::DISPATCH( $::Code, \'new\', { '
#        ~   'code => sub { '
#        ~       $.block.emit_declarations
#        ~       $.block.emit_arguments
#        ~       $.block.emit_body
#        ~    ' }, '
#        ~   'signature => '
#        ~       $.block.emit_signature
#        ~    ', '
#        ~ ' } )'
#        ~ Main::newline();
    }
}

class Macro {
    method emit_perl5v6 {
          '::DISPATCH( $::Macro, \'new\', { '
        ~   'code => sub { '
        ~       $.block.emit_declarations
        ~       $.block.emit_arguments
        ~       $.block.emit_body
        ~    ' }, '
        ~   'signature => '
        ~       $.block.emit_signature
        ~    ', '
        ~ ' } )'
        ~ Main::newline();
    }
}

class Do {
    method emit_perl5v6 {
        'do { ' ~
          $.block.emit_perl5v6 ~
        ' }'
        ~ Main::newline();
    }
}

class BEGIN {
    method emit_perl5v6 {
        'INIT { ' ~
          $.block.emit_perl5v6 ~
        ' }'
    }
}

class Use {
    method emit_perl5v6 {
        if ($.mod eq 'v6') {
            return Main::newline() ~ '#use v6' ~ Main::newline();
        }
        if ( $.perl5 ) {
            return 'use ' ~ $.mod ~ ';$::' ~ $.mod ~ '= KindaPerl6::Runtime::Perl5::Wrap::use5(\'' ~ $.mod ~ '\')';
        } else {
            return 'use ' ~ $.mod;
        }
    }
}

=begin

=head1 NAME

KindaPerl6::Visitor::Emit::Perl5V6 - Code generator for KindaPerl6-in-Perl5

=head1 DESCRIPTION

This module generates Perl 5 code for the KindaPerl6 compiler. This is
the alternative perl5 emitter which emits code closer to hand written perl5 and hopefully more efficient. The runtime is
located in F<lib/KindaPerl6/Runtime/Perl5V6/>.

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
