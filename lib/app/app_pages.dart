import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/router/routes.dart';
import 'package:aiflutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final SettingsSection _listSection = SettingsSection(
  title: '从列表中切换',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.shapes,
      iconColor: Colors.blue,
      title: 'GeometryReader',
      subtitle: '几何布局组件示例',
      hasArrow: true,
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
    ),
    SettingsItem(
      icon: FontAwesomeIcons.calculator,
      iconColor: Colors.green,
      title: '口算题',
      subtitle: '生成所选年级的口算题和答案',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.featherPointed,
      iconColor: Colors.brown,
      title: '古诗词',
      subtitle: '根据需求生产古诗词背诵单',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.flask,
      iconColor: Colors.teal,
      title: '科学实验',
      subtitle: '根据主题生成三个适合所选年龄段的科学实验步骤',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.book,
      iconColor: Colors.indigo,
      title: '阅读书单',
      subtitle: '根据需求生成对应的阅读书单',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.language,
      iconColor: Colors.blue.shade700,
      title: '英语自我介绍',
      subtitle: '根据需求生成英文版和中文版的',
      hasArrow: true,
    ),
  ],
);

final _love = SettingsSection(
  title: '爱的魔法',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.bomb,
      iconColor: Colors.purpleAccent,
      title: '爱心+烟花',
      subtitle: '浪漫动画效果展示',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.heart,
      iconColor: Colors.deepPurple,
      title: '爱心',
      subtitle: '浪漫的爱心',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.clock,
      iconColor: Colors.purple,
      title: '翻页时钟',
      subtitle: '翻页时钟',
      hasArrow: true,
    ),
  ],
);

final _model = SettingsSection(
  title: '视图',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.camera,
      iconColor: Colors.deepOrange,
      title: '系统相机',
      subtitle: '系统相机调用',
      hasArrow: true,
      path: AppRoutes.awesomeCamera,
      isCamera: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.expand,
      iconColor: Colors.deepOrangeAccent,
      title: 'FullScreen Cover',
      subtitle: '全屏覆盖展示',
      hasArrow: true,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.rectangleList,
      iconColor: Colors.pinkAccent,
      title: 'Sheet Modal',
      subtitle: 'iOS风格的底部弹出表单',
      hasArrow: true,
    ),
  ],
);

final _fan = SettingsSection(
  title: '繁',
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

final List<SettingsSection> settingsSections = [
  _love,
  _model,
  _fan,
  buildOtherSection("茂"),
  _listSection,
];
