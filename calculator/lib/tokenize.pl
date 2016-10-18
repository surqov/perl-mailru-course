=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, состоящий из отдельных токенов.
Токен - это отдельная логическая часть выражения: число, скобка или арифметическая операция
В случае ошибки в выражении функция должна вызывать die с сообщением об ошибке

Знаки '-' и '+' в первой позиции, или после другой арифметической операции стоит воспринимать
как унарные и можно записывать как "U-" и "U+"

Стоит заметить, что после унарного оператора нельзя использовать бинарные операторы
Например последовательность 1 + - / 2 невалидна. Бинарный оператор / идёт после использования унарного "-"

=cut

use 5.010;
use strict;
use warnings;
use diagnostics;
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';

sub tokenize {
	chomp(my $expr = shift);
	my @res;

	#my @chunks = split //, $expr;
	#my @chunks = split m{[-=]}, $expr;
	my @chunks = split m{([- /+^*()])}, $expr;
	my $i = 0;
	for my $c (@chunks) {
		$i++;
		next if $c =~ /^\s*$/;
		
			given ($c) {
				when (/^\s*$/){}

				when (/\d/){ push(@res, 0+$c);}
				when ( '.' ){ push(@res, 0+$c);}
				#when (/\w/) {(die "Bad: '$_'";)}
				when ([ '+', '-' ]){ 
									if (($chunks[$i-2] == ' ') and ($chunks[$i] =~ /\d/)) {push (@res, 'U'.$c)}
										else {
												push (@res, $c);}
									}
					
				default {
					die "Bad: '$_'";
				}	
			}	
		}
	return \@res;
}

1;
