use strict;
use warnings;

use lib qw( ../../../lib ../lib );
use lib
    qw( lib plugins/AssetExistenceFilter/lib plugins/AssetExistenceFilter/t );

use Test::More;
use TestData;

use MT;
use AssetExistenceFilter::Util qw( is_positive_int );

my $mt = MT->new;
my $f  = \&is_positive_int;

my $data = TestData::DATA;

foreach my $t (@$data) {
    if ( $t->{okng} ) {
        ok( $f->( $t->{value} ), $t->{message} );
    }
    else {
        ok( !$f->( $t->{value} ), $t->{message} );
    }
}

done_testing;

1;
__END__
