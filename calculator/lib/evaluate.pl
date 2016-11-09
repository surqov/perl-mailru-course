=head1 DESCRIPTION
Эта функция должна принять на вход ссылку на массив, который представляет из себя обратную польскую нотацию,
а на выходе вернуть вычисленное выражение
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

sub evaluate {
	my $rpn = shift;
	my @stack;

	my ($operation, $operand, $right, $left);

	for (@$rpn) {
		given($_) { 
	   		when ($_ =~ m{^[*/^+-]$}) {
					$operation = $_ eq '^' ? '**' : $_;
												die "There is no OPERANDS to complete $_" if @stack < 2;
					$right = pop @stack;
				   	$left = pop @stack;
					push @stack, eval "$left$operation$right";
			} 
			when ($_ =~ m{^U([+-])$}) {
												die "There is no OPERANDS to complete $_" if @stack < 1;
					$operand = pop @stack;
					push @stack, eval "$1 $operand";
			} 
			default {
					push @stack, $_;
			}
		}
	}
	return pop @stack;
}

1;
