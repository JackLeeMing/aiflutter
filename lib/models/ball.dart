import 'dart:ui';

import 'package:flutter/physics.dart';

class Ball {
  double x; // X 坐标
  double y; // Y 坐标
  double vx; // X 速度
  double vy; // Y 速度
  Color color; // 小球颜色
  SpringSimulation? springX; // X 弹簧
  SpringSimulation? springY; // Y 弹簧
  double springStartX = 0.0; // X 弹簧起始位置
  double springStartY = 0.0; // Y 弹簧起始位置
  double springStartTime = 0.0; // 弹簧开始时间

  Ball({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    this.springX,
    this.springY,
  });
}
