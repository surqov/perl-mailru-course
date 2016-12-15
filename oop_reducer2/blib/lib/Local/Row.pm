package Local::Row;

use strict;
use warnings;
use utf8;

sub new {
    my ($class, %param) = @_;
    return bless \%param, $class;
}

1;
