#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

use MetaModel;

=pod

This test file is testing the SUPER call.

=cut

class FooBase => {
    class => {
        methods => {
            foo => sub { 'FooBase::foo' },
            bar => sub { shift; 'FooBase::bar->(' . (join ', ' => @_) . ')' }
        }
    }  
};

class Foo => {
    extends => 'FooBase',
    class => {
        methods => {
            foo => sub { 
                my $self = shift;
                return 'SUPER -> ' . $self->SUPER('foo') 
            },
            bar => sub { 
                my $self = shift;
                return 'SUPER -> ' . $self->SUPER('bar', 'test') 
            }            
        }
    }  
};

my $foo = Foo->new_instance();
isa_ok($foo, 'Foo');

is($foo->foo(), 'SUPER -> FooBase::foo', '... got ther wrapped SUPER call');
is($foo->bar(), 'SUPER -> FooBase::bar->(test)', '... got ther wrapped SUPER call w/ arguments');