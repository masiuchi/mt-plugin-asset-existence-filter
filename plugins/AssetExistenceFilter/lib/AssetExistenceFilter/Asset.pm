package AssetExistenceFilter::Asset;
use strict;

use AssetExistenceFilter::Util qw( is_positive_int );

our $PLUGIN = MT->instance()->component('AssetExistenceFilter');

sub list_props {
    return {
        file_existence => {
            base                  => '__virtual.single_select',
            label                 => 'File Existence',
            singleton             => 1,
            filter_tmpl           => \&_filter_tmpl,
            single_select_options => \&_single_select_options,
            terms                 => \&_terms,
        },
    };
}

sub system_filters {
    return {
        existing => {
            label => 'File Existing',
            items => [
                {   type => 'file_existence',
                    args => { value => 'existing', },
                },
            ],
            order => 10100,
        },
        not_existing => {
            label => 'File Not Existing',
            items => [
                {   type => 'file_existence',
                    args => { value => 'not existing', },
                },
            ],
            order => 10200,
        },
    };
}

sub _filter_tmpl {
    my $file = MT->translate('File');
    return <<"HTMLHEREDOC";
<mt:setvar name="label" value="$file">
<mt:var name="filter_form_single_select">
HTMLHEREDOC
}

sub _single_select_options {
    return [
        {   label => $PLUGIN->translate('existing'),
            value => 'existing',
        },
        {   label => $PLUGIN->translate('not existing'),
            value => 'not existing',
        },
    ];
}

sub _terms {
    my $prop = shift;
    my ( $args, $db_terms, $db_args ) = @_;

    return
        unless $args->{value} eq 'existing'
        || $args->{value} eq 'not existing';

    require MT::FileMgr;
    my $fmgr = MT::FileMgr->new('Local');

    my $func;
    if ( $args->{value} eq 'existing' ) {
        $func = sub { $_[0] && $fmgr->exists( $_[0] ); }
    }
    else {
        $func = sub { $_[0] && !$fmgr->exists( $_[0] ); }
    }

    my $read_at_once = _get_read_at_once();

    my %temp_args = %$db_args;
    $temp_args{limit}  = $read_at_once;
    $temp_args{offset} = 0;

    my @ids;
    require MT::Asset;
    while ( my @assets = MT::Asset->load( $db_terms, \%temp_args ) ) {
        @assets = grep {
            my $file_path = $_->file_path;
            $func->($file_path);
        } @assets;
        push @ids, map { $_->id } @assets;
        $temp_args{offset} += $read_at_once;
    }

    return { id => @ids ? \@ids : \'IS NULL' };
}

sub _get_read_at_once {
    my $read_at_once = $PLUGIN->get_config_value( 'read_at_once', 'system' );

    if ( is_positive_int($read_at_once) ) {
        return $read_at_once;
    }
    else {
        return $PLUGIN->DEFAULT_READ_AT_ONCE;
    }
}

1;
__END__


