#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

sub spaceFo{
	my @input = @_;
	my @input2 = @input;
	my @string = pop @input2;
	my $last =  $string[0][0];
	my $track = $string[0][3];
	$last =~ s/\s|\s+//ig;
	for (my $i = 0; $i < scalar @input - 1; $i++){
		my $input_string = $input[$i][0];
	    $input_string =~ s/\s|\s+//ig;
		if (($last eq $input_string) and ($track eq $input[$i][3])){
			pop @input;
			goto ATTEMPT1;
		}
	}
	ATTEMPT1:
	return @input;
}

1;
