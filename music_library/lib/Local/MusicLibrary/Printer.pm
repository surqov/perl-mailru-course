package Local::MusicLibrary::Printer;

use strict;
use warnings;
use List::Util qw(sum);
use Scalar::Util qw(looks_like_number);
use Local::MusicLibrary::Constants;
use Exporter 'import';
our @EXPORT_OK = qw(print_table);

# DEBUG
use DDP;

our @OPTFIELDS      = @Local::MusicLibrary::Constants::OPTFIELDS;
our $OPT_SORT       = $Local::MusicLibrary::Constants::OPT_SORT;
our $OPT_COLUMNS    = $Local::MusicLibrary::Constants::OPT_COLUMNS;

sub filter_library {
    my ($library, $filters) = @_;

    my $temp = [ grep {
            my $temp = $_;
            grep {
                ( looks_like_number ${$filters}{$_} )
                ? ( ${$temp}{$_} == ${$filters}{$_} )
                : ( ${$temp}{$_} eq ${$filters}{$_} )
            } keys %{$filters};
        } @{$library} ];

    ( @{$temp} || %{$filters} ) ? ( return $temp ) : ( return $library )
}

sub sort_library {
    my ($library, $options) = @_;

    if (${$options}{$OPT_SORT}) {
            if ( looks_like_number ${@{$library}[0]}{${$options}{$OPT_SORT}} ) {
                @{$library} = sort {
                    ${$a}{${$options}{$OPT_SORT}} <=> ${$b}{${$options}{$OPT_SORT}}
                } @{$library}
            }
            else {
                @{$library} = sort {
                    ${$a}{${$options}{$OPT_SORT}} cmp ${$b}{${$options}{$OPT_SORT}}
                } @{$library}
            }
    }

    return $library;
}

sub make_columns {
    my ($library, $columns) = @_;

    foreach (@{$library}) {
        my $entry = $_;
        foreach (keys %{$_}) {
            if ( length(${$entry}{$_}) > ${$columns}{$_}) {
                ${$columns}{$_} = length(${$entry}{$_});
            }
        }
    }

    return $library
}

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

    unless ( @{${$options}{$OPT_COLUMNS}} ) {
        return
    }

    my %colwidth;
    $colwidth{$_} = 0 for keys %{${$library}[0]};

    printer( make_columns( sort_library( filter_library(
                        $library, $filters),
                    $options),
                \%colwidth),
            \%colwidth,
            ${$options}{$OPT_COLUMNS});
}

1;
