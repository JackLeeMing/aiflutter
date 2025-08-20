import 'package:flutter/material.dart';

class AppConstant {
  static String initialLocation = "/";

  // 全局Navigator key，用于在没有BuildContext的地方进行导航
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'appRouter');

  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'appShell');
}
