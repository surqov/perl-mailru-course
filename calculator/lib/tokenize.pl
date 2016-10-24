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

	my @source = grep ( !m/^(\s*|)$/, split m{
			            ( 
							(?<!e) [+-]
							|
							[*()/^]
							|
							\s+
						)
			       }x, $expr );
	my @result; #Конечный результат					
	my ($skobka, $operator, $numb) = 0;
    my $pred = ""; #Предыдущий символ
			for (@source) {
        			if ( $_ =~ m/^[-+]$/ and $pred =~ m/^((\(|\s|)|([\+\-\/\*\^\(]))$/ ) { #Унарный оператор
            			push( @result, "U" . $_ );
        	}
        			elsif ($_ =~ m/^\d+$/ ) {  #Число в ДЕСЯТЕРИЧНОЙ ЗАПИСИ
            			$numb++;
            			push( @result, 0 + $_ )
        	}	
        			elsif ( $_ =~ m/^\d*\.?\d+((e?[-+]?\d+)|(\d*))$/ ) { #Число 0e+1
            			$numb++;
            			push( @result,  0 + $_ );
        	}
					else {
            			$operator += ( $_ =~ m/^([\+\-\*\/\^])$/ ? 1 : 0 );
            			$skobka += ( $_ =~ m/^\($/ ? 1 : 0); 
						$skobka -= ( $_ =~ m/^\)$/ ? 1 : 0 );
            			push( @result, $_ );
        	}
       		 		$pred = $_;
    }
    								if ( !$numb ) { die "There is no NUMBEEERS";}
    								if ( $skobka ) {die "There is hmm...";}
    								if ( !($numb == ($operator + 1) ) ) { die "There is something with your count of parameters";}
    return \@result; 
}

1;
