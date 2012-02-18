use strict;
use warnings;

use lib qw( ../../../lib ../lib );
use lib qw( lib plugins/AssetExistenceFilter/lib plugins/AssetExistenceFilter/t );

use Test::More;
use TestData;

use MT;
use AssetExistenceFilter::Asset;

my $mt = MT->new;
my $plugin = $mt->component( 'AssetExistenceFilter' );

# backup
my $read_at_once = $plugin->get_config_value( 'read_at_once', 'system' );

my $f = \&AssetExistenceFilter::Asset::_get_read_at_once;
my $data = TestData::DATA;
foreach my $t ( @$data ) {
    $plugin->set_config_value( { read_at_once => $t->{value} }, 'system' );
    if ( $t->{okng} ) {
        ok( $f->() eq $t->{value}, $t->{message} );
    } else {
        ok( $f->() ne $t->{value}, $t->{message} );
    }
}

# restore
$plugin->set_config_value( { read_at_once => $read_at_once }, 'system' );

done_testing;

1;
__END__
