// 生成随机颜色的函数
import 'dart:math';

import 'package:flutter/material.dart';

Color randomColorGemini() {
  final random = Random();
  // 设置颜色的最小值，避免暗色。
  // 150 相对 128 能更好地排除暗色。
  const int minColorValue = 150;
  // 设置一个颜色分量为最大值，增加鲜艳度。
  const int maxColorValue = 255;

  // 创建一个包含 RGB 值的列表
  final List<int> rgb = [0, 0, 0];

  // 随机设置一个分量为最大值 (255)
  rgb[random.nextInt(3)] = maxColorValue;

  // 设置其他两个分量，避免它们都为最大值以杜绝偏白色
  for (int i = 0; i < 3; i++) {
    if (rgb[i] != maxColorValue) {
      rgb[i] = minColorValue + random.nextInt(maxColorValue - minColorValue);
    }
  }
  // 随机打乱分量顺序，确保生成的颜色更随机
  rgb.shuffle();
  return Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
}

/// 生成艳丽的随机颜色
///
/// 通过控制 HSV 颜色空间的参数来确保颜色艳丽：
/// - 色相(Hue): 0-360度，覆盖所有颜色
/// - 饱和度(Saturation): 0.7-1.0，确保颜色鲜艳
/// - 亮度(Value): 0.6-0.9，避免过暗或过亮
Color randomColor2() {
  final Random random = Random();

  // 色相：0-360度，随机选择
  final double hue = random.nextDouble() * 360;

  // 饱和度：0.7-1.0，确保颜色饱和度高
  final double saturation = 0.7 + random.nextDouble() * 0.3;

  // 亮度：0.6-0.9，避免过暗和过亮
  final double value = 0.6 + random.nextDouble() * 0.3;

  return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
}

/// 从预定义的艳丽颜色中随机选择一个
/// 这个方法提供了更可控的艳丽颜色选择
Color randomColor() {
  final Random random = Random();
  // 预定义的艳丽颜色调色板
  final List<Color> brightColors = [
    const Color(0xFFFF1744), // 亮红
    const Color(0xFFFF5722), // 深橙
    const Color(0xFFFF9800), // 橙色
    const Color(0xFFFFC107), // 琥珀色
    const Color(0xFF8BC34A), // 浅绿
    const Color(0xFF4CAF50), // 绿色
    const Color(0xFF00BCD4), // 青色
    const Color(0xFF03A9F4), // 浅蓝
    const Color(0xFF2196F3), // 蓝色
    const Color(0xFF3F51B5), // 靛蓝
    const Color(0xFF9C27B0), // 紫色
    const Color(0xFFE91E63), // 粉红
    const Color(0xFF00E676), // 绿色强调
    const Color(0xFF1DE9B6), // 青绿强调
    const Color(0xFF00E5FF), // 青色强调
    const Color(0xFF448AFF), // 蓝色强调
    const Color(0xFF7C4DFF), // 深紫强调
    const Color(0xFFFF4081), // 粉红强调
    const Color(0xFFFF3D00), // 深橙红
    const Color(0xFFFFAB00), // 金橙色
    const Color(0xFFCDDC39), // 柠檬绿
    const Color(0xFF76FF03), // 亮绿
    const Color(0xFF18FFFF), // 亮青
    const Color(0xFF40C4FF), // 天蓝
    const Color(0xFF536DFE), // 亮靛蓝
    const Color(0xFFAB47BC), // 中紫
    const Color(0xFFEC407A), // 中粉
    const Color(0xFFEF5350), // 亮红橙
    const Color(0xFFFF7043), // 珊瑚橙
    const Color(0xFFFFEB3B), // 亮黄
    const Color(0xFF66BB6A), // 明绿
    const Color(0xFF26A69A), // 青绿
  ];

  return brightColors[random.nextInt(brightColors.length)];
}
