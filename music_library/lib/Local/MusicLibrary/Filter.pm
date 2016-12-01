package Local::MusicLibrary::Filter;

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use Getopt::Long;
use Exporter 'import';
our @EXPORT_OK = qw(get_options);

our @FIELDS = qw(band year album track format);

our %options = ( 'columns' => [ @FIELDS ]);
our %filters = ();

sub get_options {
    GetOptions(
       			 \%filters,
        		 "band=s",
				 "year=i",
				 "album=s",
        		 "track=s",
				 "format=s",
        		 "sort=s" => sub { 		if ( grep { $_[1] eq $_ } @FIELDS) {
					 						$options{"sort"} = $_[1]; }	
										else { die ("Invalid field in --sort\n"); }
        		 },
        		"columns=s" => sub {	@{$options{"columns"}} = split(",", $_[1]);
										for (@{$options{"columns"}}) {
											my $temp = $_;
											if ( !grep { $temp eq $_} @FIELDS) { 
												die ("Invalid fields in --columns\n"); }
										}
            	}
    ) 
	or die("Error with parsing arguments\n"); 
}

sub sort_library {
	my $lib_to_sort = shift;

	if ($options{"sort"}) {
		my $sort_option = $options{"sort"};
			if ($sort_option eq "year") {
				@$lib_to_sort = sort { $a->{$sort_option} <=> $b->{$sort_option} } @$lib_to_sort;
  			}
			else  {
    			@$lib_to_sort = sort { $a->{$sort_option} cmp $b->{$sort_option} } @$lib_to_sort;
  			}
	}
	return \@$lib_to_sort;
}

sub filter_library {
    my $lib_to_filter = shift;
	my @arr = @$lib_to_filter;
	my @clear;

	for my $key (keys %filters){
		my $i =0;
		for my $line (@$lib_to_filter) {
				if ($key eq 'year') {
						if ($filters{$key} != $line->{$key}) {delete $arr[$i]}
				}
				else {
						if ($filters{$key} ne $line->{$key}) {delete $arr[$i]}
				}
			$i++;
		}
	}
	for (my $i = 0; $i < scalar @arr; $i++){ if ($arr[$i]) {push (@clear, $arr[$i])}};
	
	return \@clear;
}
sub get_filtered_lib{
	my $lib = shift;
	
	get_options();
	return (\%options, \%filters, sort_library(filter_library($lib)));
}

1;
