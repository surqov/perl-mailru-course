package Local::MusicLibrary::Filter;

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use Getopt::Long;
use Exporter 'import';
our @EXPORT_OK = qw(get_options);

our @FIELDS = (
    'band',
    'year',
    'album',
    'track',
    'format'
);

our @PARAMS = (
    'sort',
    'columns'
);

our $OPT_SORT       = $PARAMS[0];
our $OPT_COLUMNS    = $PARAMS[1];

my %options = ( 'columns' => [ @FIELDS ]);
my %filters = ();

my %ACCEPTABLE_COLUMNS;

@ACCEPTABLE_COLUMNS{$_} = 'exists' for @FIELDS;

sub get_options {

    GetOptions(
       			 \%filters,
        		 "band=s", "year=i", "album=s",
        		 "track=s", "format=s",
        		 "$OPT_SORT=s" => sub {
            							( $ACCEPTABLE_COLUMNS{$_[1]} )
            							? 
										( $options{$_[0]} = $_[1] )
            							: 
										( die("Invalid field in --sort parameter\n") )
        		},

        		"$OPT_COLUMNS=s" => sub {
            							$options{$_[0]} = ();
            							@{$options{$OPT_COLUMNS}} = split(",", $_[1]);

            							foreach (@{$options{$OPT_COLUMNS}}) {
                							if (not $ACCEPTABLE_COLUMNS{$_}) {
                    							die("Invalid fields in --columns parameter.\n")
                							}
            							}
        		}
    ) 
		or die("Can't parse command line arguments\n");
p %filters;
return (\%filters, \%options);
}

1;
