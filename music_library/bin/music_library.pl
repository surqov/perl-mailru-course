#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: music_library.pl
#
#        USAGE: ./music_library.pl  
#
#  DESCRIPTION: MUSIK_LIBRARY
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 23.10.2016 15:37:45
#     REVISION: ---
#===============================================================================
package main;

use strict;
use warnings;
use utf8;

use FindBin;
use Getopt::Long;
require "$FindBin::Bin/../lib/massGen.pl"; #генерация рабочего массива согласно атрибутам
require "$FindBin::Bin/../lib/hashGen.pl"; #генерация рабочего хэша
require "$FindBin::Bin/../lib/hashPrint.pl"; #принт по заданному шаблону

my @pos;
while (<STDIN>) {   #разбиваем входную строку на характерные ячейки по /
	    if ($_) {push(@pos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/])};
     				#               0      1      2       3       4
     				#             band - year - album - track - format
}
my @nos = massGen(@pos); #cоставляем строки по аргументам, удаляя лишнее, и записываем их в массив, после чего сортируем
my %hash = hashGen(@nos); #составляем хэш, в котором у каждого ключа последний элемент массива - длина максимальной строки
hashPrint(\%hash, scalar @nos, "band,year,album,track,format"); #выводим на печать по заданному аргументами шаблону 

#Дописать обработку COLUMNS, потому что GetOptions шифтает ARGV, а мне нужно сюда затащить из MassGen это всё 


