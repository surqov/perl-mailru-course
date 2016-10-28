#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use Data::Dumper;

my $u;
my (@nos, @pos) = [];
while (<STDIN>) {
	#my @pos = $_ =~ m{^\.\/(\w+\s+\w+\s+\w+)\/(\d+\s-\s\w+)};
	if ($_) {push(@nos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/])};
	#				0      1      2       3       4
	#             band - year - album - track - format
	$u++;
	}
if ($u == 1){die "";}
		my ($band, $year, $album, $track, $format, $sort, $columns) = ""; #arguments;
		my $scr = ""; #string for arguments;
		for (my $i = 0; $i < scalar @ARGV; $i++){
			$scr .= $ARGV[$i]." ";
	}
			if ($scr =~ /--band\s(.+?)($|(\s--))/) {$band = $1;}
		    if ($scr =~ /--year\s(.+?)($|(\s--))/) {$year = $1;}
			if ($scr =~ /--album\s(.+?)($|(\s--))/) {$album = $1;}
			if ($scr =~ /--track\s(.+?)($|(\s--))/) {$track = $1;}
			if ($scr =~ /--format\s(.+?)($|(\s--))/) {$format = $1;}
			if ($scr =~ /--sort\s(.+?)($|(\s--))/) {$sort = $1;}
			if ($scr =~ /--columns\s(.+?)\s($|(\s--))/) {$columns = $1};

if ((defined($sort)) && ($sort =~ /band/)){@pos = sort { $a->[0] cmp $b->[0] } @nos;}
elsif ((defined($sort)) && ($sort =~ /year/)){@pos = sort { $a->[1] <=> $b->[1] } @nos;} 
elsif ((defined($sort)) && ($sort =~ /album/)){@pos = sort { $a->[2] cmp $b->[2] } @nos;} 
elsif ((defined($sort)) && ($sort =~ /track/)){@pos = sort { $a->[3] cmp $b->[3] } @nos;} 
elsif ((defined($sort)) && ($sort =~ /format/)){@pos = sort { $a->[4] cmp $b->[4] } @nos;} 
else {@pos = @nos}

my @los;

sub row_filter($$){
		my $f = shift;
		my $string = shift;
			if ($f == 1){
				push (@los, []);
				for (my $q = 0; $q < scalar @pos; $q++){
							if ( $string == $pos[$q][$f] ){
							push(@los, $pos[$q]);
						}
						}
			}
			else {
			for (my $i = -1; $i < scalar @pos; $i++){
				if ( $string =~ /$pos[$i][$f]/ ){
					push(@los, $pos[$i]);				
			}
		}
	}
@pos=@los;	
}
if ($band){row_filter(0, $band)};
if ($year){row_filter(1, $year)};
if ($album){row_filter(2, $album)};
if ($track){row_filter(3, $track)};
if ($format){row_filter(4, $format)};

#################################
my @tos;

sub del_stolb($){
	my $col = shift;
			
	for (my $i = 0; $i < scalar @pos; $i++){
	 	for (my $g = 0; $g < length $pos[$i]; $g++){

			if ((defined($col)) && ($col =~ /band/) && ($g == 0)){$tos[$i][$g] = $pos[$i][$g]}
			if ((defined($col)) && ($col =~ /year/) && ($g == 1)){$tos[$i][$g] = $pos[$i][$g]}
			if ((defined($col)) && ($col =~ /album/) && ($g == 2)){$tos[$i][$g] = $pos[$i][$g]}
			if ((defined($col)) && ($col =~ /track/) && ($g == 3)){$tos[$i][$g] = $pos[$i][$g]}
			if ((defined($col)) && ($col =~ /format/) && ($g == 4)){$tos[$i][$g] = $pos[$i][$g]}
			else {next}

		}
	} 
@pos = @tos;
}
if ($columns) {del_stolb($columns)};
#print Dumper(@pos);
#################################

my $len = 0;
sub max_length($) {
				my $a = shift;
			
				my $length = 0;
				for (my $i = 1; $i < scalar @pos; $i++){
										$len = length $pos[$i][$a];
					if (($len) > ($length)) { $length = $len}
				}
				return $length;

}

my $p = 0;
my $sum;
if ($columns){
	if ((defined($columns)) && ($columns =~ /band/)){$p++}
	if ((defined($columns)) && ($columns =~ /year/)){$p++}
	if ((defined($columns)) && ($columns =~ /album/)){$p++}
	if ((defined($columns)) && ($columns =~ /track/)){$p++}
	if ((defined($columns)) && ($columns =~ /format/)){$p++}

	if ($p == 1) {$sum = max_length(0) + 2}
	if ($p == 2) {$sum = max_length(0) + max_length(1) + 4}
	if ($p == 3) {$sum = max_length(0) + max_length(1) + max_length(2) + 8;}
	if ($p == 4) {$sum = max_length(0) + max_length(1) + max_length(2) + max_length(3) + 16;}
	if ($p == 5) {$sum = max_length(0) + max_length(1) + max_length(2) + max_length(3) + max_length(4) + 13;}
}
else {$sum = max_length(0) + max_length(1) + max_length(2) + max_length(3) + max_length(4) + 13; $p = 4;}

sub normal_print(){
	my $str = "";
	for (my $i = 0; $i <= $sum; $i++){
		$str .= '-';	
	}
	return $str;
}

print '/'.normal_print.'\\'."\n";

my @gos = @pos;
			for (my $g = 1; $g < scalar @pos; $g++){
				for (my $stolb = 0; $stolb <=4; $stolb++){
					if (length $pos[$g][$stolb] == 0){next}					
					printf("|");
					my $float = '%'.(max_length($stolb)+1).'s';
					printf("$float", "$gos[$g][$stolb]");
					print " ";
					}
			print "|\n";
			my $str2 = normal_print;
			my $sh = 0;
						for (my $i = 0; $i <= $p-2; $i++){	
												$sh += max_length($i)+2;      #dobavlenie +
												if ($i == 2){substr($str2, $sh+$i+1,1) = "+";}
												elsif ($i==1) {substr($str2, $sh+$i-3,1) = "+";}
												else {substr($str2, $sh+$i,1) = "+";}

											}

			if ($g < ((scalar @pos)-1)){ print '|'.$str2.'|'."\n";}
			
		}

print '\\'.normal_print.'/'."\n";

#print Dumper(@pos);
#print Dumper(@nos);

