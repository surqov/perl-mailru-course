#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use Data::Dumper;

#$| = 1;

my (@nos, @pos) = [];
while (<STDIN>) {
	#my @pos = $_ =~ m{^\.\/(\w+\s+\w+\s+\w+)\/(\d+\s-\s\w+)};
	push(@nos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/]);
	#				0      1      2       3       4
	#             band - year - album - track - format
	}
		my ($band, $year, $album, $track, $format, $sort, $columns) = ""; #arguments;
		my $scr = ""; #string for arguments;
		for (my $i = 0; $i < scalar @ARGV; $i++){
			$scr .= $ARGV[$i]." ";
	}
			if ($scr =~ /--band\s(.+?)($|(\s--))/) {print "LOL\n";$band = $1;}
		    if ($scr =~ /--year\s(.+?)($|(\s--))/) {$year = $1;}
			if ($scr =~ /--album\s(.+?)($|(\s--))/) {$album = $1;}
			if ($scr =~ /--track\s(.+?)($|(\s--))/) {$track = $1;}
			if ($scr =~ /--format\s(.+?)($|(\s--))/) {$format = $1;}
			if ($scr =~ /--sort\s(.+?)($|(\s--))/) {$sort = $1;}
			if ($scr =~ /--columns\s(.+?)($|(\s--))/) {$columns = $1};

if ($sort =~ /band/){@pos = sort { $a->[0] cmp $b->[0] } @nos;}
elsif ($sort =~ /year/){@pos = sort { 0+$a->[1] cmp 0+$b->[1] } @nos;} 
elsif ($sort =~ /album/){@pos = sort { $a->[2] cmp $b->[2] } @nos;} 
elsif ($sort =~ /track/){@pos = sort { $a->[3] cmp $b->[3] } @nos;} 
elsif ($sort =~ /format/){@pos = sort { $a->[4] cmp $b->[4] } @nos;} 
else {@pos = @nos}

my @nos = [];

	sub row_filter($$){
		my $f = shift;
		my $string = shift;
		
		print $f."\n";
		print $string." \n";
		print $pos[0][$f]."\n";
		printf($string =~ /$pos[0][$f]/);

		for (my $i = 0; $i < scalar @pos; $i++){
			if ( $string =~ $pos[$i][$f] ){
					for (my $b = 0; $b <= 4; $b++){
						$nos[$i][$b] = $pos[$i][$b]; print $nos[$i][$b]."\n";				
				}
			}
		}
	}

if ($band){row_filter(0, $band)};
if ($year){row_filter(1, $year)};
if ($album){row_filter(2, $album)};
if ($track){row_filter(3, $track)};
if ($format){row_filter(4, $format)};

print Dumper(@pos);
print Dumper(@nos);

@pos = @nos;

sub max_length($) {
				my $a = shift;
				my $len = 1;
				my $length = 0;
				for (my $i = 1; $i < scalar @pos; $i++){
					$len = length $pos[$i][$a];
					if (($len) > ($length)) { $length = $len}
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
