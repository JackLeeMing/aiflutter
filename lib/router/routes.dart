import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/pages/animated_text_kit_page.dart';
import 'package:aiflutter/pages/box_transform_app.dart';
import 'package:aiflutter/pages/countdown_timer_page.dart';
import 'package:aiflutter/pages/dismiss_view_page.dart';
import 'package:aiflutter/pages/flutter_liquid_swipe_page.dart';
import 'package:aiflutter/pages/liquid_swipe_page.dart';
import 'package:aiflutter/pages/pingying_page.dart';
import 'package:aiflutter/pages/ruby_text_page.dart';
import 'package:aiflutter/pages/tab_base_page.dart';
import 'package:aiflutter/utils/colors.dart';
import 'package:aiflutter/utils/icons.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:go_router/go_router.dart';

final otherRoutes = [
  GoRoute(
    path: '/t2',
    name: "BoxTransformPage",
    pageBuilder: (context, state) => transitionResolver(const BoxTransformPage()),
  ), //
  GoRoute(
    path: '/t3',
    name: "AnimatedTextKitPage",
    pageBuilder: (context, state) => transitionResolver(const AnimatedTextKitPage()),
  ),
  GoRoute(
    path: '/t4',
    name: "CountdownTimerPage",
    pageBuilder: (context, state) => transitionResolver(const CountdownTimerPage()),
  ), //
  GoRoute(
    path: '/t5',
    name: "DismissViewPage",
    pageBuilder: (context, state) => transitionResolver(const DismissViewPage()),
  ),
  GoRoute(
    path: '/t6',
    name: "FlutterLiquidAwipePage",
    pageBuilder: (context, state) => transitionResolver(const FlutterLiquidPage()),
  ), //
  GoRoute(
    path: '/t7',
    name: "LiquidSwipePage",
    pageBuilder: (context, state) => transitionResolver(const LiquidSwipePage()),
  ),
  GoRoute(
    path: '/t8',
    name: "PingYingPage",
    pageBuilder: (context, state) => transitionResolver(const PingYingPage()),
  ), //
  GoRoute(
    path: '/t9',
    name: "RudyTextPage",
    pageBuilder: (context, state) => transitionResolver(const RudyTextPage()),
  ),
  GoRoute(
    path: '/t10',
    name: "TabBasePage",
    pageBuilder: (context, state) => transitionResolver(const TabBasePage()),
  ) //
];

SettingsSection buildOtherSection(String title) {
  List<SettingsItem> items = List.generate(otherRoutes.length, (int index) {
    final route = otherRoutes[index];
    return SettingsItem(
      icon: randomAwesomeIcon(),
      iconColor: randomColor(),
      title: route.name!,
      subtitle: '功能衍生#${index + 1}',
      hasArrow: true,
      path: route.path,
      isCamera: false,
    );
    // checkCameraPermission
  });
  return SettingsSection(
    title: title,
    items: items,
  );
}
