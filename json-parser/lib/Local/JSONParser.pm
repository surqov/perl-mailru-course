package Local::JSONParser v1.0.0;

use strict;
use warnings;
use utf8;

use DDP;
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

sub parse_json {
	my $source = shift;
	my %hash;

	for ($source){
		my $line = $_;
			while ($line =~ /"(\w+)":/g) { 	
				my $key = $1;

				$line =~ /\w/g;
				if 	($line =~ /$key":\s"(.+?)"/) {
		  				my $substr = $1;

						$hash{$key} = $substr;} 	#строка
				elsif 	($line =~ /$key":\s(-?\d+[\.eE]?\d*[-+]*\d*)?/) {
						$hash{$key} = $1} 			#число
				if 	($line =~ /$key":\s(\[.*?\])/) {
						my $substr = $1;
							
						$hash{$key} = parse_json($substr);}
				elsif   ($line =~ /$key":\s\{(.*?)\}/) {
							my $substr = $1;
							$hash{$key} = parse_json($substr);}	
					}								
				}

	return \%hash;
	}	
}

1;
