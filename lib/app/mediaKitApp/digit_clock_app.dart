import 'dart:async';
import 'dart:math' as math;

import 'package:aiflutter/utils/system_util.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_flip_clock1.dart';
// import './flutter_flip_animation_4.dart';
import './flutter_flip_clock.dart';

class DigitClockApp extends StatefulWidget {
  const DigitClockApp({super.key});

  @override
  State<DigitClockApp> createState() => _DigitClockPageState();
}

class _DigitClockPageState extends State<DigitClockApp> {
  late Timer _timer;
  late String _currentTime;
  late String _previousTime;
  bool _isDarkTheme = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentTime = _formatTime(now);
    _previousTime = _currentTime;
    _startTimer();
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}${time.minute.toString().padLeft(2, '0')}${time.second.toString().padLeft(2, '0')}';
  }

  void _updateTime() {
    final now = DateTime.now();
    final newTime = _formatTime(now);
    setState(() {
      _previousTime = _currentTime;
      _currentTime = newTime;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.linux: FadeThroughPageTransitionsBuilder(),
          },
        ),
      ),
      home: WindowFrameWidget(
        child: FlutterFlipClock(),
      ),
    );
  }

  Widget buildClock() {
    return FlipClock(
      startTime: DateTime.now(),
      digitColor: Colors.white,
      backgroundColor: Colors.black,
      digitSize: getScreenWidth(context) / 7,
      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      width: getScreenWidth(context) / 7 - 10,
      height: (getScreenWidth(context) / 7 - 10) * 2,
      screenWidth: getScreenWidth(context),
      screenHeight: getScreenHeight(context),
    );
  }

  Widget buildContent() {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: Center(
          child: FlipClockWidget(
            currentTime: _currentTime,
            previousTime: _previousTime,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "theme",
            onPressed: () {
              setState(() {
                _isDarkTheme = !_isDarkTheme;
              });
            },
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "refresh",
            onPressed: () {
              // 手动触发时间更新，用于测试动画
              _updateTime();
            },
            backgroundColor: Colors.white.withValues(alpha: .2),
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

/// 翻页时钟主组件
class FlipClockWidget extends StatelessWidget {
  final String currentTime;
  final String previousTime;

  const FlipClockWidget({
    super.key,
    required this.currentTime,
    required this.previousTime,
  });

  @override
  Widget build(BuildContext context) {
    if (currentTime.length != 6) {
      return Container(); // 防止时间格式错误
    }

    final now = DateTime.now();
    String hour = currentTime.substring(0, 2);
    String minute = currentTime.substring(2, 4);
    String second = currentTime.substring(4, 6);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 时钟外框
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF1a1a2e).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFF4a4a5e).withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: Offset(0, 10),
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 小时
              Column(
                children: [
                  FlipDigitPair(
                    currentDigits: hour,
                    previousDigits: previousTime.length >= 2 ? previousTime.substring(0, 2) : hour,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'HOURS',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              // 冒号
              ColonSeparator(),
              SizedBox(width: 20),
              // 分钟
              Column(
                children: [
                  FlipDigitPair(
                    currentDigits: minute,
                    previousDigits: previousTime.length >= 4 ? previousTime.substring(2, 4) : minute,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'MINUTES',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              // 冒号
              ColonSeparator(),
              SizedBox(width: 20),
              // 秒钟
              Column(
                children: [
                  FlipDigitPair(
                    currentDigits: second,
                    previousDigits: previousTime.length >= 6 ? previousTime.substring(4, 6) : second,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SECONDS',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        // 日期显示
        Text(
          '${now.month}月${now.day}日 ${_getWeekday(now.weekday)} 农历甘六',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  String _getWeekday(int weekday) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[weekday - 1];
  }
}

/// 数字对组件（十位和个位）
class FlipDigitPair extends StatelessWidget {
  final String currentDigits;
  final String previousDigits;

  const FlipDigitPair({
    super.key,
    required this.currentDigits,
    required this.previousDigits,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlipDigit(
          currentDigit: int.parse(currentDigits[0]),
          previousDigit: previousDigits.isNotEmpty ? int.parse(previousDigits[0]) : int.parse(currentDigits[0]),
        ),
        SizedBox(width: 8),
        FlipDigit(
          currentDigit: int.parse(currentDigits[1]),
          previousDigit: previousDigits.length >= 2 ? int.parse(previousDigits[1]) : int.parse(currentDigits[1]),
        ),
      ],
    );
  }
}

/// 冒号分隔符组件
class ColonSeparator extends StatefulWidget {
  const ColonSeparator({super.key});

  @override
  State<ColonSeparator> createState() => _ColonSeparatorState();
}

class _ColonSeparatorState extends State<ColonSeparator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: SizedBox(
            width: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 单个翻页数字组件
class FlipDigit extends StatefulWidget {
  final int currentDigit;
  final int previousDigit;

  const FlipDigit({
    super.key,
    required this.currentDigit,
    required this.previousDigit,
  });

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late Animation<double> _shadowAnimation;
  int _displayDigit = 0;
  int _targetDigit = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _displayDigit = widget.currentDigit;
    _targetDigit = widget.currentDigit;

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    // 主翻页动画，使用更自然的曲线
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // 阴影动画，增强3D效果
    _shadowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _displayDigit = _targetDigit;
            _isAnimating = false;
          });
          _controller.reset();
        }
      }
    });
  }

  @override
  void didUpdateWidget(FlipDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 只有当数字真正改变，并且没有正在动画时才触发动画
    if (oldWidget.currentDigit != widget.currentDigit && !_isAnimating) {
      _targetDigit = widget.currentDigit;
      _isAnimating = true;

      // 添加触觉反馈
      HapticFeedback.lightImpact();

      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 80,
      child: Stack(
        children: [
          // 当前数字的上半部分
          Positioned(
            top: 0,
            child: SizedBox(
              width: 60,
              height: 40,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: _buildDigitCard(_displayDigit),
                ),
              ),
            ),
          ),
          // 当前数字的下半部分
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: 60,
              height: 40,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildDigitCard(_displayDigit),
                ),
              ),
            ),
          ),
          // 翻页动画
          if (_isAnimating) ...[
            // 上半部分翻页动画
            AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                if (_flipAnimation.value <= 0.5) {
                  // 前半段：当前数字的上半部分向下翻
                  return Positioned(
                    top: 0,
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(-_flipAnimation.value * math.pi / 2),
                      child: SizedBox(
                        width: 60,
                        height: 40,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _buildDigitCard(
                              _displayDigit,
                              shadowOpacity: 0.3 + (_shadowAnimation.value * 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // 后半段：新数字的上半部分从下往上翻
                  return Positioned(
                    top: 0,
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX((_flipAnimation.value - 1) * math.pi / 2),
                      child: SizedBox(
                        width: 60,
                        height: 40,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _buildDigitCard(
                              _targetDigit,
                              shadowOpacity: 0.1 + ((1 - _shadowAnimation.value) * 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            // 下半部分翻页动画
            AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                if (_flipAnimation.value <= 0.5) {
                  // 前半段：下半部分保持不变
                  return Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: 60,
                      height: 40,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildDigitCard(
                            _displayDigit,
                            shadowOpacity: 0.3,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // 后半段：新数字的下半部分从上往下翻
                  return Positioned(
                    bottom: 0,
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX((1 - _flipAnimation.value) * math.pi / 2),
                      child: Container(
                        width: 60,
                        height: 40,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: _buildDigitCard(
                              _targetDigit,
                              shadowOpacity: 0.2 + (_shadowAnimation.value * 0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          // 中间分割线
          Positioned(
            top: 39,
            child: Container(
              width: 60,
              height: 2,
              color: Color(0xFF1a1a2e),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitCard(int digit, {double shadowOpacity = 0.3}) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF3a3a4e),
            Color(0xFF2a2a3e),
            Color(0xFF1a1a2e),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFF4a4a5e).withValues(alpha: 0.5), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: shadowOpacity),
            blurRadius: 12,
            offset: Offset(0, 6),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: shadowOpacity * 0.5),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 反光效果
          Positioned(
            top: 4,
            left: 4,
            right: 4,
            height: 20,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // 数字文本
          Center(
            child: Text(
              digit.toString(),
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'monospace',
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
