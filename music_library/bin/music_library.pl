#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: music_library.pl
#
#        USAGE: ./music_library.pl  
#
#  DESCRIPTION: MUSIK_LIBRARY
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 23.10.2016 15:37:45
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Local::MyLibrary qw(music_lib);

Local::MyLibrary::music_lib();
