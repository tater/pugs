package Perl6::Pugs;
$Pugs::VERSION = '6.0.7';

use strict;

=head1 NAME

Perl6::Pugs - A Perl6 Interpreter

=head1 VERSION

This document describes version 6.0.7 of Pugs, released February 18, 2005.

=head1 SYNOPSIS

    % pugs -e 'sub hi { "Hello, " ~ $_ } ; hi "World!\n"'
    Hello, World!

=head1 DESCRIPTION

Started at 2005-02-01, Pugs is an attempt at writing a Perl6 interpreter in
Haskell.  Currently it is in its very early stages.

Although Pugs does not yet directly relate to PGE or Parrot, the hope is that
it can flesh out corner cases in the Synopses during implementation, as well
as contributing more test cases to the main Perl6 project.

=head2 Release Plans

The major/minor version numbers of Pugs converges to 2*pi; each significant
digit in the minor version represents a milestone.  The third digit is
incremented for each release.

The current milestones are:

=over 4

=item 6.0: Initial release.

=item 6.2: Basic IO and control flow elements; mutable variables; assignment.

=item 6.28: Classes and traits.

=item 6.283: Rules and Grammars.

=item 6.2831: Role composition and other runtime features.

=item 6.28318: Macros.

=item 6.283185: Rewrite in Perl6.

=back

=head1 SEE ALSO

The mailing list for Pugs is perl6-compiler.  Subscribe by sending mail to
E<lt>perl6-compiler-subscribe@perl.orgE<gt>. It is archived at
L<http://www.nntp.perl.org/group/perl.perl6.compiler>
and available via NNTP at L<nntp://nntp.perl.org/perl.perl6.compiler>.

You can also read the list via Google Groups at
L<http://groups-beta.google.com/group/perl.perl6.compiler>

Please submit bug reports to E<lt>bug-perl6-pugs@rt.cpan.orgE<gt>.

=head1 COPYRIGHT

Copyright 2005 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Pugs itself.

=cut
