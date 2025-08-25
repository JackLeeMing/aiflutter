// SettingsScreenPage
import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/pages/i18n_display_page.dart';
import 'package:aiflutter/pages/setting_screen_page.dart';
import 'package:aiflutter/pages/shimmer_slide_lock_page.dart';
import 'package:aiflutter/pages/shop_cart_page.dart';
import 'package:aiflutter/utils/colors.dart';
import 'package:aiflutter/utils/icons.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:go_router/go_router.dart';

import './go_route_extension.dart';

final testRoutes = [
  GoRoute(
    path: '/shimmer',
    name: "SlideToUnlockPage",
    pageBuilder: (context, state) => transitionResolver(WindowFrameWidget(child: SlideToUnlockPage())),
  ),
  GoRoute(
    path: '/cart',
    name: "AddToCartAnimationPage",
    pageBuilder: (context, state) => transitionResolver(const WindowFrameWidget(child: MultiProductAddToCartPage())),
  ),
  GoRoute(
    path: '/i18n',
    name: "i18n_phone_number_input",
    pageBuilder: (context, state) => transitionResolver(const I18nDisplayPage()),
  ),
  GoRoute(
    path: '/settingScreen',
    name: "SettingScreen",
    pageBuilder: (context, state) => transitionResolver(const SettingsScreenPage()),
  ),
];

SettingsSection buildTestSection(String title) {
  List<SettingsItem> items = List.generate(testRoutes.length, (int index) {
    final route = testRoutes[index];
    return SettingsItem(
      icon: randomAwesomeIcon(),
      iconColor: randomColor(),
      title: route.displayName!,
      subtitle: '功能衍生#${index + 1}',
      hasArrow: true,
      path: route.path,
      isCamera: false,
    );
  });
  return SettingsSection(
    title: title,
    items: items,
  );
}
