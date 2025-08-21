import 'package:aiflutter/app/app.dart';
import 'package:aiflutter/app/app_entry_demo.dart';
import 'package:aiflutter/pages/aniation_test_page.dart';
import 'package:aiflutter/pages/ball_animation_page.dart';
import 'package:aiflutter/pages/batch_pages.dart';
import 'package:aiflutter/pages/camerawesome_page.dart';
import 'package:aiflutter/pages/drag_sort_page.dart';
import 'package:aiflutter/pages/firework_page.dart';
import 'package:aiflutter/pages/flutter_flip_clock_page.dart';
import 'package:aiflutter/pages/navigation_comparison_page.dart';
import 'package:aiflutter/pages/sales_statistics_page.dart';
import 'package:aiflutter/pages/single_picture_page.dart';
import 'package:aiflutter/pages/toast_notification_page.dart';
import 'package:aiflutter/router/app_routes.dart';
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
    initialLocation: AppRoutes.home,
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

      // 爱心烟花功能页
      GoRoute(
        path: AppRoutes.heart,
        name: AppRoutes.heartName,
        pageBuilder: (context, state) => transitionResolver(const FireworksFeaturePage()),
      ),

      // 几何布局功能页
      GoRoute(
        path: AppRoutes.geometry,
        name: AppRoutes.geometryName,
        pageBuilder: (context, state) => transitionResolver(const GeometryFeaturePage()),
      ),

      // 作文灵感功能页
      GoRoute(
        path: AppRoutes.writing,
        name: AppRoutes.writingName,
        pageBuilder: (context, state) => transitionResolver(const WritingFeaturePage()),
      ),

      // 口算题功能页
      GoRoute(
        path: AppRoutes.math,
        name: AppRoutes.mathName,
        pageBuilder: (context, state) => transitionResolver(const MathFeaturePage()),
      ),

      // 古诗词功能页
      GoRoute(
        path: AppRoutes.poetry,
        name: AppRoutes.poetryName,
        pageBuilder: (context, state) => transitionResolver(const PoetryFeaturePage()),
      ),

      // 科学实验功能页
      GoRoute(
        path: AppRoutes.science,
        name: AppRoutes.scienceName,
        pageBuilder: (context, state) => transitionResolver(const ScienceFeaturePage()),
      ),

      // 阅读书单功能页
      GoRoute(
        path: AppRoutes.reading,
        name: AppRoutes.readingName,
        pageBuilder: (context, state) => transitionResolver(const ReadingFeaturePage()),
      ),

      // 英语自我介绍功能页
      GoRoute(
        path: AppRoutes.english,
        name: AppRoutes.englishName,
        pageBuilder: (context, state) => transitionResolver(const EnglishFeaturePage()),
      ),

      GoRoute(
        path: AppRoutes.fireworks,
        name: "FireworksPage",
        pageBuilder: (context, state) => transitionResolver(const FireworksPage()),
      ),

      GoRoute(
        path: AppRoutes.clock,
        name: "FlutterFlipClockPage",
        pageBuilder: (context, state) => transitionResolver(const FlutterFlipClockPage()),
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
    ],

    // 路由重定向
    redirect: (context, state) {
      // 这里可以添加路由守卫逻辑
      // 例如：用户认证检查、权限验证等
      return null; // 返回 null 表示不重定向
    },
  );
}
