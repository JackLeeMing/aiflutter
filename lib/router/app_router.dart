import 'package:aiflutter/app/app.dart';
import 'package:aiflutter/app/app_entry_demo.dart';
import 'package:aiflutter/pages/aniation_test_page.dart';
import 'package:aiflutter/pages/ball_animation_page.dart';
import 'package:aiflutter/pages/batch_pages.dart';
import 'package:aiflutter/pages/camerawesome_page.dart';
import 'package:aiflutter/pages/drag_sort_page.dart';
import 'package:aiflutter/pages/heart_page.dart';
import 'package:aiflutter/pages/navigation_comparison_page.dart';
import 'package:aiflutter/pages/romantic_firework_page.dart';
import 'package:aiflutter/pages/sales_statistics_page.dart';
import 'package:aiflutter/pages/single_picture_page.dart';
import 'package:aiflutter/pages/toast_notification_page.dart';
import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/router/flip_routes.dart';
import 'package:aiflutter/router/test_routes.dart';
import 'package:aiflutter/utils/constant.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './routes.dart';

/// 应用路由配置 - 使用 Go Router 实现
/// 提供类型安全、声明式的路由管理
class AppRouter {
  /// 路由配置
  static final GoRouter router = GoRouter(
    // 初始路由
    initialLocation: AppRoutes.home, //AppRoutes.fireworks, //AppRoutes.home, // '/i18n',
    navigatorKey: AppConstant.navigatorKey,
    observers: [BotToastNavigatorObserver()],

    // 错误页面
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),

    // 路由定义
    routes: [
      // 主页路由 - 包装 WindowFrameWidget
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        pageBuilder: (context, state) => transitionResolver(const AppEntryPage()),
      ),
      GoRoute(
        path: AppRoutes.awesomeCamera,
        name: "CameraAwesomePage",
        pageBuilder: (context, state) => transitionResolver(const CameraAwesomePage()),
      ),

      // 爱心烟花功能页
      GoRoute(
        path: AppRoutes.heart,
        name: AppRoutes.heartName,
        pageBuilder: (context, state) => transitionResolver(const HeartFeaturePage()),
      ),

      GoRoute(
        path: AppRoutes.fireworks,
        name: "FireworksPage",
        pageBuilder: (context, state) => transitionResolver(const FireworksPage()),
      ),

      //
      // 详情页路由 - 支持参数传递
      GoRoute(
        path: AppRoutes.detail,
        name: AppRoutes.detailName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DetailPage(
            title: extra?['title'] ?? '详情',
            subtitle: extra?['subtitle'] ?? '',
            icon: extra?['icon'] ?? Icons.info,
            iconColor: extra?['iconColor'] ?? Colors.blue,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.dragSort,
        name: "DragSortPage",
        pageBuilder: (context, state) => transitionResolver(const DragSortPage()),
      ),

      GoRoute(
        path: AppRoutes.singlePic,
        name: "SinglePicturePage",
        pageBuilder: (context, state) => transitionResolver(const SinglePicturePage()),
      ),

      GoRoute(
        path: AppRoutes.salesStatistics,
        name: "SalesStatisticsPage",
        pageBuilder: (context, state) => transitionResolver(const SalesStatisticsPage()),
      ),

      GoRoute(
        path: AppRoutes.aniationTest,
        name: "AnimationTestPage",
        pageBuilder: (context, state) => transitionResolver(const AnimationTestPage()),
      ),

      GoRoute(
        path: AppRoutes.ballAnimation,
        name: "BallAnimationPage",
        pageBuilder: (context, state) => transitionResolver(const BallAnimationPage()),
      ),

      GoRoute(
        path: AppRoutes.toastNotification,
        name: "ToastnotificationPage",
        pageBuilder: (context, state) => transitionResolver(const ToastnotificationPage()),
      ),

      GoRoute(
        path: AppRoutes.navigationComparison,
        name: "NavigationComparisonPage",
        pageBuilder: (context, state) => transitionResolver(const NavigationComparisonPage()),
      ),
      ...otherRoutes,
      ...flipRoutes,
      ...testRoutes
    ],

    // 路由重定向
    redirect: (context, state) {
      // 这里可以添加路由守卫逻辑
      // 例如：用户认证检查、权限验证等
      return null; // 返回 null 表示不重定向
    },
  );
}
