#
#===============================================================================
#
#         FILE: JSONParser.pm
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03.12.2016 20:50:16
#     REVISION: ---
#===============================================================================

package Local::JSONParser v1.0.0;

use strict;
use warnings;
use utf8;

use DDP;
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

sub clear_string{
	my $string = shift;
my $substr;
	if ($string =~ /\\n/gc) {}
	if ($string =~ /\\/gc) {}


	while(!(/\G\"/gc)) {
		  if (/\G\\n/gc) {$substr = $substr . chr(10);}
		                  elsif (/\G\\\"/gc) {$substr = $substr . chr(34);}
		                  elsif (/\G\\u(\w{3,4})/gc) {$substr = $substr . chr(hex($1));}
		                  elsif (/\G\\t/gc) {$substr = $substr . chr(9);}
		                 elsif (/\G\\/gc) {die "Invalid JSON sequence!";}
		                 else {
		                     /\G([^"\\]*)/gc;
		                     $substr = $substr . $1;
		                 }
		             }
		             return $substr;

			  }

sub parse_json {
	my $source = shift;
	
	my %hash;
	my $first = substr $source, 0, 1;
	if ($first eq '[') {
			$source =~ /\[(.*?)\]/gc;
			my $get_array = $1;
			my @arr = split(/,/, $get_array);
			return \@arr;	
	}
	else {		for ($source){
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

