package Local::MusicLibrary::Printer;

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use Exporter 'import';
our @EXPORT_OK = qw(out_print);

our @FIELDS;
our %length;

sub get_max_length {
	my @library = @{shift()};
	my %options = %{shift()};	

	@FIELDS = @{$options{'columns'}};
	exit if (scalar @FIELDS == 0);	
	for (@FIELDS) {	$length{$_} = 0; }
	
	for (@library) {
		my %line = %$_;
			for (keys %line) {
				my $key = $_;
				next if (!(grep($_ eq $key, @FIELDS)));
				if ($length{$key} < length $line{$key}) {$length{$key} = length $line{$key}}
			}
	}
}

sub out_print{
	my @library = @{shift()};
	my %filters = %{shift()};
	my %options = %{shift()};

	get_max_length(\@library, \%options);
	my $width = -1;
	for (@FIELDS) {
		my $key = $_;
		$width += 3+$length{$key};
	}
	my $border = "-"x$width;
	
	print "/$border\\\n";
	print join
          	'|'.join('+', map { '-' x ($length{$_} + 2) } @FIELDS)."|\n",
          	map {
            	my $elem = $_;
            	'|'.join('|', map { sprintf " %*s ", $length{$_}, $elem->{$_} } @FIELDS)."|\n"
         	 	} @library;
  print "\\$border/\n";
	
	

}
1;
