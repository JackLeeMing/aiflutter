import 'package:aiflutter/models/section.dart';
import 'package:aiflutter/router/app_routes.dart';
import 'package:aiflutter/router/flip_routes.dart';
import 'package:aiflutter/router/test_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _love = SettingsSection(
  title: 'Love',
  items: [
    SettingsItem(
      icon: FontAwesomeIcons.heartPulse,
      iconColor: Colors.red,
      title: '爱心+烟花',
      subtitle: '浪漫动画效果展示',
      hasArrow: true,
      path: AppRoutes.fireworks,
    ),
    SettingsItem(
      icon: FontAwesomeIcons.heartCircleCheck,
      iconColor: Colors.redAccent,
      title: '爱心',
      subtitle: '浪漫的爱心',
      hasArrow: true,
      path: AppRoutes.heart,
    ),
  ],
);

final _system = SettingsSection(
  title: 'System',
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
  ],
);

final _model = SettingsSection(
  title: 'Model',
  items: [
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

final List<SettingsSection> settingsSections = [
  _love,
  _system,
  buildFlipSection("Flip"),
  buildTestSection("Test+GoRoute扩展"),
  _model,
  // buildOtherSection("Other"),
  //  _listSection,
];
