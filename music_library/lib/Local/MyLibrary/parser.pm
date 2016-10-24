package Local::MyLib::Parser;

use strict;
use warnings;

use Data::Dumper;

our @pos;
while (<STDIN>) {
		if ($_) {push(@pos, [$_ =~ m/.\/(.*)\/(\d+)\s-\s(.*)\/(.*)\.(.*)$/])};
		#				0      1      2       3       4
		#             band - year - album - track - format
}
