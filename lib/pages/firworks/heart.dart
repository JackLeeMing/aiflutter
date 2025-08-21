// MARK: - 心动控制器
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const colors = [
  Color(0xFFE4B4AF),
  Color(0xFFC08682),
  Color(0xFFD49DA3),
  Color(0xFFE5002C),
  Color(0xFFC04F34),
  Color(0xFFB14E4E),
  Color(0xFFFBB1B6),
  Color(0xFFE15174),
  Color(0xFFE1BBBE),
  Color(0xFF875747),
  Color(0xFFFD8445),
  Color(0xFFFE8C4B),
  Color(0xFFF9A979),
  Color(0xFF863E51)
];

/// 控制器类，心跳控制
class HeartController extends ChangeNotifier {
  Timer? _updateTimer;
  bool isRunning = false;
  double _heartScale = 1.0;
  double _heartAlpha = 1.0;
  bool _heartBeating = false;
  double get heartScale => _heartScale;
  double get heartAlpha => _heartAlpha;
  Color get heartColor => colors[_colorIndex];
  int _colorIndex = 0;

  /// 启动动画和烟花发射
  void start() {
    stop(); // 先停止之前的动画
    isRunning = true;
    _heartScale = 1.0;
    _heartAlpha = 1.0;
    _heartBeating = true;
    int count = 0;
    // 使用60fps的更新频率
    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (isRunning) {
        _updateHeartAnimation(); // 更新爱心动画
        notifyListeners(); // 通知UI更新
        count += 1;
        if (count % 520 == 0) {
          _colorIndex += 1;
          _colorIndex %= colors.length;
          count = 0;
        }
      }
    });
    _startHeartAnimation();
  }

  /// 停止动画和清理所有对象
  void stop() {
    isRunning = false;
    _updateTimer?.cancel();
    _updateTimer = null;
    notifyListeners();
  }

  bool toggle() {
    if (isRunning) {
      isRunning = false;
    } else {
      isRunning = true;
    }
    return isRunning;
  }

  /// 重新开始整个浪漫动画序列
  void restart() {
    start();
  }

  /// 开始纯心形跳动动画
  void _startHeartAnimation() {
    _heartBeating = true;
    _heartAlpha = 1.0;
    notifyListeners();
  }

  /// 更新爱心动画效果
  void _updateHeartAnimation() {
    if (_heartBeating) {
      // 心跳效果：使用正弦波控制缩放
      final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
      _heartScale = 1.0 + 0.3 * sin(time * 3.0); // 3.0 控制心跳频率
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
