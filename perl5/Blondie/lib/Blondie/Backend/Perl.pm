#!/usr/bin/perl

package Blondie::Backend::Perl;
use base qw/Blondie::Runtime/;

use strict;
use warnings;

use Blondie::Backend::Perl::Builtins;

use UNIVERSAL::require;

sub compiler_class { __PACKAGE__ . "::Compiler" };

sub interpreter_class { __PACKAGE__ . "::Interpreter" }

sub run {
    my $self = shift;

    my $c = $self->compile(@_);

    $self->execute($c);
}

sub interpreter {
    my $self = shift;
    my $class = $self->interpreter_class;
    $class->require;
    $class->new;
}

sub provides {
    my $self = shift;
    Blondie::Backend::Perl::Builtins->find(@_);
}

sub execute {
    my $self = shift;
    my $prog = shift;

    $self->interpreter->execute($prog);
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Blondie::Backend::Perl - 

=head1 SYNOPSIS

    use Blondie::Backend::Perl;

=head1 DESCRIPTION

=cut


