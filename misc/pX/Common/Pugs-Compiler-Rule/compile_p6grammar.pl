# Usage: perl compile_p6grammar.pl GrammarFile.pm > GrammarFile.pmc
# The .pm file is in Perl 6 syntax
# The .pmc file is in Perl 5 Pugs::Compiler::Rule syntax

package Grammar::Compiler;
use Pugs::Compiler::Rule;
use base 'Pugs::Grammar::Base';

# XXX - added { s => 0, ratchet => 0 } until MiniPerl6.grammar can be compiled with 'token'

*grammar_name = Pugs::Compiler::Rule->compile(q([\w|\d|\:]+))->code;
*rule_name = Pugs::Compiler::Rule->compile(q(\w+))->code;
*block = Pugs::Compiler::Rule->compile(q(\{[<block>|<-[}]>|\\\\\}]*\}))->code;
*rule = Pugs::Compiler::Rule->compile(q(<'rule'> <rule_name><?ws>?<block>{
	my $body = substr($<block>, 1, -1);
	$body =~ s/\\\\/\\\\\\\\/g;  # duplicate every single backslashes
	return "*" . $<rule_name> . " = Pugs::Compiler::Rule->compile(q(" .
	$body . "), { s => 0, ratchet => 0 } )->code;"
    }))->code;
*grammar = Pugs::Compiler::Rule->compile(q(<'grammar'> <grammar_name>\;[<?ws>?<rule>]*{
        return "package " . "$<grammar_name>" .
	    ";\nuse Pugs::Compiler::Rule;\nuse base 'Pugs::Grammar::Base';\n" .
        "use Pugs::Runtime::Match::Ratchet; # overload doesn't work without this ???\n\n" .
	    join("\n", map { "$_" } @{$<rule>} ) . "\n" }
))->code;

package main;
use IO::File;
use Pugs::Runtime::Match::Ratchet;

my $source_file = shift(@ARGV);
my $source = slurp($source_file);
my $match  = Grammar::Compiler->grammar($source);
print "$match";

sub slurp {
    my $fh = IO::File->new(shift) || return;
    return join('', $fh->getlines);
}

__END__

=head1 NAME

compile_p6grammar.pl - Compile Perl6 Grammars to Perl5 Modules

=head1 SYNOPSIS

  # The .pm file is in Perl 6 syntax
  # The .pmc file is in Perl 5 Pugs::Compiler::Rule syntax

  perl compile_p6grammar.pl GrammarFile.pm > GrammarFile.pmc

=head1 DESCRIPTION

Used to convert grammars in Perl 6 syntax into Perl 5 modules.

=head1 AUTHORS

The Pugs Team E<lt>perl6-compiler@perl.orgE<gt>.

=head1 SEE ALSO

The Perl 6 Rules Spec: L<http://dev.perl.org/perl6/doc/design/syn/S05.html>

=head1 COPYRIGHT

Copyright 2006 by Nathan Gray.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

