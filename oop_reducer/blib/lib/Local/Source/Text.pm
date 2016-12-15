package Local::Source::Text;

use strict;
use warnings;
use utf8;

use parent qw(Local::Source);

sub new {
    my ($class, %params) = @_;
    my $delim = $params{delimiter} // "\n";
    %params = (
        		'iterable' 		=> [ split(/$delim/, $params{text}) ],
        		'iterator' 		=> 0,
        		'full_iterate' 	=> 0);
    my $self = $class->SUPER::new(%params);
    return $self;
}

1;
