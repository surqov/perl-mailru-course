package Local::JSONParser;

use strict;
use warnings;
use base qw(Exporter);
use Encode qw(encode decode);

our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );

use DDP;

sub parse_json {
    my $source = shift;

    my $unjsoned;
    my $JSON = qr /
        (?: (?&OBJECT) | (?&ARRAY) )
        (?{
            $unjsoned = $^R->[1]
        })
        (?(DEFINE)
            (?<VALUE>
                \s*
                (
                    (?&OBJECT)
                    |
                    (?&ARRAY)
                    |
                    (?&NUMBER)
                    |
                    (?&STRING)
                    |
                    true (?{ [$^R, 1] })
                    |
                    false (?{ [$^R, ""] })
                    |
                    null (?{ [$^R, undef] })
                )
                \s*
            )
            (?<OBJECT>
                \{
                \s*
                (?{
                    [$^R, {}]
                })
                (?:
                    (?&KEYVALUE)                # [[$^R, {}], "string", value]
                    (?{
                        [$^R->[0][0], {$^R->[1] => $^R->[2]}];
                    })
                )?
                (?:
                    \s*,\s*
                    (?&KEYVALUE)                # [$^R, "string", value]
                    (?{
                        $^R->[0][1]{$^R->[1]} = $^R->[2];
                        $^R->[0];
                    })
                )*
                \s*
                \}
            )
            (?<KEYVALUE>
                (?&STRING)                      # [$^R, "string"]
                \s* : \s*
                (?&VALUE)                       # [[$^R, "string"], value]
                (?{
                    [$^R->[0][0], $^R->[0][1], $^R->[1]]
                })
            )
            (?<ARRAY>
                \[
                \s*
                (?{
                    [$^R, []]
                })
                (
                    (?&VALUE)                   # [[$^R, []], value]
                    (?{
                        [$^R->[0][0], [$^R->[1]]]
                    })
                )?
                \s*
                (?:
                    ,\s*
                    (?&VALUE)                   # [$^R, value]
                    (?{
                        push @{$^R->[0][1]}, $^R->[1];
                        $^R->[0];
                    })
                )*
                \s*
                \]
            )
            (?<STRING>
                "
                (
                    (?:
                        \\["\\\/bnfrt]
                        |
                        \\u
                            (
                                (?!
                                    D
                                    [89A-Da-d]
                                    [\dA-Fa-f]{2}
                                )
                                [\dA-Fa-f]{4}
                            )
                        |
                        [^"\\]
                    )*
                )
                "
                (?{
                    my $str = $^N;
                    $str =~ s{
                        \\u
                            (
                                (?!
                                    D
                                    [89A-Da-d]
                                    [\dA-Fa-f]{2}
                                )
                                [\dA-Fa-f]{4}
                            )
                        }
                        {
                            chr(hex($1))
                        }xge or $str = decode("utf-8", $str);
                    my $iter = 8;
                    foreach $_ ('b', 't', 'n', 'f', 'r') {
                        $str =~ s{\\$_}{chr($iter)}ge;
                        ( $iter != 10 ) ? ( $iter += 1 ) : ( $iter += 2 );
                    }
                    $str =~ s{\\\/}(\/)g;
                    $str =~ s{\\\\}(\\)g;
                    $str =~ s{\\"}(")g;
                    [$^R, $str ]
                })
            )
            (?<NUMBER>
                ( -? (?:0|([1-9]\d*)) (?:\.\d+)? (?:[eE][-+]?\d+)? )
                (?{
                    [$^R, 0+$^N]
                })
            )
        )
    /x;

    # use JSON::XS;

    unless ($source =~ $JSON) {
        die "Not JSONed string or incorrect JSON";
    }

    # return JSON::XS->new->utf8->decode($source);
    return $unjsoned;
}

1;
