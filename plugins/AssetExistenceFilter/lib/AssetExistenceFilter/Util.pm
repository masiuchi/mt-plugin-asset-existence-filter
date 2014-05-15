package AssetExistenceFilter::Util;
use strict;
use base qw( Exporter );

our @EXPORT_OK = qw( is_positive_int );

sub is_positive_int {
    if ( $_[0] =~ /\D/ || $_[0] < 1 ) {
        return 0;
    }
    else {
        return 1;
    }
}

1;
__END__
