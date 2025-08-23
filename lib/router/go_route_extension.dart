import 'package:go_router/go_router.dart';

final Map<String, String> routeName2DisPlayName = {
  "AddToCartAnimationPage": "添加购物车动效",
  "i18n_phone_number_input": "电话号码+多语言",
  "SettingScreen": "多语言"
};

// 扩展 GoRoute 增加一个 displayName 属性
extension MyGoRoute on GoRoute {
  String? get displayName {
    return routeName2DisPlayName[name] ?? name;
  }
}
