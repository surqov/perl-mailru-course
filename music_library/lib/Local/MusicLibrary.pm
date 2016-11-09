package Local::MusicLibrary;

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use Local::MusicLibrary::Filter;
#use Local::MusicLibrary::Printer;

=encoding utf8

=head1 NAME
MusicLibrary

=head1 VERSION
Version 1.01
=cut

our $VERSION = '1.01';

sub music_library {
	my $library = shift;
	my ($options, $filters, $ready_lib) = Local::MusicLibrary::Filter::get_filtered_lib($library);
	#Local::MusicLibrary::Printer::print_table($ready_lib, $filters, $options);
}

1;
