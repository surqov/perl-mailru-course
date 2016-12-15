package Local::Reducer;

use strict;
use warnings;
use utf8;

sub new {
    my ( $class, %params ) = @_;
    return bless \%params, $class;
}

sub reduce_all {
    my $self          = shift;
    my $reduced_value = $self->{initial_value};
    $self->{source}->reset;
    while ( my $str = $self->{source}->next ) {
        $reduced_value = $self->reduce( $str, $self->{row_class}->new(str => $str), $reduced_value );
    }
    return $self->{reduced} = $reduced_value;
}

sub reduce_n {
    my ($self, $n) = @_;
    my $reduced_value = $self->{initial_value};
    while ( $n-- and my $str = $self->{source}->next ) {
        $reduced_value = $self->reduce( $str, $self->{row_class}->new(str => $str), $reduced_value );
    }
    return $self->{reduced} = $reduced_value;
}

sub reduced {
    my $self = shift;
    return $self->{reduced};
}

1;
