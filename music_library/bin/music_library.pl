#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Local::MusicLibrary qw(music_library);

my @library;
while (<STDIN>) {
    	  		(m/
            	^\.\/
            	(?<band>[^\/]+)\/
            	(?<year>\d+)\s[-]\s
				(?<album>[^\/]+)\/
           	   	(?<track>[^\/]+)[\.]
				(?<format>\w+)\n?$
            	/x)
		   		? ( push(@library, {%+}) )
		        : ( die "Invalid input" )
}
Local::MusicLibrary::music_library(\@library);
