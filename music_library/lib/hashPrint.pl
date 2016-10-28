#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: hashPrint.pl
#
#        USAGE: ./hashPrint.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 28.10.2016 23:11:19
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

sub hashPrint {
	my %hash = %{shift()};
	my $count = shift;
	my $column = shift;
	
	#найдем ширину таблицы в зависимости от имен столбцов
	my $sum = 0;
	while($column){
		if ($column =~ s/(band,\s)|(band$)//) {$sum += $hash{band}[$count]}
		if ($column =~ s/(year,\s)|(year$)//) {$sum += $hash{year}[$count]}
		if ($column =~ s/(album,\s)|(album$)//) {$sum += $hash{album}[$count]}
		if ($column =~ s/(track,\s)|(track$)//) {$sum += $hash{track}[$count]}
		if ($column =~ s/(format,\s)|(format$)//) {$sum += $hash{format}[$count]}
	}
print $sum;	
}
	
1;
