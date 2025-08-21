import 'package:flutter/material.dart';

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
  final String? path;

  SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle = '',
    this.hasArrow = true,
    this.onTap,
    this.path,
  });
}
