use strict;
use warnings;

use lib qw( lib );
use lib qw( ../../../lib );

use Test::More tests => 5;

use MT;

my $mt = MT->new;

ok( MT->component( 'AssetExistenceFilter' ), 'AssetExistenceFilter plugin loaded correctly' );

use_ok( 'AssetExistenceFilter::Asset' );
use_ok( 'AssetExistenceFilter::Util' );
use_ok( 'AssetExistenceFilter::L10N' );
use_ok( 'AssetExistenceFilter::L10N::ja' );

done_testing;

1;
__END__
