# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Visitor::Emit::AstPerl;
sub new { shift; bless {@_}, "KindaPerl6::Visitor::Emit::AstPerl" }

sub visit {
    my $self   = shift;
    my $List__ = \@_;
    my $node;
    my $node_name;
    do { $node = $List__->[0]; $node_name = $List__->[1]; [ $node, $node_name ] };
    do {
        if ( ( Main::isa( $node, 'Array' ) || Main::isa( $node, 'List' ) ) ) {
            my $result = '';
            $result = ( $result . '[ ' );
            my $subitem;
            do {
                for my $subitem ( @{$node} ) {
                    do {
                        if ( ( Main::isa( $subitem, 'Array' ) || Main::isa( $subitem, 'List' ) ) ) { $result = ( $result . ( $self->visit( $subitem, 'Array' ) . ', ' ) ) }
                        else {
                            do {
                                if ( Main::isa( $subitem, 'Str' ) ) { $result = ( $result . ( '\'' . ( $subitem . '\', ' ) ) ) }
                                else {
                                    do {
                                        if ($subitem) { $result = ( $result . ( $subitem->emit($self) . ', ' ) ) }
                                        else          { }
                                        }
                                }
                                }
                        }
                        }
                }
            };
            return ( ( $result . ' ]' ) );
        }
        else { }
    };
    do {
        if ( Main::isa( $node, 'Str' ) ) { return ( ( '\'' . ( $node . '\'' ) ) ) }
        else                             { }
    };
    my $result = '';
    $result = ( $result . ( '::' . ( $node_name . '( ' ) ) );
    my $data = $node->attribs();
    my $item;
    do {
        for my $item ( keys( %{$data} ) ) {
            $result = ( $result . ( ' ' . ( $item . ' => ' ) ) );
            do {
                if ( ( Main::isa( $data->{$item}, 'Array' ) || Main::isa( $data->{$item}, 'List' ) ) ) { $result = ( $result . ( $self->visit( $data->{$item}, 'Array' ) . ', ' ) ) }
                else {
                    do {
                        if ( Main::isa( $data->{$item}, 'Hash' ) ) {
                            $result = ( $result . '{ ' );
                            my $subitem;
                            do {
                                for my $subitem ( keys( %{ $data->{$item} } ) ) { $result = ( $result . ( $subitem . ( ' => ' . ( $data->{$item}->{$subitem}->emit($self) . ', ' ) ) ) ) }
                            };
                            $result = ( $result . ' }, ' );
                        }
                        else {
                            do {
                                if ( Main::isa( $data->{$item}, 'Str' ) ) { $result = ( $result . ( $self->visit( $data->{$item}, 'Str' ) . ', ' ) ) }
                                else {
                                    do {
                                        if ( $data->{$item} ) { $result = ( $result . ( $data->{$item}->emit($self) . ', ' ) ) }
                                        else                  { }
                                        }
                                }
                                }
                        }
                        }
                }
                }
        }
    };
    $result = ( $result . ') ' );
}

1;
