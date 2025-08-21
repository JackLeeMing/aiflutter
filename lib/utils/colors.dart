// 生成随机颜色的函数
import 'dart:math';

import 'package:flutter/material.dart';

Color randomColor() {
  final random = Random();
  // 设置一个最小值，比如 128，来确保颜色偏亮
  const minColorValue = 128;
  // 生成介于 128 到 255 之间的随机数
  return Color.fromARGB(
    255, // 完全不透明
    minColorValue + random.nextInt(256 - minColorValue), // 红色值
    minColorValue + random.nextInt(256 - minColorValue), // 绿色值
    minColorValue + random.nextInt(256 - minColorValue), // 蓝色值
  );
}
