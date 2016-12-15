package Local::Reducer::Sum;

use strict;
use warnings;
use utf8;

use parent qw(Local::Reducer);

sub reduce {
    my ($self, $str, $row, $value) = @_;
    return $value += $row->get($self->{field}, undef);
}

1;
