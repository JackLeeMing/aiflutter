import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// MARK: - 数据模型

/// 粒子数据模型
class Particle {
  Offset position;
  Offset velocity;
  Color color;
  double decay;
  double alpha = 1.0;
  List<Offset> trail = []; // 用于记录粒子的历史位置

  Particle(this.position, this.velocity, this.color, this.decay);
}

/// 烟花数据模型
class Firework {
  Offset position;
  Offset velocity;
  double targetY;
  Color color;

  Firework(this.position, this.velocity, this.targetY, this.color);
}

// MARK: - 浪漫动画状态枚举
enum RomanticAnimationState {
  initial, // 初始状态，等待3秒
  countdown, // 10秒倒计时
  loveText, // 显示"我喜欢你"文字
  heartAnimation, // 跳动的爱心
  heartWithText, // 心形上显示文字的组合效果
}

// MARK: - 翻页数字Widget
/// 翻页数字效果Widget，模拟翻页时钟
class FlipClockDigit extends StatefulWidget {
  final int currentValue;
  final int? previousValue;
  final Duration animationDuration;

  const FlipClockDigit({
    super.key,
    required this.currentValue,
    this.previousValue,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<FlipClockDigit> createState() => _FlipClockDigitState();
}

class _FlipClockDigitState extends State<FlipClockDigit> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // 更快的动画
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void didUpdateWidget(FlipClockDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue) {
      _controller.forward(from: 0.0);
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
      width: 160,
      height: 200,
      child: Stack(
        children: [
          // 总是显示当前数字作为底层
          _buildDigitCard(widget.currentValue),

          // 动画层：只在数字变化时显示
          if (_controller.isAnimating)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    // 上一个数字（淡出+缩小）
                    if (widget.previousValue != null)
                      Transform.scale(
                        scale: 1.0 - _controller.value * 0.2,
                        child: Opacity(
                          opacity: 1.0 - _controller.value,
                          child: _buildDigitCard(widget.previousValue!),
                        ),
                      ),

                    // 当前数字（滑入+放大）
                    Transform.translate(
                      offset: Offset(0, (1 - _slideAnimation.value) * 30),
                      child: Transform.scale(
                        scale: 0.7 + (_slideAnimation.value * 0.3),
                        child: Opacity(
                          opacity: _slideAnimation.value,
                          child: _buildDigitCard(widget.currentValue),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

          // 中间分割线
          Positioned(
            top: 99,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建数字卡片 - 简化版本提升性能
  Widget _buildDigitCard(int value) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A2A2A),
            Color(0xFF1A1A1A),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -2,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.blue,
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 12.0,
                color: Colors.purple,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MARK: - 烟花控制器
/// 控制器类，管理烟花和粒子的物理效果及生命周期
class FireworksController extends ChangeNotifier {
  final List<Firework> _fireworks = [];
  final List<Particle> _particles = [];
  final Random _random = Random();
  Timer? _launchTimer;
  Timer? _updateTimer;
  Timer? _romanticTimer;
  bool isRunning = false;
  Size _canvasSize = Size.zero;

  // 浪漫动画相关状态
  RomanticAnimationState _romanticState = RomanticAnimationState.initial;
  double _heartScale = 1.0;
  double _heartAlpha = 1.0;
  bool _heartBeating = false;
  bool _heartFadingOut = false;
  bool _animationCompleted = false;

  // 打字机效果相关状态
  String _displayedText = '';
  int _currentCharIndex = 0;
  final String _fullText = '我喜欢你';
  Timer? _typingTimer;

  static const double _gravity = 0.05;
  static const double _friction = 0.95;
  static const int _maxTrailLength = 15;
  static const int _maxParticles = 400; // 适当增加支持多烟花
  static const int _maxFireworks = 12; // 适当增加支持多烟花
  static const int _minFireworksPerLaunch = 3; // 每次最少发射数量
  static const int _maxFireworksPerLaunch = 12; // 每次最多发射数量

  List<Firework> get fireworks => _fireworks;
  List<Particle> get particles => _particles;

  // 浪漫动画状态getter
  RomanticAnimationState get romanticState => _romanticState;
  double get heartScale => _heartScale;
  double get heartAlpha => _heartAlpha;
  bool get animationCompleted => _animationCompleted;
  String get displayedText => _displayedText;

  /// 启动动画和烟花发射
  void start(Size size) {
    if (size.isEmpty) return;
    stop(); // 先停止之前的动画

    _canvasSize = size;
    isRunning = true;
    _romanticState = RomanticAnimationState.initial;
    _heartScale = 1.0;
    _heartAlpha = 1.0;
    _heartBeating = false;
    _heartFadingOut = false;
    _animationCompleted = false;

    // 重置打字机效果
    _displayedText = '';
    _currentCharIndex = 0;

    // 使用60fps的更新频率
    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (isRunning) {
        updatePhysics(_canvasSize);
        _updateHeartAnimation(); // 更新爱心动画
        notifyListeners(); // 通知UI更新
      }
    });

    // 定期发射烟花组
    _launchTimer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (isRunning) {
        launchFireworkBatch(_canvasSize);
      }
    });

    // 立即发射第一批烟花
    launchFireworkBatch(_canvasSize);

    // 启动浪漫动画序列
    _startRomanticSequence();
  }

  /// 停止动画和清理所有对象
  void stop() {
    isRunning = false;
    _updateTimer?.cancel();
    _updateTimer = null;
    _launchTimer?.cancel();
    _launchTimer = null;
    _romanticTimer?.cancel();
    _romanticTimer = null;
    _typingTimer?.cancel();
    _typingTimer = null;
    _fireworks.clear();
    _particles.clear();
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
    if (_canvasSize != Size.zero) {
      start(_canvasSize);
    }
  }

  /// 更新所有烟花和粒子的物理状态
  void updatePhysics(Size size) {
    // 更新并移除已爆炸的烟花
    _fireworks.removeWhere((firework) {
      firework.position += firework.velocity;
      firework.velocity = Offset(firework.velocity.dx, firework.velocity.dy + _gravity * 0.5);

      if (firework.velocity.dy > 0 || firework.position.dy < firework.targetY) {
        _explode(firework.position, firework.color);
        return true;
      }
      return false;
    });

    // 更新并移除已消失的粒子
    _particles.removeWhere((particle) {
      // 更新拖尾
      particle.trail.add(particle.position);
      if (particle.trail.length > _maxTrailLength) {
        particle.trail.removeAt(0);
      }

      // 应用摩擦力和重力
      particle.velocity = Offset(particle.velocity.dx * _friction, particle.velocity.dy * _friction + _gravity);

      // 移动粒子
      particle.position += particle.velocity;

      // 逐渐消失
      particle.alpha -= particle.decay;

      return particle.alpha <= 0;
    });
  }

  /// 批量发射多个烟花
  void launchFireworkBatch(Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // 随机决定本次发射的烟花数量
    final launchCount = _random.nextInt(_maxFireworksPerLaunch - _minFireworksPerLaunch + 1) + _minFireworksPerLaunch;
    // logger.d("launchCount: $launchCount");
    for (int i = 0; i < launchCount; i++) {
      if (_fireworks.length < _maxFireworks) {
        // 添加一些延迟让烟花不完全同时发射，形成更自然的效果
        Timer(Duration(milliseconds: i * 150), () {
          if (isRunning) {
            launchFirework(size);
          }
        });
      }
    }
  }

  /// 壮观发射 - 手动触发大量烟花
  void launchSpectacularBatch(Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    const spectacularCount = 32; // 壮观模式发射8颗

    for (int i = 0; i < spectacularCount; i++) {
      // 稍微缩短间隔时间，制造更密集的效果
      Timer(Duration(milliseconds: i * 100), () {
        if (isRunning && _fireworks.length < _maxFireworks + 4) {
          // 允许超出一些限制
          launchFirework(size);
        }
      });
    }
  }

  /// 随机发射一个新烟花
  void launchFirework(Size size) {
    if (_fireworks.length < _maxFireworks && size.width > 0 && size.height > 0) {
      final startX = _random.nextDouble() * size.width;
      final startY = size.height;
      final targetY = _random.nextDouble() * size.height * 0.4 + size.height * 0.2; // 调整目标高度范围
      final color = _randomColor();

      _fireworks.add(Firework(
        Offset(startX, startY),
        Offset(
          (_random.nextDouble() - 0.5) * 1, // 减少水平偏移
          -_random.nextDouble() * 6 - 8, // 增加初始向上速度
        ),
        targetY,
        color,
      ));
    }
  }

  /// 在指定位置爆炸并生成粒子
  void _explode(Offset position, Color color) {
    final particleCount = _random.nextInt(30) + 40; // 减少粒子数量
    for (var i = 0; i < particleCount; i++) {
      if (_particles.length < _maxParticles) {
        final angle = _random.nextDouble() * 2 * pi;
        final speed = _random.nextDouble() * 8 + 2; // 增加速度
        final velocity = Offset(cos(angle) * speed, sin(angle) * speed);
        final decay = _random.nextDouble() * 0.02 + 0.015; // 调整衰减速度
        _particles.add(Particle(position, velocity, color, decay));
      }
    }
  }

  /// 生成一个随机的颜色
  Color _randomColor() {
    return HSLColor.fromAHSL(1.0, _random.nextDouble() * 360, 1.0, 0.5).toColor();
  }

  /// 启动浪漫动画序列
  void _startRomanticSequence() {
    // 延时3秒后开始倒计时
    _romanticTimer = Timer(const Duration(seconds: 3), () {
      if (isRunning) {
        _romanticState = RomanticAnimationState.countdown;
      }
    });
  }

  /// 开始10秒倒计时
  void startCountdown() {
    // _showLoveText();
    // _romanticState = RomanticAnimationState.heartWithText; // loveText
    // _displayedText = '';
    // _currentCharIndex = 0;
    // notifyListeners();
    _showLoveText();
  }

  void startCountUp(int number) {
    if (number >= 10) {
      _showLoveText();
    }
  }

  /// 显示"我喜欢你"文字
  void _showLoveText() {
    _romanticState = RomanticAnimationState.heartWithText; // loveText
    _displayedText = '';
    _currentCharIndex = 0;
    notifyListeners();

    // 开始打字机效果
    _startTypingEffect();

    // 3秒后显示纯心形动画
    _romanticTimer = Timer(const Duration(seconds: 3), () {
      if (isRunning) {
        _startHeartAnimation();
      }
    });
  }

  /// 开始打字机效果
  void _startTypingEffect() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_currentCharIndex < _fullText.length) {
        _displayedText += _fullText[_currentCharIndex];
        _currentCharIndex++;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  /// 开始纯心形跳动动画
  void _startHeartAnimation() {
    _romanticState = RomanticAnimationState.heartAnimation;
    _heartBeating = true;
    _heartAlpha = 1.0;
    _heartFadingOut = false;
    notifyListeners();

    // 10秒后开始淡出效果
    _romanticTimer = Timer(const Duration(seconds: 10), () {
      if (isRunning && _romanticState == RomanticAnimationState.heartAnimation) {
        _startHeartFadeOut();
      }
    });
  }

  /// 开始心形淡出效果
  void _startHeartFadeOut() {
    _heartFadingOut = true;
    notifyListeners();
  }

  /// 更新爱心动画效果
  void _updateHeartAnimation() {
    if (_heartBeating &&
        (_romanticState == RomanticAnimationState.heartAnimation ||
            _romanticState == RomanticAnimationState.heartWithText)) {
      // 心跳效果：使用正弦波控制缩放
      final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
      _heartScale = 1.0 + 0.3 * sin(time * 3.0); // 3.0 控制心跳频率

      // 处理淡出效果
      if (_heartFadingOut) {
        _heartAlpha -= 0.02; // 控制淡出速度
        if (_heartAlpha <= 0) {
          _heartAlpha = 0;
          _heartBeating = false;
          _romanticState = RomanticAnimationState.initial; // 重置到初始状态
          _animationCompleted = true; // 标记动画完成
        }
      }
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}

// MARK: - 自定义绘制器

/// 自定义心形绘制器
class HeartPainter extends CustomPainter {
  final double scale;
  final Color color;
  final double alpha;

  HeartPainter({
    required this.scale,
    required this.color,
    this.alpha = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 心形的基础大小
    final baseSize = min(size.width, size.height) * 0.4;

    // 心形中心点
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // 定义多个心形的配置：大小比例、位置偏移、透明度
    final hearts = [
      // 主心形
      {'scale': 1.0, 'offsetX': 0.0, 'offsetY': 0.0, 'alpha': 1.0},
      // 左上小心形
      {'scale': 0.3, 'offsetX': -80.0, 'offsetY': -60.0, 'alpha': 0.6},
      // 右上小心形
      {'scale': 0.25, 'offsetX': 85.0, 'offsetY': -70.0, 'alpha': 0.5},
      // 左下小心形
      {'scale': 0.2, 'offsetX': -90.0, 'offsetY': 80.0, 'alpha': 0.4},
      // 右下小心形
      {'scale': 0.28, 'offsetX': 75.0, 'offsetY': 85.0, 'alpha': 0.55},
      // 额外的小心形
      {'scale': 0.15, 'offsetX': -40.0, 'offsetY': -120.0, 'alpha': 0.3},
      {'scale': 0.18, 'offsetX': 110.0, 'offsetY': 20.0, 'alpha': 0.35},
    ];

    // 绘制每个心形
    for (final heartConfig in hearts) {
      final heartScale = heartConfig['scale']!;
      final offsetX = heartConfig['offsetX']!;
      final offsetY = heartConfig['offsetY']!;
      final heartAlpha = heartConfig['alpha']! * alpha;

      _drawSingleHeart(canvas, centerX + offsetX, centerY + offsetY, baseSize * heartScale * scale, heartAlpha);
    }
  }

  /// 绘制单个心形
  void _drawSingleHeart(Canvas canvas, double centerX, double centerY, double heartSize, double heartAlpha) {
    if (heartAlpha <= 0) return;

    final paint = Paint()
      ..color = color.withValues(alpha: heartAlpha)
      ..style = PaintingStyle.fill;

    // 绘制心形路径
    final path = Path();

    // 心形的数学公式参数化绘制
    for (double t = 0; t <= 2 * pi; t += 0.01) {
      // 心形的参数方程
      final x = 16 * pow(sin(t), 3);
      final y = -(13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t));

      final scaledX = centerX + x * heartSize / 32;
      final scaledY = centerY + y * heartSize / 32;

      if (t == 0) {
        path.moveTo(scaledX, scaledY);
      } else {
        path.lineTo(scaledX, scaledY);
      }
    }
    path.close();

    // 为较大的心形绘制发光效果
    if (heartSize > 20) {
      for (int i = 0; i < 2; i++) {
        final glowSize = heartSize * (1.0 + i * 0.1);
        final glowAlpha = heartAlpha * 0.08 * (2 - i);

        final glowPath = Path();
        for (double t = 0; t <= 2 * pi; t += 0.02) {
          final x = 16 * pow(sin(t), 3);
          final y = -(13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t));

          final scaledX = centerX + x * glowSize / 32;
          final scaledY = centerY + y * glowSize / 32;

          if (t == 0) {
            glowPath.moveTo(scaledX, scaledY);
          } else {
            glowPath.lineTo(scaledX, scaledY);
          }
        }
        glowPath.close();

        canvas.drawPath(
            glowPath,
            Paint()
              ..color = color.withValues(alpha: glowAlpha)
              ..style = PaintingStyle.fill
              ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15.0 + i * 8));
      }
    }

    // 绘制主心形
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant HeartPainter oldDelegate) {
    return oldDelegate.scale != scale || oldDelegate.color != color || oldDelegate.alpha != alpha;
  }
}

/// 负责绘制烟花和粒子的 CustomPainter
class FireworksPainter extends CustomPainter {
  final List<Firework> fireworks;
  final List<Particle> particles;

  FireworksPainter(this.fireworks, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制烟花
    for (final firework in fireworks) {
      final paint = Paint()
        ..color = firework.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(firework.position, 3, paint);
      // 添加发光效果
      final glowPaint = Paint()
        ..color = firework.color.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(firework.position, 6, glowPaint);
    }

    // 绘制粒子和拖尾
    for (final particle in particles) {
      // 绘制粒子本体
      final paint = Paint()..color = particle.color.withValues(alpha: particle.alpha);
      canvas.drawCircle(particle.position, 2, paint);

      // 绘制拖尾
      for (var i = 0; i < particle.trail.length; i++) {
        final trailAlpha = particle.alpha * (i / particle.trail.length) * 0.5;
        if (trailAlpha > 0.1) {
          final trailPaint = Paint()
            ..color = particle.color.withValues(alpha: trailAlpha)
            ..style = PaintingStyle.fill;
          final radius = 2 * (i / particle.trail.length);
          canvas.drawCircle(particle.trail[i], radius, trailPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant FireworksPainter oldDelegate) {
    return oldDelegate.fireworks != fireworks || oldDelegate.particles != particles;
  }
}
