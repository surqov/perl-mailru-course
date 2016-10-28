#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: massSort.pl
#
#        USAGE: ./massSort.pl  
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
#      CREATED: 28.10.2016 18:25:17
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

sub massSort($@){
	my $sort = shift;

	print $sort. "asdasdasd\n";
	my @nos = @_;
	my @pos;


	 if ((defined($sort)) && ($sort =~ /band/)){@pos = sort { $a->[0] cmp $b->[0] } @nos;}
		elsif ((defined($sort)) && ($sort =~ /year/)){@pos = sort { $a->[1] <=> $b->[1] } @nos;}
		elsif ((defined($sort)) && ($sort =~ /album/)){@pos = sort { $a->[2] cmp $b->[2] } @nos;}
	    elsif ((defined($sort)) && ($sort =~ /track/)){@pos = sort { $a->[3] cmp $b->[3] } @nos;}
		elsif ((defined($sort)) && ($sort =~ /format/)){@pos = sort { $a->[4] cmp $b->[4] } @nos;}
	 else {@pos = @nos}
	return @pos;
}

1;
