import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData randomAwesomeIcon() {
  final random = Random();

  // 获取 FontAwesomeIcons 类中所有的静态图标属性
  // 这部分代码是关键，我们通过 Dart 的反射（reflection）来获取所有图标的列表。
  // 注意：这个方法在某些平台上（如 web）可能不被支持。
  // 在这里我们使用一个硬编码的列表作为替代方案，以确保兼容性。
  //
  // 最佳实践：维护一个你常用的图标列表。

  // 推荐：使用一个包含常用图标的列表
  final List<IconData> iconsList = [
    FontAwesomeIcons.solidStar,
    FontAwesomeIcons.star,
    FontAwesomeIcons.house,
    FontAwesomeIcons.bolt,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.user,
    FontAwesomeIcons.gear,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.paperPlane,
    FontAwesomeIcons.moon,
    FontAwesomeIcons.sun,
    FontAwesomeIcons.cloud,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.bug,
    FontAwesomeIcons.faceLaughBeam,
    FontAwesomeIcons.faceGrinHearts,
    FontAwesomeIcons.faceAngry,
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.water,
    FontAwesomeIcons.apple,
    FontAwesomeIcons.google,
    FontAwesomeIcons.linkedin,
    FontAwesomeIcons.iceCream,
  ];

  // 从列表中随机选择一个图标
  return iconsList[random.nextInt(iconsList.length)];
}
