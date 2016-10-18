package Local::JSONParser;

use strict;
use warnings;
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

sub parse_json {
	my $source = shift;
	
	use JSON::XS;
	
	for ($source) {
			  while (pos < length) {
						    if (/\G(\d+)/) {
								      say "got digits $1";    }
						    elsif (/\G(\D+)/) {      say "got non-digits $1";    }
						    else {      die "Bad sequence";    }  } }
	
	return {};
}

1;
