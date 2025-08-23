import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/pages/flip_animation_page.dart';
import 'package:aiflutter/pages/flip_clock_page.dart';
import 'package:aiflutter/pages/flip_digit_clock_page.dart';
import 'package:aiflutter/pages/flip_text_page.dart';
import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/utils/colors.dart';
import 'package:aiflutter/utils/icons.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:go_router/go_router.dart';

final flipRoutes = [
  GoRoute(
    path: AppRoutes.clock,
    name: "Flip Clock",
    pageBuilder: (context, state) => transitionResolver(const FlutterFlipClockPage()),
  ),
  GoRoute(
    path: '/t-2',
    name: "Digit Clock",
    pageBuilder: (context, state) => transitionResolver(const DigitClockPage()),
  ),
  GoRoute(
    path: '/t-1',
    name: "Flip Text",
    pageBuilder: (context, state) => transitionResolver(const FlipTextPage()),
  ),
  GoRoute(
    path: '/t0',
    name: "Flip Animation",
    pageBuilder: (context, state) => transitionResolver(FlutterFlipAnimationPage()),
  ),
];

SettingsSection buildFlipSection(String title) {
  List<SettingsItem> items = List.generate(flipRoutes.length, (int index) {
    final route = flipRoutes[index];
    return SettingsItem(
      icon: randomAwesomeIcon(),
      iconColor: randomColor(),
      title: route.name!,
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
