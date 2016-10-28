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
	my $temp = $column;

	my $count_of_atribut = scalar (split ",", $column);
	print $count_of_atribut;
	
	#найдем ширину таблицы в зависимости от имен столбцов
	my $sum = 0;
	while($column){
		if ($column =~ s/(band,\s)|(band$)//) {$sum += 2+$hash{band}[$count]}
		if ($column =~ s/(year,\s)|(year$)//) {$sum += 2+$hash{year}[$count]}
		if ($column =~ s/(album,\s)|(album$)//) {$sum += 2+$hash{album}[$count]}
		if ($column =~ s/(track,\s)|(track$)//) {$sum += 2+$hash{track}[$count]}
		if ($column =~ s/(format,\s)|(format$)//) {$sum += 2+$hash{format}[$count]}
	}

	my $lineUP = '';
	for (my $i = 0; $i < $sum; $i++){
		$lineUP.='-';
	}
	print '/' . $lineUP . '\\' . "\n";

	for (my $i = 0; $i < $count; $i++){
		print "| ";
			for (my $g = 0; $g < $count_of_atribut; $g++){
				$temp =~ /(.*?),/;
				print $temp; # ЗДЕСЬ НУЖНО СДЕЛАТЬ СОХРАНЕНИЕ КАРЕТКИ В ПОИСКЕ ПО РЕГУЛЯРКЕ ЧТОБЫ ПОТОМ ПОДСТАВИТЬ В %hand{$1} и принтануть это дерьмо 
	}
}
}
	
1;
