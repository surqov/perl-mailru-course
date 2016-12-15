#
#===============================================================================
#
#         FILE: JSONParser.pm
#
#  DESCRIPTION:
#
#        FILES: --
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03.12.2016 20:50:16
#     REVISION: ---
#===============================================================================
package Local::JSONParser;

use strict;
use warnings;
use utf8;

use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

sub parse_json 
{
	my $source = \$_[0];
    for ($$source){
        if 		(/\G\s*(-?\d+[\.eE]?\d*[-+]*\d*)/gc) { return $1; }
		elsif	(/\G\s*\"([^"\\]*)/gc) {
            my $substr = $1;
           	while(!(/\G\"/gc)) {
 	            if 		(/\G\\n/gc) 			{$substr = $substr . chr(10);}
 				elsif 	(/\G\\\"/gc) 			{$substr = $substr . chr(34);}
 				elsif 	(/\G\\u(\w{3,4})/gc) 	{$substr = $substr . chr(hex($1));}
 				elsif 	(/\G\\t/gc) 			{$substr = $substr . chr(9);}
 				elsif 	(/\G\\/gc) 				{die "Invalid JSON sequence!";}
 				else 							{/\G([^"\\]*)/gc; $substr = $substr . $1;}
           }
        return $substr;
        }
        elsif(/\G\s*\[/gc) {
            my $i = 0;
            my @arr;
            while (!(/\G\s*\]/gc)) {
                	$arr[$i] = parse_json($$source);
                	$i++;
                	/\G\s*,/gc;}
            return \@arr;
        }
        elsif (/\G\s*\{/gc) {
            my %subhash;
            while(!(/\G\s*\}/gc)) {
                if (/\G\s*\"([^"]*)\"\s*:/gc) {
                    my $key = $1;
                    $subhash{$key} = parse_json($$source);
                    /\G\s*,/gc;
                }
                else { die "err";}
            }
        return \%subhash;
        }
        else { die "err"; }
    }
}
1;
