package MT::Plugin::AssetExistenceFilter;
use strict;
use base qw( MT::Plugin );

use AssetExistenceFilter::Util qw( is_positive_int );

use constant DEFAULT_READ_AT_ONCE => 50;
use constant NAME => ( split /::/, __PACKAGE__ )[-1];

my $plugin = __PACKAGE__->new(
    {   name        => NAME,
        id          => lc NAME,
        key         => lc NAME,
        l10n_class  => NAME . '::L10N',
        version     => '1.01',
        author_name => 'masiuchi',
        author_link => 'https://github.com/masiuchi',
        plugin_link =>
            'https://github.com/masiuchi/mt-plugin-asset-existence-filter',
        description =>
            '<__trans phrase="Enable filtering assets by the file existing or not. Only for MT 5.1 because of using listing framework.">',
        system_config_template => 'system_config.tmpl',
        settings               => MT::PluginSettings->new(
            [   [   'read_at_once',
                    { Default => DEFAULT_READ_AT_ONCE, Scope => 'system' }
                ],
            ]
        ),
        registry => {
            list_properties => {
                asset => '$' . NAME . '::' . NAME . '::Asset::list_props',
            },
            system_filters => {
                asset => '$' . NAME . '::' . NAME . '::Asset::system_filters',
            },
        },
    }
);
MT->add_plugin($plugin);

sub load_config {
    my $p = shift;
    $p->SUPER::load_config(@_);
    my ( $param, $scope ) = @_;
    unless ( is_positive_int( $param->{read_at_once} ) ) {
        $param->{read_at_once} = DEFAULT_READ_AT_ONCE;
    }
}

sub save_config {
    my $p = shift;
    my ( $param, $scope ) = @_;
    unless ( is_positive_int( $param->{read_at_once} ) ) {
        die $p->translate(
            'AssetExistenceFilter : "Read at once" must be a positive integer.'
        );
    }
    $p->SUPER::save_config(@_);
}

1;
__END__
