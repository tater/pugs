use v6-alpha;

###########################################################################
###########################################################################

#my Hash of QDRDBMS::AST::TypeRef $LITERAL_TYPE_MAP = {
my Hash $LITERAL_TYPE_MAP = {
#    'Bool' => QDRDBMS::AST::TypeRef.new( :text('sys.type.Bool') ),
#    'Str'  => QDRDBMS::AST::TypeRef.new( :text('sys.type.Text') ),
#    'Blob' => QDRDBMS::AST::TypeRef.new( :text('sys.type.Blob') ),
#    'Int'  => QDRDBMS::AST::TypeRef.new( :text('sys.type.Int') ),
#    'Num'  => QDRDBMS::AST::TypeRef.new( :text('sys.type.Num.Rat') ),
};

###########################################################################
###########################################################################

module QDRDBMS::AST-0.0.0 {
    # Note: This given version applies to all of this file's packages.

###########################################################################

sub TypeRef of QDRDBMS::AST::TypeRef (Str :$text!) is export {
    return QDRDBMS::AST::TypeRef.new( :text($text) );
}

sub FuncRef of QDRDBMS::AST::FuncRef (Str :$text!) is export {
    return QDRDBMS::AST::FuncRef.new( :text($text) );
}

sub ProcRef of QDRDBMS::AST::ProcRef (Str :$text!) is export {
    return QDRDBMS::AST::ProcRef.new( :text($text) );
}

sub VarRef of QDRDBMS::AST::VarRef (Str :$text!) is export {
    return QDRDBMS::AST::VarRef.new( :text($text) );
}

sub LitDefExpr of QDRDBMS::AST::LitDefExpr
        (Bool|Str|Blob|Int|Num :$lit!) is export {
    return QDRDBMS::AST::LitDefExpr.new( :lit($lit) );
}

sub VarRefExpr of QDRDBMS::AST::VarRefExpr
        (QDRDBMS::AST::VarRef :$var!) is export {
    return QDRDBMS::AST::VarRefExpr.new( :var($var) );
}

sub FuncInvExpr of QDRDBMS::AST::FuncInvExpr
        (QDRDBMS::AST::FuncRef :$func!, Hash :$func_args!) is export {
    return QDRDBMS::AST::FuncInvExpr.new(
        :func($func), :func_args($func_args) );
}

sub Stmt of QDRDBMS::AST::Stmt () is export {
    return QDRDBMS::AST::Stmt.new();
}

sub Func of QDRDBMS::AST::Func () is export {
    return QDRDBMS::AST::Func.new();
}

sub Proc of QDRDBMS::AST::Proc () is export {
    return QDRDBMS::AST::Proc.new();
}

###########################################################################

} # module QDRDBMS::AST

###########################################################################
###########################################################################

role QDRDBMS::AST::_EntityRef {
    has Str $!text_possrep;

###########################################################################

submethod BUILD (Str :$text!) {

    die q{new(): Bad :$text arg; it is not a valid object}
            ~ q{ of a Str-doing class.}
        if !defined $text or !$text.does(Str);

    $!text_possrep = $text;

    return;
}

###########################################################################

method as_text of Str () {
    return $!text_possrep;
}

###########################################################################

} # role QDRDBMS::AST::_EntityRef

###########################################################################
###########################################################################

class QDRDBMS::AST::TypeRef {
    does QDRDBMS::AST::_EntityRef;
} # class QDRDBMS::AST::TypeRef

###########################################################################
###########################################################################

class QDRDBMS::AST::FuncRef {
    does QDRDBMS::AST::_EntityRef;
} # class QDRDBMS::AST::FuncRef

###########################################################################
###########################################################################

class QDRDBMS::AST::ProcRef {
    does QDRDBMS::AST::_EntityRef;
} # class QDRDBMS::AST::ProcRef

###########################################################################
###########################################################################

class QDRDBMS::AST::VarRef {
    does QDRDBMS::AST::_EntityRef;
} # class QDRDBMS::AST::VarRef

###########################################################################
###########################################################################

class QDRDBMS::AST::LitDefExpr {
#    has Bool|Str|Blob|Int|Num $!lit_val;
    has Scalar $!lit_val;
    has Type                  $!lit_type;

###########################################################################

#submethod BUILD (Bool|Str|Blob|Int|Num :lit($lit_val)!) {
submethod BUILD (Bool|Str|Blob|Int|Num :$lit!) {
    my $lit_val = $lit;

    my $lit_class = $lit_val.WHAT;
    die q{new(): Bad :$lit arg; it is not an object.}
        if !$lit_class;
    if (my $lit_type = $LITERAL_TYPE_MAP.{$lit_class}) {
        $!lit_val  = $lit_val;
        $!lit_type = $lit_type;
    }
    else {
        die q{new(): Bad :$lit arg; it is not an object of a}
            ~ q{ (Bool|Str|Blob|Int|Num) class.};
    }

    return;
}

###########################################################################

} # class QDRDBMS::AST::LitDefExpr

###########################################################################
###########################################################################

class QDRDBMS::AST::VarRefExpr {
    has QDRDBMS::AST::VarRef $!var_name;

###########################################################################

#submethod BUILD (QDRDBMS::AST::VarRef :var($var_ref)!) {
submethod BUILD (QDRDBMS::AST::VarRef :$var!) {
    my $var_ref = $var;

    die q{new(): Bad :$var arg; it is not a valid object}
            ~ q{ of a QDRDBMS::AST::VarRef-doing class.}
        if !defined $var_ref or !$var_ref.does(QDRDBMS::AST::VarRef);
    $!var_name = $var_ref;

    return;
}

###########################################################################

} # class QDRDBMS::AST::VarRefExpr

###########################################################################
###########################################################################

class QDRDBMS::AST::FuncInvExpr {
    has QDRDBMS::AST::FuncRef      $!func_name;
#    has Hash of QDRDBMS::AST::Expr $!func_args;
    has Hash $!func_args;

###########################################################################

#submethod BUILD (QDRDBMS::AST::FuncRef :func($func_ref)!,
#        Hash of QDRDBMS::AST::Expr :$func_args!) {
submethod BUILD (QDRDBMS::AST::FuncRef :$func!,
        Hash :$func_args!) {
    my $func_ref = $func;

    die q{new(): Bad :$func arg; it is not a valid object}
            ~ q{ of a QDRDBMS::AST::FuncRef-doing class.}
        if !defined $func_ref or !$func_ref.does(QDRDBMS::AST::FuncRef);
    $!func_name = $func_ref;
    if (!defined $func_args) {
        $!func_args = {};
    }
    elsif (ref $func_args eq 'ARRAY') {
        # TODO.
    }
    elsif (ref $func_args eq 'HASH') {
        # TODO.
    }
    else {
        die q{new(): Bad :$func_args arg; its not a Array|Hash.};
    }

    return;
}

###########################################################################

} # class QDRDBMS::AST::FuncInvExpr

###########################################################################
###########################################################################

class QDRDBMS::AST::Stmt {



###########################################################################




###########################################################################

} # class QDRDBMS::AST::Stmt

###########################################################################
###########################################################################

class QDRDBMS::AST::Func {



###########################################################################




###########################################################################

} # class QDRDBMS::AST::Func

###########################################################################
###########################################################################

class QDRDBMS::AST::Proc {



###########################################################################




###########################################################################

} # class QDRDBMS::AST::Proc

###########################################################################
###########################################################################

=pod

=encoding utf8

=head1 NAME

QDRDBMS::AST -
Abstract syntax tree for the QDRDBMS D language

=head1 VERSION

This document describes QDRDBMS::AST version 0.0.0.

It also describes the same-number versions of [...].

=head1 SYNOPSIS

I<This documentation is pending.>

=head1 DESCRIPTION

I<This documentation is pending.>

=head1 INTERFACE

The interface of QDRDBMS::AST is a combination of functions, objects, and
overloading.

The usual way that QDRDBMS::AST indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

I<This documentation is pending.>

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 6.x.y that is at least 6.0.0.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<QDRDBMS> for the majority of distribution-internal references, and
L<QDRDBMS::SeeAlso> for the majority of distribution-external references.

=head1 BUGS AND LIMITATIONS

For design simplicity in the short term, all AST arguments that are
applicable must be explicitly defined by the user, even if it might be
reasonable for QDRDBMS to figure out a default value for them, such as
"same as self".  This limitation will probably be removed in the future.
All that said, a few arguments may be exempted from this limitation.

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
