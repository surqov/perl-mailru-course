package Local::Source::Array;

use strict;
use warnings;
use utf8;

use parent qw(Local::Source);

sub new {
    my ($class, %params) = @_;
    %params = (
        		'iterable' 		=> $params{array},
        		'iterator' 		=> 0,
        		'full_iterate' 	=> 0);
    my $self = $class->SUPER::new(%params);
    return $self;
}

1;
