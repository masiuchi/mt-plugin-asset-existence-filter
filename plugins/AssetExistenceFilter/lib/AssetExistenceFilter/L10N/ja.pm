package AssetExistenceFilter::L10N::ja;
use strict;
use base qw( AssetExistenceFilter::L10N );

our %Lexicon = (

    # AssetExistenceFilter.pl
    'Enable filtering assets by the file existing or not. Only for MT 5.1 because of using listing framework.'
        => 'ファイルの存在有無でのアイテムフィルタリングを可能にします。リスティングフレームワークを使用しているので、MT 5.1 限定です。',
    'AssetExistenceFilter : "Read at once" must be a positive integer.' =>
        'AssetExistenceFilter :「一度に読み込むデータ数」は正の整数である必要があります。',

    # tmpl/system_config.tmpl
    'Read at once' => '一度に読み込むデータ数',

    # lib/AssetExistenceFilter/Asset.pm
    'Missing Files'            => 'ファイルの存在有無',
    'extant'                   => '存在する',
    'missing'                  => '存在しない',
    'Assets with Extant Files' => 'ファイルが存在するアイテム',
    'Assets with Missing Files' =>
        'ファイルが存在しないアイテム',
);

1;
__END__
