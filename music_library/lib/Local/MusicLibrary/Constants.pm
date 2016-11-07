package  Local::MusicLibrary::Constants;

use strict;
use warnings;

our @FIELDS = (
    'band',
    'year',
    'album',
    'track',
    'format'
);

our @OPTFIELDS = (
    'sort',
    'columns'
);
our $OPT_SORT       = $OPTFIELDS[0];
our $OPT_COLUMNS    = $OPTFIELDS[1];

1;
