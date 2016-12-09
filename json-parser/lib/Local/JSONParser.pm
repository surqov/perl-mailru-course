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

sub parse_json {
	my $source = shift;

	if ((substr $source, 0, 1) eq "[") {
		$source =~ s/\[\s//g;
		$source =~ s/\s\]//g;
		$source =~ s/[\[\]]//g;
		$source =~ s/,\s/,/g;
		
		my @arr = split (",", $source);
		
		for (my $i = 0; $i < scalar @arr; $i++) {
			$arr[$i] =~ s/[\"\']//g;
			if ($arr[$i] =~ /(\{.*?\})/) { $arr[$i] = parse_json($1);}
		}	
	return \@arr;
	}
	else {

			my %hash;

			for ($source){
				my $line = $_;
				
					while ($line =~ /"(\w+)":/gs) { 	
							my $key = $1;
							$line =~ /\w/g;
						
							if 	($line =~ /\n?"$key":\n?\s?\n?"(.+?)"/s) { #строка
			   					my $substr = $1;

								$hash{$key} = $substr;} 	
							elsif 	($line =~ /\n?"$key":\n?\s?\n?(-?\d+[\.eE]?\d*[-+]*\d*)?/s) { #число						
								$hash{$key} = $1} 			
							if 	($line =~ /\n?"$key":\n?\s?\n?(\[.*?\])/s) { #массив
								my $substr = $1;
							
								$hash{$key} = parse_json($substr);}
							elsif   ($line =~ /\n?"$key":\n?\s?\n?\{(.*?)\}/s) { #хэш
								my $substr = $1;
								$hash{$key} = parse_json($substr);}	
					}
			}					
	return \%hash;
	
	}
}
1;

