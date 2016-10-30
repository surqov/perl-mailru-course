#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

sub columnEq{
	for (@ARGV){
		if ($_ =~ /--columns/){return 1}
	}
}

1;
