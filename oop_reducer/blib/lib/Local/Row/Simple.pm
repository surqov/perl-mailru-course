package Local::Row::Simple;

use strict;
use warnings;

use parent qw(Local::Row);

sub new {
    my ($class, %params) = @_;
    %params = (
        %params,
        hash => { split(/[,:]/, $params{"str"}) } );
    my $self = $class->SUPER::new(%params);
    return $self;
}

sub get {
    my ($self, $name, $default) = @_;
    if ( $self->{hash}->{$name} ) {
        return $self->{hash}->{$name};
    }
    else {
        return $default
    }
}

1;
