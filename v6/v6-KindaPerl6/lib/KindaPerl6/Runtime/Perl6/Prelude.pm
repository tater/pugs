#
# kp6 "Prelude"
#
# NOTE: this file must be compiled with kp6 - not mp6!!!
#
# $ perl kp6-perl5.pl < lib/KindaPerl6/Runtime/Perl6/Prelude.pm | perltidy > lib5/KindaPerl6/Runtime/Perl6/Prelude.pm
#

#class Main { say "# Initializing Perl6::Prelude.pm" }

class Match {
    has $.from;
    has $.to;
    has $.result;
    has $.bool;
    has $.match_str;
    has $.array;
    has $.hash;
    
    method str {
           self.bool 
        ?? substr( self.match_str, self.from, self.to - self.from )
        !! undef;
    }
}

# XXX how about long names and double-semicolon
class Signature {
    has $.invocant;
    has $.positional;
    has $.named;
    has $.return;
}

# XXX "does Container" ???
#class Scalar does Container {
#    has $.value;
#}

#class Array does Container {
#    has $.value;
#}

#class Hash does Container {
#    has $.value;
#}

