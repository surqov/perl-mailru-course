#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

sub hashPrint {
	my %hash = %{shift()};
	my $count = shift;
	my $column = shift;
	my $temp = $column;
						if (($column !~ /band|year|album|track|format/) or ($column eq '')) {
							return 0;
							die "Bad column format";
						}

	my $count_of_atribut = scalar (split ",", $column);
	
	#найдем ширину таблицы в зависимости от имен столбцов
	my $sum = 0;
	while($column){ #вычисляем общую ширину таблицы и складываем значение в sum
		if ($column =~ s/(band,)|(band$)//) {$sum += 2+$hash{band}[$count]}
		if ($column =~ s/(year,)|(year$)//) {$sum += 2+$hash{year}[$count]}
		if ($column =~ s/(album,)|(album$)//) {$sum += 2+$hash{album}[$count]}
		if ($column =~ s/(track,)|(track$)//) {$sum += 2+$hash{track}[$count]}
		if ($column =~ s/(format,)|(format$)//) {$sum += 2+$hash{format}[$count]}
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
	if ($hash{track}[0]) {print '/' . $lineUP . '\\' . "\n";} #печатаем верхнюю строку(ну, в принципе, она же и нижняя будет)
	$column = $temp;
		for (my $i = 0; $i < $count; $i++){
			print "| ";
				$temp = $column;
					for (my $g = 0; $g < $count_of_atribut; $g++){
					$temp =~ s/(band|year|album|track|format)//;
					$print_format = '%'.($hash{$1}[$count]).'s';
					printf("$print_format", "$hash{$1}[$i]");
					if ($g == $count_of_atribut-1) {print ' |'}
						else { print ' | ';}
					}			
			print "\n";
			next if ($i == $count-1);
			print '|' . $lineBETWEN . "|\n";
		}
	if ($hash{track}[0]){print '\\' . $lineUP . '/' . "\n";}
}
	
1;
