package TestData;
use strict;
use warnings;

use constant DATA => [
    { okng => 1, value => '1',   message => "'1' is OK." },
    { okng => 0, value => '0',   message => "'0' is NG." },
    { okng => 0, value => '1.1', message => "'1.1' is NG." },
    { okng => 0, value => '1.0', message => "'1.0' is NG." },
    {   okng    => 1,
        value   => 1.0,
        message => "1.0 is OK, bacause this is not string."
    },
    { okng => 0, value => 'aaa', message => "'aaa' is NG." },
    { okng => 0, value => '0aa', message => "0aa is NG." },
    { okng => 0, value => ' ',   message => "space is NG." },
    { okng => 0, value => "\t",  message => "tab is NG." },
    { okng => 0, value => "\n",  message => "return is NG." },
];

sub count {
    my $data = DATA;
    return scalar @$data;
}

1;
__END__
