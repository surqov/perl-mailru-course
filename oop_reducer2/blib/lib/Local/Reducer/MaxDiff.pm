package Local::Reducer::MaxDiff;

use strict;
use warnings;
use utf8;

use parent qw(Local::Reducer);

sub reduce {
    my ($self, $str, $row, $value) = (@_, 0);

    my ($top, $bottom) = ( $row->get($self->{top}, undef), $row->get($self->{bottom}, undef) );#

    if ($value < abs($top - $bottom)) {return $value = abs($top - $bottom)};
}

1;
