package Local::Source;

use strict;
use warnings;
use utf8;

sub new {
    my ($class, %params) = @_;
    return bless \%params, $class;
}

sub next {
    my $self = shift;
    return $self->{iterable}[$self->{iterator}++] if $self->{iterable}[$self->{iterator}];
    return undef
}

sub reset {
    my $self = shift;
    $self->{iterator} = 0
}

1;
