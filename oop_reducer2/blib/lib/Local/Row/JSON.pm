package Local::Row::JSON;

use strict;
use warnings;
use utf8;

use JSON::XS; 

use parent qw(Local::Row);

sub JSON{
    my ($self, $name, $json, $field) = @_;
    if ( ref($json) eq 'HASH' ) {
        for ( keys %{$json} ) {
            if ( ref $json->{$_} eq 'HASH' ) {
                $self->JSON($json->{$_});
            }
            else {
                push(@{$field}, $json->{$name}) if ( $json->{$name} );
            }
        }
    }
    elsif ( ref $json eq 'ARRAY' ) {
        for ( @{$json} ) {
            	( ref($_) eq 'HASH' )
            ? 	( $self->JSON($_) )
            : 	( next )
        }
    }
    return
}

sub get {
    my ($self, $name, $default, $field) = (@_, []);
    $self->JSON($name, decode_json($self->{str}), $field);
    if ( @{$field} ) {
        	( scalar @{$field} == 1 )
        ? 	( return $field->[0] )
        : 	( return $field )
    }
    else {
        return $default
    }
}

1;
