#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use FindBin;
use Getopt::Long;

require "$FindBin::Bin/../lib/columnEq.pl"; my $columnIND = columnEq(); #проверка наличия аргумента --columns в @ARGV
require "$FindBin::Bin/../lib/spaceFo.pl"; #убирает пробелы в названиях исполнителей и сравнивает последнюю строку со всеми
require "$FindBin::Bin/../lib/massGen.pl"; #генерация рабочего массива согласно атрибутам
require "$FindBin::Bin/../lib/hashGen.pl"; #генерация рабочего хэша
require "$FindBin::Bin/../lib/hashPrint.pl"; #принт по заданному шаблону

my @pos;
while (<STDIN>) {   #разбиваем входную строку на характерные ячейки по /
	    if ($_) {push(@pos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/])};
     				#               0      1      2       3       4
     				#             band - year - album - track - format
		@pos = spaceFo(@pos);
}
my ($columns, @nos) = massGen(@pos); #cоставляем строки по аргументам, удаляя лишнее, и записываем их в массив, +сортировка
my %hash = hashGen(@nos); #составляем хэш, в котором у каждого ключа последний элемент массива - длина максимальной строки
if ((!($columnIND)) and (!($columns))) {$columns = "band,year,album,track,format";} #дефолтное значение, если не задан --columns
hashPrint(\%hash, scalar @nos, $columns); #выводим на печать по заданному аргументами шаблону
