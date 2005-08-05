# my $x = ...
package PIL::PPad;

use warnings;
use strict;

sub fixup {
  my $self = shift;

  die unless @$self == 3;
  die unless $self->[0]->isa("PIL::SMy");
  die unless ref $self->[1] eq "ARRAY";
  die unless $self->[2]->isa("PIL::PStmts");

  if($PIL::IN_SUBLIKE) {
    return bless [
      $self->[0],
      [map {{ fixed => $_->[0], user => $_->[0] }} @{ $self->[1] }],
      $self->[2]->fixup,
    ] => "PIL::PPad";
  }

  my $scopeid = $PIL::CUR_LEXSCOPE_ID++;
  my $pad     = {
    map {
      push @PIL::ALL_LEXICALS, "$_->[0]_${scopeid}_$PIL::LEXSCOPE_PREFIX";
      ($_->[0] => "$_->[0]_${scopeid}_$PIL::LEXSCOPE_PREFIX");
    } @{ $self->[1] }
  };

  local @PIL::CUR_LEXSCOPES = (@PIL::CUR_LEXSCOPES, $pad);

  return bless [
    $self->[0],
    [ map {{
      fixed => "$_->[0]_${scopeid}_$PIL::LEXSCOPE_PREFIX",
      user  => $_->[0],
    }} @{ $self->[1] } ],
    $self->[2]->fixup,
  ] => "PIL::PPad";
}

sub as_js {
  my $self = shift;

  push @PIL::VARS_TO_BACKUP, map { $_->{fixed} } @{ $self->[1] }
    unless $PIL::IN_SUBLIKE;

  # Emit appropriate foo = new PIL2JS.Box(undefined) statements.
  local $_;
  my $decl = $PIL::IN_SUBLIKE ? "var " : "";
  return
    join("; ", map {
      sprintf "%s%s = %s; pad[%s] = %s",
        $PIL::IN_SUBLIKE ? "var " : "",
        PIL::name_mangle($_->{fixed}),
        PIL::undef_of($_->{fixed}),
        PIL::doublequote($_->{user}),
        PIL::name_mangle($_->{fixed});
    } @{ $self->[1] }) .
    ";\n" .
    $self->[2]->as_js;
}

1;
