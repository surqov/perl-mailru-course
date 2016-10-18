#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my (@nos, @pos) = [];
while (<STDIN>) {
	#my @pos = $_ =~ m{^\.\/(\w+\s+\w+\s+\w+)\/(\d+\s-\s\w+)};
	push(@nos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/]);
	#				0      1      2       3       4
	#             band - year - album - track - format
}
my ($band, $year, $album, $track, $format, $sort, $columns) = "";
for (my $i = 0; $i < scalar @ARGV; $i++){
	if ($ARGV[$i] =~ /--band/){$band = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--year/){$year = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--album/){$album = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--track/){$track = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--format/){$format = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--sort/){$sort = $ARGV[$i+1];}
	if ($ARGV[$i] =~ /--columns/){$columns = $ARGV[$i+1];}
}

if ($sort =~ /band/){@pos = sort { $a->[0] cmp $b->[0] } @nos;}
elsif ($sort =~ /year/){@pos = sort { 0+$a->[1] cmp 0+$b->[1] } @nos;} 
elsif ($sort =~ /album/){@pos = sort { $a->[2] cmp $b->[2] } @nos;} 
elsif ($sort =~ /track/){@pos = sort { $a->[3] cmp $b->[3] } @nos;} 
elsif ($sort =~ /format/){@pos = sort { $a->[4] cmp $b->[4] } @nos;} 
else {@pos = @nos}

@nos = @pos;

for (my $i = 0; $i < scalar @pos; $i++){
	for (my $b = 0; $b < 4; $b++){
		
	}
}


sub max_length($) {
				my $a = shift;

				my $length = 0;
				for (my $i = 1; $i < scalar @pos; $i++){
					my $len = length $pos[$i][$a];
					if ($len > $length) { $length = $len}
				}
				return $length;

}

my $sum = max_length(0) + max_length(1) + max_length(2) + max_length(3) + max_length(4) + 13;

sub normal_print(){
	my $str = "";
	for (my $i = 0; $i <= $sum; $i++){
		$str .= '-';	
	}
	return $str;
}

print '/'.normal_print.'\\'."\n";

my @los = @pos;
			for (my $g = 1; $g < scalar @pos; $g++){
				for (my $stolb = 0; $stolb <=4; $stolb++){
					printf("|");
					my $float = '%'.(max_length($stolb)+1).'s';
					printf("$float", "$los[$g][$stolb]");
					print " ";
					}
			print "|\n";
			my $str2 = normal_print;
			my $sh = 0;
						for (my $i = 0; $i <= 3; $i++){	
												$sh += max_length($i)+2;      #dobavlenie +
												substr($str2, $sh+$i,1) = "+";
											}
			if ($g < ((scalar @pos)-1)){ print '|'.$str2.'|'."\n";}
			
		}

print '\\'.normal_print.'/'."\n";

