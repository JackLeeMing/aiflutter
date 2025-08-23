mixin AppLocale {
  static const String title = 'title';
  static const String thisIs = 'thisIs';

  static const Map<String, dynamic> zh = {
    title: '本地化',
    thisIs: '这是一个 %a 包, 版本为 %a.',
  };

  static const Map<String, dynamic> zhTw = {
    title: '本地化',
    thisIs: '這是一個 %a 包, 版本為 %a.',
  };

  static const Map<String, dynamic> en = {
    title: 'Localization',
    thisIs: 'This is %a package, version %a.',
  };
  static const Map<String, dynamic> km = {
    title: 'ការធ្វើមូលដ្ឋានីយកម្ម',
    thisIs: 'នេះគឺជាកញ្ចប់%a កំណែ%a.',
  };
  static const Map<String, dynamic> ja = {
    title: 'ローカリゼーション',
    thisIs: 'これは%aパッケージ、バージョン%aです。',
  };
}
