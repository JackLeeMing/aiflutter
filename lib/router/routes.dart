import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/pages/animated_text_kit_page.dart';
import 'package:aiflutter/pages/box_transform_app.dart';
import 'package:aiflutter/pages/camerawesome_page.dart';
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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

final otherRoutes = [
  GoRoute(
    path: '/t1',
    name: "AnimatedTextKitPage",
    pageBuilder: (context, state) => transitionResolver(const AnimatedTextKitPage()),
  ),
  GoRoute(
    path: '/t2',
    name: "BoxTransformPage",
    pageBuilder: (context, state) => transitionResolver(const BoxTransformPage()),
  ), //
  GoRoute(
    path: '/t3',
    name: "AwesomeCamera",
    pageBuilder: (context, state) => transitionResolver(const CameraAwesomePage()),
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
    pageBuilder: (context, state) => transitionResolver(const FlutterLiquidAwipePage()),
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
    final isCamera = route.name == 'AwesomeCamera';
    return SettingsItem(
      icon: isCamera ? FontAwesomeIcons.camera : randomAwesomeIcon(),
      iconColor: isCamera ? Colors.brown : randomColor(),
      title: isCamera ? '相机' : route.name!,
      subtitle: isCamera ? '系统相机调用' : '#${index + 1}',
      hasArrow: true,
      path: route.path,
    );
    // checkCameraPermission
  });
  return SettingsSection(
    title: title,
    items: items,
  );
}
