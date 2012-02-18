use strict;
use warnings;

use lib qw( ../../../lib );
use lib qw( lib plugins/AssetExistenceFilter/t );

use Test::More;
use TestData;

use MT;

MT->new;
my $plugin = MT->component( 'AssetExistenceFilter' );

my $data = TestData::DATA;
my %orig_param;

# backup
$plugin->load_config( \%orig_param, 'system' );

note( 'save test' );
my %param = %orig_param;
foreach my $t ( @$data ) {
    $param{read_at_once} = $t->{value};
    my $ret = eval{ $plugin->save_config( \%param, 'system' ) };
    if ( $t->{okng} ) {
        ok( $ret && !$@, $t->{message} );
    } else {
        ok( !$ret && $@, $t->{message} );
    }
}

note( 'load test' );
foreach my $t ( @$data ) {
    $plugin->set_config_value( { read_at_once => $t->{value} }, 'system' );
    $plugin->load_config( \%param, 'system' );
    if ( $t->{okng} ) {
        ok( $param{read_at_once} eq $t->{value}, $t->{message} );
    } else {
        ok( $param{read_at_once} eq $plugin->DEFAULT_READ_AT_ONCE, $t->{message} );
    }
}

# restore
$plugin->save_config( \%orig_param, 'system' );

done_testing;

1;
__END__
