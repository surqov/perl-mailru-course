#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: hashGen.pl
#
#        USAGE: ./hashGen.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 28.10.2016 21:11:48
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

sub hashGen {
	our @input = @_;
	our %new = (
				band 	=> [],
			    year 	=> [],
				album 	=> [],
				track 	=> [],
				format 	=> []);	
			
	for (my $i = 0; $i < scalar @input; $i++){
		$new{band}[$i] = $input[$i][0];
		$new{year}[$i] = $input[$i][1];
		$new{album}[$i] = $input[$i][2];
		$new{track}[$i] = $input[$i][3];
		$new{format}[$i] = $input[$i][4];
	}

	sub maxLength($){
		my $a = shift;
		my $length = 0;
		
		my $max_length = 0;
		for (my $i = 0; $i < scalar @input; $i++) {
			my $l = length $new{$a}[$i];
			if ($l > $max_length) {$max_length = $l;}
		}	
		$new{$a}[(scalar @input)] = $max_length;
	}

maxLength("band");
maxLength("year");
maxLength("album");
maxLength("track");
maxLength("format");

return %new;}

1;
