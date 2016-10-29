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
	
	#найдем ширину таблицы в зависимости от имен столбцов
	my $sum = 0;
	while($column){ #вычисляем общую ширину таблицы и складываем значение в sum
		if ($column =~ s/(band,\s)|(band$)//) {$sum += 2+$hash{band}[$count]}
		if ($column =~ s/(year,\s)|(year$)//) {$sum += 2+$hash{year}[$count]}
		if ($column =~ s/(album,\s)|(album$)//) {$sum += 2+$hash{album}[$count]}
		if ($column =~ s/(track,\s)|(track$)//) {$sum += 2+$hash{track}[$count]}
		if ($column =~ s/(format,\s)|(format$)//) {$sum += 2+$hash{format}[$count]}
	}

	$column = $temp;
	my $lineBETWEN = '';
	
	for (my $g = 0; $g < $count_of_atribut; $g++){
					$column =~ s/(band|year|album|track|format)//;
					for (my $i = 0; $i < $hash{$1}[$count]+2; $i++) {
																		$lineBETWEN .= '-';}
													$lineBETWEN .= '+';	
					}	

	chop $lineBETWEN;
	#print $lineBETWEN;



	my $lineUP = '';
	my $print_format = '';
	for (my $i = 0; $i < $sum+$count_of_atribut-1; $i++){  #генерируем строку из '-' равную sum+количество столбцов-1
		$lineUP.='-';
	}
	print '/' . $lineUP . '\\' . "\n"; #печатаем верхнюю строку(ну, в принципе, она же и нижняя будет)
	$column = $temp;
		for (my $i = 0; $i < $count; $i++){
			print "| ";
				$temp = $column;
					for (my $g = 0; $g < $count_of_atribut; $g++){
					$temp =~ s/(band|year|album|track|format)//;
					$print_format = '%'.($hash{$1}[$count]).'s';
					printf("$print_format", "$hash{$1}[$i]");
					print ' | ';
					}			
			print "\n";
			next if ($i == $count-1);
			print '|' . $lineBETWEN . "|\n";
		}
	print '\\' . $lineUP . '/' . "\n";
}
	
1;
