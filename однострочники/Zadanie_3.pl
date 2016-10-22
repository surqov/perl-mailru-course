#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: Zadanie_3.pl
#
#        USAGE: ./Zadanie_3.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: surk0ff 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 20.10.2016 12:40:34
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use DDP;
use Data::Dumper;
 
my @F;
while (<>) {
	chomp $_;
	push @F, [split ";"];
}
	print Dumper(@F);
	p @F;
