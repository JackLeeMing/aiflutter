import 'dart:async';
import 'dart:math';

import 'package:aiflutter/widgets/window.dart';
import 'package:animations/animations.dart';
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

// MARK: - 烟花控制器
/// 控制器类，管理烟花和粒子的物理效果及生命周期
class FireworksController {
  final List<Firework> _fireworks = [];
  final List<Particle> _particles = [];
  final Random _random = Random();
  late AnimationController _animationController;
  late Timer _launchTimer;
  bool isRunning = false;
  late Size _canvasSize;

  static const double _gravity = 0.05;
  static const double _friction = 0.95;
  static const int _maxTrailLength = 15;
  static const int _maxParticles = 500;
  static const int _maxFireworks = 15;

  List<Firework> get fireworks => _fireworks;
  List<Particle> get particles => _particles;

  FireworksController(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 16), // 约60fps的刷新率
    )..addListener(() {
        if (isRunning) {
          updatePhysics(_canvasSize);
          print('updatePhysics');
        }
      });
  }

  /// 启动动画和烟花发射
  void start(Size? size) {
    if (size == null) return;
    _canvasSize = size;
    isRunning = true;
    // 确保动画控制器持续循环，不会停止
    _animationController.repeat();
    // 定期发射烟花
    _launchTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (isRunning) {
        launchFirework(_canvasSize);
      }
    });
  }

  /// 停止动画和清理所有对象
  void stop() {
    if (!isRunning) return;
    isRunning = false;
    _animationController.stop();
    if (_launchTimer.isActive) {
      _launchTimer.cancel();
    }
    _fireworks.clear();
    _particles.clear();
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

  /// 随机发射一个新烟花
  void launchFirework(Size size) {
    print('launchFirework');
    if (_fireworks.length < _maxFireworks) {
      final startX = _random.nextDouble() * size.width;
      final startY = size.height;
      final targetY = _random.nextDouble() * size.height * 0.6 + size.height * 0.1; // 调整目标高度范围
      final color = _randomColor();

      _fireworks.add(Firework(
        Offset(startX, startY),
        Offset(
          (_random.nextDouble() - 0.5) * 2, // 添加轻微的水平偏移
          -_random.nextDouble() * 4 - 3, // 增加初始向上速度
        ),
        targetY,
        color,
      ));
    }
  }

  /// 在指定位置爆炸并生成粒子
  void _explode(Offset position, Color color) {
    final particleCount = _random.nextInt(50) + 70;
    for (var i = 0; i < particleCount; i++) {
      if (_particles.length < _maxParticles) {
        final angle = _random.nextDouble() * 2 * pi;
        final speed = _random.nextDouble() * 5 + 1;
        final velocity = Offset(cos(angle) * speed, sin(angle) * speed);
        final decay = _random.nextDouble() * 0.03 + 0.01;
        _particles.add(Particle(position, velocity, color, decay));
      }
    }
  }

  /// 生成一个随机的颜色
  Color _randomColor() {
    return HSLColor.fromAHSL(1.0, _random.nextDouble() * 360, 1.0, 0.5).toColor();
  }

  void dispose() {
    _animationController.dispose();
  }
}

// MARK: - 自定义绘制器

/// 负责绘制烟花和粒子的 CustomPainter
class FireworksPainter extends CustomPainter {
  final List<Firework> fireworks;
  final List<Particle> particles;

  FireworksPainter(this.fireworks, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制半透明黑色矩形，制造拖尾效果
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.black.withValues(alpha: .1));

    // 使用 BlendMode.plus 在重叠时叠加颜色，产生发光效果
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..blendMode = BlendMode.plus);

    // 绘制烟花
    for (final firework in fireworks) {
      canvas.drawCircle(firework.position, 2, Paint()..color = firework.color);
    }

    // 绘制粒子和拖尾
    for (final particle in particles) {
      // 绘制粒子本体
      final paint = Paint()..color = particle.color.withValues(alpha: particle.alpha);
      canvas.drawCircle(particle.position, 1.5, paint);

      // 绘制拖尾
      for (var i = 0; i < particle.trail.length; i++) {
        final trailPaint = Paint()
          ..color = particle.color.withValues(alpha: particle.alpha * (i / particle.trail.length))
          ..style = PaintingStyle.fill;
        final radius = 1.5 * (i / particle.trail.length);
        canvas.drawCircle(particle.trail[i], radius, trailPaint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant FireworksPainter oldDelegate) {
    return oldDelegate.fireworks != fireworks || oldDelegate.particles != particles;
  }
}

// MARK: - 主页面

/// 包含烟花动画和控制按钮的主页面
class FireworksApp extends StatefulWidget {
  const FireworksApp({super.key});

  @override
  State<FireworksApp> createState() => _FireworksPageState();
}

class _FireworksPageState extends State<FireworksApp> with SingleTickerProviderStateMixin {
  late final FireworksController _fireworksController;

  @override
  void initState() {
    super.initState();
    // 驱动动画的控制器
    _fireworksController = FireworksController(this);
    // 页面加载后自动开始动画
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fireworksController.start(context.size);
    });
  }

  @override
  void dispose() {
    _fireworksController.dispose();
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
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(), // NEW
            TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(), // NEW
            TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(), // NEW
            TargetPlatform.windows: FadeThroughPageTransitionsBuilder(), // NEW
            TargetPlatform.linux: FadeThroughPageTransitionsBuilder(), // NEW
          },
        ),
      ),
      home: WindowFrameWidget(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // CustomPaint 绘制烟花效果
              AnimatedBuilder(
                animation: _fireworksController._animationController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: FireworksPainter(
                      _fireworksController.fireworks,
                      _fireworksController.particles,
                    ),
                  );
                },
              ),
              // 控制按钮
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _fireworksController.stop();
                        },
                        child: const Text('停止'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // 先停止现有动画，然后重新开始
                          _fireworksController.stop();
                          _fireworksController.start(context.size);
                        },
                        child: const Text('开始'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
