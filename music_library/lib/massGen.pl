#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

our ($band, $year, $album, $track, $format, $sort, $columns) = ""; #arguments;

GetOptions("band=s"     =>  \$band,
           "year=s"     =>  \$year,
           "album=s"    =>  \$album,
           "track=s"    =>  \$track,
           "format=s"   =>  \$format,
           "sort=s"     =>  \$sort,
           "columns=s"  =>  \$columns);

sub massGen{

	our @input = @_;
	our @los;

	sub row_filter( $$ ){
		 my $f = shift;
		 my $string = shift;
	            if ($f == 1) {
			                 for (my $i = 0; $i < scalar @input; $i++) {
								 									 next if (!($input[$i][$f]));
			                             							 if ($string != $input[$i][$f]) {
			                             							 								 delete $input[$i];
			                         																}
			                }
			    }
			    else {
				      for ( my $i = 0; $i < scalar @input; $i++ ) {
						  										next if (!($input[$i][$f]));
					                 							if ($string !~ /$input[$i][$f]/){
					                     															delete $input[$i];
					             																	}
					  }
				}
	}

	if ($band){row_filter(0, $band)};
	if ($year){row_filter(1, $year)};
	if ($album){row_filter(2, $album)};
	if ($track){row_filter(3, $track)};
	if ($format){row_filter(4, $format)};
	
	for (my $i = 0; $i < scalar @input; $i++) {
		next if (!($input[$i][0]));
		push (@los, $input[$i]);
	}

	my @pos;
	if ((defined($sort)) && ($sort =~ /band/)){@pos = sort { $a->[0] cmp $b->[0] } @los;}
		elsif ((defined($sort)) && ($sort =~ /year/)){@pos = sort { $a->[1] <=> $b->[1] } @los;}
		elsif ((defined($sort)) && ($sort =~ /album/)){@pos = sort { $a->[2] cmp $b->[2] } @los;}
	    elsif ((defined($sort)) && ($sort =~ /track/)){@pos = sort { $a->[3] cmp $b->[3] } @los;}
		elsif ((defined($sort)) && ($sort =~ /format/)){@pos = sort { $a->[4] cmp $b->[4] } @los;}
	else {@pos = @los}
	return ($columns, @pos);
}

1;
