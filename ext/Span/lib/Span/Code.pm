use v6;

# TODO - elements can be spans

class Span::Code-0.01
    does Span
{
    has &.closure_next;
    has &.closure_previous;
    has Span::Code $.universe;

    has &.complement_next;
    has &.complement_previous;

    has $:arbitrary_limit;

submethod BUILD ( $.closure_next, $.closure_previous, ?$.universe ) {
    # TODO - get rid of this
    $:arbitrary_limit = 100;
}

method size () returns Object {
    # TODO - not lazy
    return undef;
}

method start () {
    return &.closure_next( -Inf )
}

method end () {
    return &.closure_previous( Inf )
}

method start_is_closed () { return bool::true }
method start_is_open   () { return bool::false }
method end_is_closed   () { return bool::true }
method end_is_open     () { return bool::false }

method compare ($self: $span is copy) returns int { 
    # TODO - this is hard
    ...
}

method contains ($self: $span is copy) returns bool {
    ...
}

method intersects ($self: $span is copy) returns bool {
    ...
}

method union ($self: $span is copy) returns List of Span { 
    return $self.new( 
        closure_next => sub {
                    my $n1 = $self.closure_next( $^a );
                    my $n2 = $span.closure_next( $^a );
                    return $n1 < $n2 ?? $n1 :: $n2;
                },
        closure_previous => sub {
                    my $n1 = $self.closure_previous( $^a );
                    my $n2 = $span.closure_previous( $^a );
                    return $n1 > $n2 ?? $n1 :: $n2;
                },
        complement_next => sub {
                    my $n1;
                    my $n2 = $span.complement_next( $^a );
                    for ( 0 .. $:arbitrary_limit )
                    {
                        $n1 = $self.complement_next( $self.complement_previous( $n2 ) );
                        return $n1 if $n1 == $n2;
                        $n2 = $span.complement_next( $span.complement_previous( $n1 ) );
                    }
                    warn "Arbitrary limit exceeded when calculating union()";
                },
        complement_previous => sub {
                    my $n1;
                    my $n2 = $span.complement_previous( $^a );
                    for ( 0 .. $:arbitrary_limit )
                    {
                        $n1 = $self.complement_previous( $self.complement_next( $n2 ) );
                        return $n1 if $n1 == $n2;
                        $n2 = $span.complement_previous( $span.complement_next( $n1 ) );
                    }
                    warn "Arbitrary limit exceeded when calculating union()";
                },
        universe => $self.get_universe,
    )
}

method intersection ($self: $span is copy) returns List of Span {
    return $self.new( 
        closure_next => sub {
                    my $n1;
                    my $n2 = $span.closure_next( $^a );
                    for ( 0 .. $:arbitrary_limit )
                    {
                        $n1 = $self.next( $self.closure_previous( $n2 ) );
                        return $n1 if $n1 == $n2;
                        $n2 = $span.next( $span.closure_previous( $n1 ) );
                    }
                    warn "Arbitrary limit exceeded when calculating intersection()";
                },
        closure_previous => sub {
                    my $n1;
                    my $n2 = $span.closure_previous( $^a );
                    for ( 0 .. $:arbitrary_limit )
                    {
                        $n1 = $self.previous( $self.closure_next( $n2 ) );
                        return $n1 if $n1 == $n2;
                        $n2 = $span.previous( $span.closure_next( $n1 ) );
                    }
                    warn "Arbitrary limit exceeded when calculating intersection()";
                },
        complement_next => sub {
                    my $n1 = $self.complement_next( $^a );
                    my $n2 = $span.complement_next( $^a );
                    return $n1 < $n2 ?? $n1 :: $n2;
                },
        complement_previous => sub {
                    my $n1 = $self.complement_previous( $^a );
                    my $n2 = $span.complement_previous( $^a );
                    return $n1 > $n2 ?? $n1 :: $n2;
                },
        universe => $self.get_universe,
    )
}

method complement ($self: ) returns List of Span {
    return $self.new( 
        next =>                $self.get_complement_next, 
        previous =>            $self.get_complement_previous, 
        complement_next =>     &.closure_next,
        complement_previous => &.closure_previous,
        universe =>            $self.get_universe,
    );
}

method difference ($self: $span is copy) returns List of Span {
    return $self.intersection( $span.complement );
}

method next ( $x ) { 
    # the parent class should verify that $x belongs to the universe set
    return &.closure_next( $x );
}

method previous ( $x ) { 
    return &.closure_previous( $x );
}

method get_complement_next ($self: ) { 
    return &.complement_next unless defined &.complement_next;
    $self.get_universe;
    return &.complement_next =
        sub ( $x is copy ) {
            for ( 0 .. $:arbitrary_limit )
            {
                $x = $.universe.closure_next( $x );
                return $x unless $x == $span.closure_previous( $span.closure_next( $x ) );
            }
            warn "Arbitrary limit exceeded when calculating complement()";
        };
}

method get_complement_previous ($self: ) { 
    return &.complement_previous unless defined &.complement_previous;
    $self.get_universe;
    return &.complement_previous =
        sub ( $x is copy ) {
            for ( 0 .. $:arbitrary_limit )
            {
                $x = $.universe.closure_previous( $x );
                return $x unless $x == $span.next( $span.closure_previous( $x ) );
            }
            warn "Arbitrary limit exceeded when calculating complement()";
        };
}

method get_universe ($self: ) {
    return $.universe = $self unless defined $.universe;
    return $.universe;
}

} # class Span::Code


=kwid

= NAME

Span::Code - An object representing a single span ...

= SYNOPSIS

    use Span::Code;

    $int_span = Span.new( ... );

= AUTHOR

Flavio S. Glock, <fglock@pucrs.br>

= COPYRIGHT

Copyright (c) 2005, Flavio S. Glock.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
