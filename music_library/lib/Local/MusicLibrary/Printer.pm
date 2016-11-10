package Local::MusicLibrary::Printer;

use strict;
use warnings;
use utf8;

use DDP;
use Data::Dumper;

use Exporter 'import';
our @EXPORT_OK = qw(make_columns);

our @FIELDS = qw(band year album track format);

sub make_columns {
    my ($lib, $options) = @_;

	my %hash = %{$options};
	my @arr = @{$hash{'columns'}};
	p @arr;



	#foreach (@{$library}) {
	#   my $entry = $_;
	#   foreach (keys %{$_}) {
	#       if ( length(${$entry}{$_}) > ${$columns}{$_}) {
	#           ${$columns}{$_} = length(${$entry}{$_});
	#       }
	#   }
    
	#return $library
}

1;
=comment
sub printer {
    my ($table, $colwidth, $fields) = (@_);

    unless (@{$table}) {
        return
    };

    my ($copy_array, $separator) = ([ @{$fields} ], "|");
    my $defises = "-"x(sum(map { $_ = %{$colwidth}{$_} } @{$copy_array}) +
            ($#{$copy_array} + 1) * 3 - 1);
    $separator .= "-"x${$colwidth}{$_}."--+" foreach (@{$fields});
    substr($separator, -1, 1, "|\n");

    my $out = "/".$defises."\\\n";
    foreach my $line (@{$table}) {
        $out .= sprintf("| %${$colwidth}{$_}s ", ${$line}{$_}) foreach (@{$fields});
        $out .= "|\n".$separator;
    }
    substr($out, rindex($out,$separator), length($out), "");

    print($out .= ( "\\".$defises."/\n" ));
}

sub print_table {
    my ($library, $filters, $options) = @_;

    my %colwidth;
    $colwidth{$_} = 0 for keys %{${$library}[0]};

    printer( make_columns,
            \%colwidth,
            ${$options}{$OPT_COLUMNS});
}

1;
