import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// 设置分组数据模型
class SettingsSection {
  final String title;
  final List<SettingsItem> items;

  SettingsSection({
    required this.title,
    required this.items,
  });
}

/// 设置项数据模型
class SettingsItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool hasArrow;
  final VoidCallback? onTap;

  SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle = '',
    this.hasArrow = true,
    this.onTap,
  });
}

// 设置项数据模型
final List<SettingsSection> settingsSections = [
  SettingsSection(
    title: '爱的魔法',
    items: [
      SettingsItem(
        icon: FontAwesomeIcons.bomb,
        iconColor: Colors.red,
        title: '爱心+烟花',
        subtitle: '浪漫动画效果展示',
        hasArrow: true,
      ),
      SettingsItem(
        icon: FontAwesomeIcons.heart,
        iconColor: Colors.red,
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
  ),
  SettingsSection(
    title: '视图',
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
        icon: FontAwesomeIcons.expand,
        iconColor: Colors.cyan,
        title: 'FullScreen Cover',
        subtitle: 'iOS风格的全屏覆盖展示',
        hasArrow: true,
      ),
      SettingsItem(
        icon: FontAwesomeIcons.rectangleList,
        iconColor: Colors.pink,
        title: 'Sheet Modal',
        subtitle: 'iOS风格的底部弹出表单',
        hasArrow: true,
      ),
    ],
  ),
  SettingsSection(
    title: '从列表中切换',
    items: [
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
  ),
];
