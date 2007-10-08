package KindaPerl6::Runtime::Perl5::DispatchSugar;
use strict;
use warnings;

sub import {
    my $caller = caller;

    no strict 'refs';
    *{"$caller\::sugar"} = \&sugar;
}

sub sugar($) {
    my $ref = shift;
    bless($ref,"KindaPerl6::Runtime::Perl5::DispatchSugar::Dispatch");
    return $ref;
}
sub sugar_off {
    no warnings 'redefine';
    *KindaPerl6::Runtime::Perl5::DispatchSugar::Dispatch::AUTOLOAD = sub {die "dispatch sugar turned off"};
}
package KindaPerl6::Runtime::Perl5::DispatchSugar::Dispatch;
sub AUTOLOAD {
    my ($package,) = caller();
    #warn(join ("|",caller(),"\n")) if $package ne 'KindaPerl6::Runtime::Perl5::MOP';
    our $AUTOLOAD;
    $AUTOLOAD =~ s/.*:://;
    my ($self,@args) = @_;
    $self->{_dispatch}($self,$AUTOLOAD,@args);
}
sub DESTROY {
}

1;
