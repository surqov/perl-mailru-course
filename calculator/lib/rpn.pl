=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, содержащий обратную польскую нотацию
Один элемент массива - это число или арифметическая операция
В случае ошибки функция должна вызывать die с сообщением об ошибке

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
use FindBin;
require "$FindBin::Bin/../lib/tokenize.pl";

sub rpn {
	my $expr = shift;
	my $source = tokenize($expr);
	
	my @stack; #стэк, куда полетят токены
	my @rpn; 

	my %prioritet = (
						'U-' 	=> 		4,
						'U+' 	=> 		4,
						'^'  	=> 		4,
						'*'  	=> 		3,
						'/'  	=> 		3,
						'+'  	=> 		2,
						'-'  	=> 		2,
						'('  	=> 		1,
				    	')'  	=> 		1);

	for (@$source) {
			given ($_) {
						when ($_ =~ /^\d*\.?\d*(?:e[+-]?\d+)?$/) {
																	push @rpn, '' . $_;
						}
						when ($_ eq "(") {
										push @stack, '(';
						}
						when ($_ eq ")") {
										while ($stack[-1] ne '(') {
																	push @rpn, '' . pop @stack;
										}	
						pop @stack;
						}
						when (m{^(?:U[+-]|[*/^+-])$}) {
							if ($_ =~ /^(?:U[+-]|\^)/) {
								while (@stack && $prioritet{$_} < $prioritet{$stack[-1]}) {
																							push @rpn, pop @stack;
								}
							} 
							else {
								while (@stack && $prioritet{$_} <= $prioritet{$stack[-1]}) {
																							push @rpn, pop @stack;
								}
							}
							push @stack, '' . $_;
						}
				default {
					die "Don't know what does it mean - $_";
				}
			}
		}
		push @rpn, reverse @stack;

return \@rpn;
}

1;
