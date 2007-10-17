# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Grammar;
sub new { shift; bless {@_}, "KindaPerl6::Grammar" }

sub stmt_sep {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            (   do {
                    (   do {
                            my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                            do {
                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                else     {0}
                                }
                            }
                            && (
                            ( ( ';' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && do {
                                my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                do {
                                    if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                    else     {0}
                                    }
                            }
                            )
                    );
                    }
                    || do {
                    $MATCH->to($pos1);
                    (   do {
                            my $m2 = $grammar->newline( $str, $MATCH->to() );
                            do {
                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                else     {0}
                                }
                            }
                            && do {
                            my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                            do {
                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                else     {0}
                                }
                            }
                    );
                    }
            );
            }
    );
    return ($MATCH);
}

sub exp_stmts {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            (   do {
                    (   do {
                            my $m2 = $grammar->exp( $str, $MATCH->to() );
                            do {
                                if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'exp'} = $m2; 1 }
                                else     {0}
                                }
                            }
                            && do {
                            my $pos1 = $MATCH->to();
                            (   do {
                                    (   do {
                                            my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                            do {
                                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                else     {0}
                                                }
                                            }
                                            && (
                                            do {
                                                my $m2 = $grammar->exp_stmts( $str, $MATCH->to() );
                                                do {
                                                    if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'exp_stmts'} = $m2; 1 }
                                                    else     {0}
                                                    }
                                            }
                                            && (do {
                                                    my $pos1 = $MATCH->to();
                                                    (   do {
                                                            do {
                                                                my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                                                do {
                                                                    if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                                    else     {0}
                                                                    }
                                                                }
                                                            }
                                                            || do {
                                                            $MATCH->to($pos1);
                                                            do {
                                                                my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                                do {
                                                                    if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                                    else     {0}
                                                                    }
                                                                }
                                                            }
                                                    );
                                                }
                                                && do {
                                                    my $ret = sub {
                                                        my $List__ = \@_;
                                                        do { [] };
                                                        do { return ( [ ${ $MATCH->{'exp'} }, @{ ${ $MATCH->{'exp_stmts'} } } ] ) };
                                                        '974^213';
                                                        }
                                                        ->();
                                                    do {
                                                        if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                                                        else                         { }
                                                    };
                                                    1;
                                                }
                                            )
                                            )
                                    );
                                    }
                                    || do {
                                    $MATCH->to($pos1);
                                    (   do {
                                            my $pos1 = $MATCH->to();
                                            (   do {
                                                    do {
                                                        my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                                        do {
                                                            if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                            else     {0}
                                                            }
                                                        }
                                                    }
                                                    || do {
                                                    $MATCH->to($pos1);
                                                    do {
                                                        my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                        do {
                                                            if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                            else     {0}
                                                            }
                                                        }
                                                    }
                                            );
                                            }
                                            && do {
                                            my $ret = sub {
                                                my $List__ = \@_;
                                                do { [] };
                                                do { return ( [ ${ $MATCH->{'exp'} } ] ) };
                                                '974^213';
                                                }
                                                ->();
                                            do {
                                                if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                                                else                         { }
                                            };
                                            1;
                                            }
                                    );
                                    }
                            );
                            }
                    );
                    }
                    || do {
                    $MATCH->to($pos1);
                    do {
                        my $ret = sub {
                            my $List__ = \@_;
                            do { [] };
                            do { return ( [] ) };
                            '974^213';
                            }
                            ->();
                        do {
                            if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                            else                         { }
                        };
                        1;
                        }
                    }
            );
            }
    );
    return ($MATCH);
}

sub exp_stmts2 {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            do {
                (   do {
                        my $m2 = $grammar->exp( $str, $MATCH->to() );
                        do {
                            if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'exp'} = $m2; 1 }
                            else     {0}
                            }
                        }
                        && do {
                        my $pos1 = $MATCH->to();
                        (   do {
                                (   do {
                                        my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                        do {
                                            if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                            else     {0}
                                            }
                                        }
                                        && (
                                        do {
                                            my $m2 = $grammar->exp_stmts( $str, $MATCH->to() );
                                            do {
                                                if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'exp_stmts'} = $m2; 1 }
                                                else     {0}
                                                }
                                        }
                                        && (do {
                                                my $pos1 = $MATCH->to();
                                                (   do {
                                                        do {
                                                            my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                                            do {
                                                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                                else     {0}
                                                                }
                                                            }
                                                        }
                                                        || do {
                                                        $MATCH->to($pos1);
                                                        do {
                                                            my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                            do {
                                                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                                else     {0}
                                                                }
                                                            }
                                                        }
                                                );
                                            }
                                            && do {
                                                my $ret = sub {
                                                    my $List__ = \@_;
                                                    do { [] };
                                                    do { return ( [ ${ $MATCH->{'exp'} }, @{ ${ $MATCH->{'exp_stmts'} } } ] ) };
                                                    '974^213';
                                                    }
                                                    ->();
                                                do {
                                                    if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                                                    else                         { }
                                                };
                                                1;
                                            }
                                        )
                                        )
                                );
                                }
                                || do {
                                $MATCH->to($pos1);
                                (   do {
                                        my $pos1 = $MATCH->to();
                                        (   do {
                                                do {
                                                    my $m2 = $grammar->stmt_sep( $str, $MATCH->to() );
                                                    do {
                                                        if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                        else     {0}
                                                        }
                                                    }
                                                }
                                                || do {
                                                $MATCH->to($pos1);
                                                do {
                                                    my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                    do {
                                                        if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                        else     {0}
                                                        }
                                                    }
                                                }
                                        );
                                        }
                                        && do {
                                        my $ret = sub {
                                            my $List__ = \@_;
                                            do { [] };
                                            do { return ( [ ${ $MATCH->{'exp'} } ] ) };
                                            '974^213';
                                            }
                                            ->();
                                        do {
                                            if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                                            else                         { }
                                        };
                                        1;
                                        }
                                );
                                }
                        );
                        }
                );
                }
            }
    );
    return ($MATCH);
}

1;