
use v6-alpha;

class KindaPerl6::Visitor::EmitPerl5 {

    # This visitor is a perl5 emitter
    
    method visit ( $node ) {
        $node.emit_perl5;
    };

}

class CompUnit {
    method emit_perl5 {
          '{ package ' ~ $.name ~ '; ' ~ Main::newline()
        ~ '# Do not edit this file - Perl 5 generated by ' ~ $Main::_V6_COMPILER_NAME ~ Main::newline()
        ~ 'use v5; '
        ~ 'use strict; '
        ~ 'no strict \'vars\'; '
        ~ 'use KindaPerl6::Runtime::Perl5::Runtime; '
        ~ 'use KindaPerl6::Runtime::Perl6::Hash; '
        ~ 'my $_MODIFIED; BEGIN { $_MODIFIED = {} } '

        # XXX - not sure about $_ scope
        ~ 'BEGIN { '
        ~   '$_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); '
        ~ '} '

        ~ $.body.emit_perl5
        ~ '; 1 }' ~ Main::newline();
    }
}

class Val::Int {
    method emit_perl5 { 
        # $.int 
        '::DISPATCH( $::Int, \'new\', ' ~ $.int ~ ' )'
    }
}

class Val::Bit {
    method emit_perl5 { 
        # $.bit 
        '::DISPATCH( $::Bit, \'new\', ' ~ $.bit ~ ' )'
    }
}

class Val::Num {
    method emit_perl5 { 
        #$.num 
        '::DISPATCH( $::Num, \'new\', ' ~ $.num ~ ' )'
    }
}

class Val::Buf {
    method emit_perl5 { 
        # '\'' ~ $.buf ~ '\'' 
        '::DISPATCH( $::Str, \'new\', ' ~ '\'' ~ Main::mangle_string( $.buf ) ~ '\'' ~ ' )'
    }
}

class Val::Undef {
    method emit_perl5 { 
        #'(undef)' 
        '$::Undef'
    }
}

class Val::Object {
    method emit_perl5 {
        die 'not implemented';
        # 'bless(' ~ %.fields.perl ~ ', ' ~ $.class.perl ~ ')';
    }
}

class Native::Buf {
    method emit_perl5 { 
        die 'not implemented';
        # '\'' ~ $.buf ~ '\''
    }
}

class Lit::Seq {
    method emit_perl5 {
        '(' ~ (@.seq.>>emit_perl5).join(', ') ~ ')';
    }
}

class Lit::Array {
    method emit_perl5 {
        '[' ~ (@.array.>>emit_perl5).join(', ') ~ ']';
    }
}

class Lit::Hash {
    method emit_perl5 {
        my $fields := @.hash;
        my $str := '';
        for @$fields -> $field { 
            $str := $str ~ ($field[0]).emit_perl5 ~ ' => ' ~ ($field[1]).emit_perl5 ~ ',';
        }; 
        '{ ' ~ $str ~ ' }';
    }
}

class Lit::Pair {
    method emit_perl5 {
        '::DISPATCH( $::Pair, \'new\', ' 
        ~ '{ key => '   ~ $.key.emit_perl5
        ~ ', value => ' ~ $.value.emit_perl5
        ~ ' } )'
    }
}

class Lit::Code {
    method emit_perl5 {
        my $s;
        for @($.pad.variable_names) -> $name {
            my $decl := ::Decl(
                decl => 'my',
                type => '',
                var  => ::Var(
                    sigil => '',
                    twigil => '',
                    name => $name,
                ),
            );
            $s := $s ~ $name.emit_perl5 ~ '; ';
            #$s := $s ~ 'my ' ~ $name ~ '; ';
        };
        return 
            $s
            ~ (@.body.>>emit_perl5).join('; ');
#        my $a := $.body;
#        my $s;
#        for @$a -> $item {
#            $s := $s ~ $item.emit_perl5 ~ ';' ~ Main::newline();
#        };
#        return $s;
    }
}

class Lit::Object {
    method emit_perl5 {
        # $.class ~ '->new( ' ~ @.fields.>>emit_perl5.join(', ') ~ ' )';
        my $fields := @.fields;
        my $str := '';
        # say @fields.map(sub { $_[0].emit_perl5 ~ ' => ' ~ $_[1].emit_perl5}).join(', ') ~ ')';
        for @$fields -> $field { 
            $str := $str ~ ($field[0]).emit_perl5 ~ ' => ' ~ ($field[1]).emit_perl5 ~ ',';
        }; 
        '::DISPATCH( $::' ~ $.class ~ ', \'new\', ' ~ $str ~ ' )';
    }
}

class Index {
    method emit_perl5 {
        '::DISPATCH( ' ~ $.obj.emit_perl5 ~ ', \'INDEX\', ' ~ $.index.emit_perl5 ~ ' )';
    }
}

class Lookup {
    method emit_perl5 {
        '::DISPATCH( ' ~ $.obj.emit_perl5 ~ ', \'LOOKUP\', ' ~ $.index.emit_perl5 ~ ' )';
    }
}

class Assign {
    method emit_perl5 {
        # TODO - same as ::Bind
        '::DISPATCH_VAR( ' ~ $.parameters.emit_perl5 ~ ', \'STORE\', ' ~ $.arguments.emit_perl5 ~ ' )';
    }
}

class Var {
    method emit_perl5 {
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
            return '::DISPATCH( $self, "' ~ $.name ~ '" )' 
        };
        
        if $.name eq '/' {
            return $table{$.sigil} ~ 'MATCH' 
        };
        
        return Main::mangle_name( $.sigil, $.twigil, $.name ); 
    };
}

class Bind {
    #|| ( $.parameters.isa( 'Array' ) && @($.parameters.array) ) {    
    method emit_perl5 {
        if $.parameters.isa( 'Var' ) {
            return '::DISPATCH_VAR( '  
            ~ $.parameters.emit_perl5 
            ~ ', \'BIND\', ' 
            ~ $.arguments.emit_perl5 ~ ' )';
        };
        if $.parameters.isa( 'Proto' ) {
            return $.parameters.emit_perl5 ~ ' = ' ~ $.arguments.emit_perl5;
        }
    }
}

class Proto {
    method emit_perl5 {
        return '$::'~$.name;
    }
}

class Call {
    method emit_perl5 {
        my $invocant;
        if $.invocant.isa( 'Proto' ) {

            if $.invocant.name eq 'self' {
                $invocant := '$self';
            }
            else {
                $invocant := $.invocant.emit_perl5;
            }
            
        }
        else {
            $invocant := $.invocant.emit_perl5;
        };
        if $invocant eq 'self' {
            $invocant := '$self';
        };
        if     ($.method eq 'yaml')
            || ($.method eq 'join')
            || ($.method eq 'chars')
            # || ($.method eq 'isa')
        { 
            if ($.hyper) {
                return 
                    '[ map { Main::' ~ $.method ~ '( $_, ' ~ ', ' ~ (@.arguments.>>emit_perl5).join(', ') ~ ')' ~ ' } @{ ' ~ $invocant ~ ' } ]';
            }
            else {
                return
                    'Main::' ~ $.method ~ '(' ~ $invocant ~ ', ' ~ (@.arguments.>>emit_perl5).join(', ') ~ ')';
            }
        };

        my $meth := $.method;
        if  $meth eq 'postcircumfix:<( )>'  {
             $meth := '';  
        };
        
        my $call := (@.arguments.>>emit_perl5).join(', ');
        if ($.hyper) {
            # TODO - hyper + role
            '[ map { $_' ~ '->' ~ $meth ~ '(' ~ $call ~ ') } @{ ' ~ $invocant ~ ' } ]';
        }
        else {
            if ( $meth eq '' ) {
                # $var.()
                '::DISPATCH( ' ~ $invocant ~ ', \'APPLY\', ' ~ $call ~ ' )'
            }
            else {
                  '::DISPATCH( ' 
                ~ $invocant ~ ', '
                ~ '\'' ~ $meth ~ '\', '
                ~ $call
                ~ ' )'
            };
        };
        

    }
}

class Apply {
    method emit_perl5 {
        return  '::DISPATCH( ' ~ $.code.emit_perl5 ~ ', \'APPLY\', ' ~ (@.arguments.>>emit_perl5).join(', ') ~ ' )';
    }
}

class Return {
    method emit_perl5 {
        return
        #'do { print Main::perl(caller(),' ~ $.result.emit_perl5 ~ '); return(' ~ $.result.emit_perl5 ~ ') }';
        'return(' ~ $.result.emit_perl5 ~ ')';
    }
}

class If {
    method emit_perl5 {
        'do { if (::DISPATCH(::DISPATCH(' ~ $.cond.emit_perl5 ~ ',"true"),"p5landish") ) ' 
        ~ ( $.body 
            ?? '{ ' ~ $.body.emit_perl5 ~ ' } '
            !! '{ } '
          )
        ~ ( $.otherwise 
            ?? ' else { ' ~ $.otherwise.emit_perl5 ~ ' }' 
            !! '' 
          )
        ~ ' }';
    }
}

class For {
    method emit_perl5 {
        my $cond := $.cond;
        if   $cond.isa( 'Var' ) 
          && $cond.sigil eq '@' 
        {
            $cond := ::Apply( code => 'prefix:<@>', arguments => [ $cond ] );
        };
        'do { for my ' ~ $.topic.emit_perl5 ~ ' ( ' ~ $cond.emit_perl5 ~ ' ) { ' ~ $.body.emit_perl5 ~ ' } }';
    }
}

class Decl {
    method emit_perl5 {
        my $decl := $.decl;
        my $name := $.var.name;
        if $decl eq 'has' {
            return 'sub ' ~ $name ~ ' { ' ~
            '@_ == 1 ' ~
                '? ( $_[0]->{' ~ $name ~ '} ) ' ~
                ': ( $_[0]->{' ~ $name ~ '} = $_[1] ) ' ~
            '}';
        };
        my $create := ', \'new\', { modified => $_MODIFIED, name => \'' ~ $.var.emit_perl5 ~ '\' } ) ';
        if $decl eq 'our' {
            my $s;
            # ??? use vars --> because compile-time scope is too tricky to use 'our'
            # ??? $s := 'use vars \'' ~ $.var.emit_perl5 ~ '\'; ';  
            $s := 'our ';

            if ($.var).sigil eq '$' {
                return $s 
                    ~ $.var.emit_perl5
                    ~ ' = ::DISPATCH( $::Scalar' ~ $create
                    ~ ' unless defined ' ~ $.var.emit_perl5 ~ '; '
                    ~ 'BEGIN { '
                    ~     $.var.emit_perl5
                    ~     ' = ::DISPATCH( $::Scalar' ~ $create
                    ~     ' unless defined ' ~ $.var.emit_perl5 ~ '; '
                    ~ '}'
            };
            if ($.var).sigil eq '&' {
                return $s 
                    ~ $.var.emit_perl5
                    ~ ' = ::DISPATCH( $::Routine' ~ $create;
            };
            if ($.var).sigil eq '%' {
                return $s ~ $.var.emit_perl5
                    ~ ' = ::DISPATCH( $::Hash' ~ $create;
            };
            if ($.var).sigil eq '@' {
                return $s ~ $.var.emit_perl5
                    ~ ' = ::DISPATCH( $::Array' ~ $create;
            };
            return $s ~ $.var.emit_perl5 ~ ' ';
        };
        if ($.var).sigil eq '$' {
            return 
                  $.decl ~ ' ' 
                # ~ $.type ~ ' ' 
                ~ $.var.emit_perl5 ~ '; '
                ~ $.var.emit_perl5
                ~ ' = ::DISPATCH( $::Scalar' ~ $create
                ~ ' unless defined ' ~ $.var.emit_perl5 ~ '; '
                ~ 'BEGIN { '
                ~     $.var.emit_perl5
                ~     ' = ::DISPATCH( $::Scalar' ~ $create
                ~ '}'
                ;
        };
        if ($.var).sigil eq '&' {
            return 
                  $.decl ~ ' ' 
                # ~ $.type ~ ' ' 
                ~ $.var.emit_perl5 ~ '; '
                ~ $.var.emit_perl5
                ~ ' = ::DISPATCH( $::Routine' ~ $create
                ~ ' unless defined ' ~ $.var.emit_perl5 ~ '; '
                ~ 'BEGIN { '
                ~     $.var.emit_perl5
                ~     ' = ::DISPATCH( $::Routine' ~ $create
                ~ '}'
                ;
        };
        if ($.var).sigil eq '%' {
            return $.decl ~ ' ' 
                # ~ $.type 
                ~ ' ' ~ $.var.emit_perl5
                ~ ' = ::DISPATCH( $::Hash' ~ $create;
        };
        if ($.var).sigil eq '@' {
            return $.decl ~ ' ' 
                # ~ $.type 
                ~ ' ' ~ $.var.emit_perl5
                ~ ' = ::DISPATCH( $::Array' ~ $create;
        };
        return $.decl ~ ' ' 
            # ~ $.type ~ ' ' 
            ~ $.var.emit_perl5;
    }
}

class Sig {
    method emit_perl5 {
        ' print \'Signature - TODO\'; die \'Signature - TODO\'; '
    };
}

class Subset {
    method emit_perl5 {
          '::DISPATCH( $::Subset, "new", { ' 
        ~ 'base_class => ' ~ $.base_class.emit_perl5 
        ~ ', '
        ~ 'block => '    
        ~       'sub { local $_ = shift; ' ~ ($.block.block).emit_perl5 ~ ' } '    # XXX
        ~ ' } )'
    }
}

class Method {
    method emit_perl5 {
        # TODO - signature binding
        my $sig := $.block.sig;
        # say "Sig: ", $sig.perl;
        my $invocant := $sig.invocant; 
        # say $invocant.emit_perl5;

        my $pos := $sig.positional;
        my $str := 'my $List__ = \@_; ';   # no strict "vars"; ';

        # TODO - follow recursively
        my $pos := $sig.positional;
        for @$pos -> $field { 
            $str := $str ~ 'my ' ~ $field.emit_perl5 ~ '; ';
        };

        my $bind := ::Bind( 
            'parameters' => ::Lit::Array( array => $sig.positional ), 
            'arguments'  => ::Var( sigil => '@', twigil => '', name => '_' )
        );
        $str := $str ~ $bind.emit_perl5 ~ '; ';

#        my $pos := $sig.positional;
#        my $str := '';
#        my $i := 1;
#        for @$pos -> $field { 
#            $str := $str ~ 'my ' ~ $field.emit_perl5 ~ ' = $_[' ~ $i ~ ']; ';
#            $i := $i + 1;
#        };

        'sub ' ~ $.name ~ ' { ' ~ 
          'my ' ~ $invocant.emit_perl5 ~ ' = shift; ' ~
          $str ~
          $.block.emit_perl5 ~ 
        ' }'
    }
}

class Sub {
    method emit_perl5 {
        # TODO - signature binding
        my $sig := $.block.sig;
        # say "Sig: ", $sig.perl;
        ## my $invocant := $sig.invocant; 
        # say $invocant.emit_perl5;
        my $pos := $sig.positional;
        my $str := 'my $List__ = \@_; ';  # no strict "vars"; ;

        # TODO - follow recursively
        my $pos := $sig.positional;
        if @$pos {
            for @$pos -> $field { 
                $str := $str ~ 'my ' ~ $field.emit_perl5 ~ '; ';
            };
    
            my $bind := ::Bind( 
                'parameters' => ::Lit::Array( array => $sig.positional ), 
                'arguments'  => ::Var( sigil => '@', twigil => '', name => '_' )
            );
            $str := $str ~ $bind.emit_perl5 ~ '; ';
        };
        
        my $code :=
          '::DISPATCH( $::Code, \'new\', { '
        ~   'code => sub { '  
            ## 'my ' ~ $invocant.emit_perl5 ~ ' = $_[0]; ' ~
        ~      $str 
        ~      $.block.emit_perl5  
        ~    ' }'
        ~    ', src => q#sub { ' ~ COMPILER::emit_perl6( $.block ) ~ ' }#'
        ~ ' } )'
        ;
        if ( $.name ) {
            return '$Code_' ~ $.name ~ '->BIND( ' ~ $code ~ ')';
        };
        return $code;
    }
}

class Do {
    method emit_perl5 {
        'do { ' ~ 
          $.block.emit_perl5 ~ 
        ' }'
    }
}

class BEGIN {
    method emit_perl5 {
        'BEGIN { ' ~ 
          $.block.emit_perl5 ~ 
        ' }'
    }
}

class Use {
    method emit_perl5 {
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

KindaPerl6::Perl5::EmitPerl5 - Code generator for KindaPerl6-in-Perl5

=head1 DESCRIPTION

This module generates Perl5 code for the KindaPerl6 compiler.

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
