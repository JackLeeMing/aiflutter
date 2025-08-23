import 'package:aiflutter/application/animationApp/home_screen.dart';
import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/pages/animated_text_kit_page.dart';
import 'package:aiflutter/pages/batch_pages.dart';
import 'package:aiflutter/pages/box_transform_app.dart';
import 'package:aiflutter/pages/countdown_timer_page.dart';
import 'package:aiflutter/pages/dismiss_view_page.dart';
import 'package:aiflutter/pages/liquid_aws_swipe_page.dart';
import 'package:aiflutter/pages/liquid_swipe_page.dart';
import 'package:aiflutter/pages/movie_app_page.dart';
import 'package:aiflutter/pages/pingying_page.dart';
import 'package:aiflutter/pages/ruby_text_page.dart';
import 'package:aiflutter/pages/tab_base_page.dart';
import 'package:aiflutter/pages/video_player.dart';
import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/utils/colors.dart';
import 'package:aiflutter/utils/icons.dart';
import 'package:aiflutter/utils/transition_resolver.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// VideoPlayerPage
final otherRoutes = [
  GoRoute(
    path: '/videoPlayer',
    name: "VideoPlayerPage",
    pageBuilder: (context, state) => transitionResolver(const VideoPlayerPage()),
  ),
  GoRoute(
    path: '/movie',
    name: "MovieAppPage",
    pageBuilder: (context, state) => transitionResolver(const MovieAppPage()),
  ),
  GoRoute(
    path: '/t1',
    name: "AnimationHomePage",
    pageBuilder: (context, state) => transitionResolver(const AnimationHomePage()),
  ),
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

final SettingsSection listSection = SettingsSection(
  title: 'List',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.shapes,
      iconColor: Colors.blue,
      title: 'GeometryReader',
      subtitle: '几何布局组件示例',
      hasArrow: true,
      path: AppRoutes.geometry,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.key,
      iconColor: Colors.orange,
      title: 'PreferenceKey',
      subtitle: '偏好设置键值管理',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.wrench,
      iconColor: Colors.purple,
      title: 'Danymic ToolBar',
      subtitle: '动态工具栏组件',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.yellow.shade700,
      title: '作文灵感',
      subtitle: '基于主题和字数要求生成相应的好词好句和范文',
      hasArrow: true,
      path: AppRoutes.writing,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.calculator,
      iconColor: Colors.green,
      title: '口算题',
      subtitle: '生成所选年级的口算题和答案',
      hasArrow: true,
      path: AppRoutes.math,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.featherPointed,
      iconColor: Colors.brown,
      title: '古诗词',
      subtitle: '根据需求生产古诗词背诵单',
      hasArrow: true,
      path: AppRoutes.poetry,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.flask,
      iconColor: Colors.teal,
      title: '科学实验',
      subtitle: '根据主题生成三个适合所选年龄段的科学实验步骤',
      hasArrow: true,
      path: AppRoutes.science,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.book,
      iconColor: Colors.indigo,
      title: '阅读书单',
      subtitle: '根据需求生成对应的阅读书单',
      hasArrow: true,
      path: AppRoutes.reading,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.language,
      iconColor: Colors.blue.shade700,
      title: '英语自我介绍',
      subtitle: '根据需求生成英文版和中文版的',
      hasArrow: true,
      path: AppRoutes.english,
    ),
  ],
);

final listRoutes = [
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
];

final fan = SettingsSection(
  title: 'Tousle',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.listOl,
      iconColor: randomColor(),
      title: 'DragSortPage',
      subtitle: '拖拽排序',
      hasArrow: true,
      path: AppRoutes.dragSort,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.solidFileImage,
      iconColor: randomColor(),
      title: 'SinglePicturePage',
      subtitle: 'Picture',
      hasArrow: true,
      path: AppRoutes.singlePic,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.salesforce,
      iconColor: randomColor(),
      title: 'SalesStatisticsPage',
      subtitle: 'Sales',
      hasArrow: true,
      path: AppRoutes.salesStatistics,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.airbnb,
      iconColor: randomColor(),
      title: 'AnimationTestPage',
      subtitle: 'Animation',
      hasArrow: true,
      path: AppRoutes.aniationTest,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.baseball,
      iconColor: randomColor(),
      title: 'BallAnimationPage',
      subtitle: 'Ball',
      hasArrow: true,
      path: AppRoutes.ballAnimation,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.toriiGate,
      iconColor: randomColor(),
      title: 'ToastnotificationPage',
      subtitle: 'Toast',
      hasArrow: true,
      path: AppRoutes.toastNotification,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.nairaSign,
      iconColor: randomColor(),
      title: 'NavigationComparisonPage',
      subtitle: 'Navi',
      hasArrow: true,
      path: AppRoutes.navigationComparison,
    ),
  ],
);
