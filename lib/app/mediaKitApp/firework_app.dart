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
class FireworksController extends ChangeNotifier {
  final List<Firework> _fireworks = [];
  final List<Particle> _particles = [];
  final Random _random = Random();
  Timer? _launchTimer;
  Timer? _updateTimer;
  bool isRunning = false;
  Size _canvasSize = Size.zero;

  static const double _gravity = 0.05;
  static const double _friction = 0.95;
  static const int _maxTrailLength = 15;
  static const int _maxParticles = 400; // 适当增加支持多烟花
  static const int _maxFireworks = 12; // 适当增加支持多烟花
  static const int _minFireworksPerLaunch = 2; // 每次最少发射数量
  static const int _maxFireworksPerLaunch = 5; // 每次最多发射数量

  List<Firework> get fireworks => _fireworks;
  List<Particle> get particles => _particles;

  /// 启动动画和烟花发射
  void start(Size size) {
    if (size.isEmpty) return;
    stop(); // 先停止之前的动画

    _canvasSize = size;
    isRunning = true;

    // 使用60fps的更新频率
    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (isRunning) {
        updatePhysics(_canvasSize);
        notifyListeners(); // 通知UI更新
      }
    });

    // 定期发射烟花组
    _launchTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (isRunning) {
        launchFireworkBatch(_canvasSize);
      }
    });

    // 立即发射第一批烟花
    launchFireworkBatch(_canvasSize);
  }

  /// 停止动画和清理所有对象
  void stop() {
    isRunning = false;
    _updateTimer?.cancel();
    _updateTimer = null;
    _launchTimer?.cancel();
    _launchTimer = null;
    _fireworks.clear();
    _particles.clear();
    notifyListeners();
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

    const spectacularCount = 8; // 壮观模式发射8颗

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

  @override
  void dispose() {
    stop();
    super.dispose();
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

// MARK: - 主页面

/// 包含烟花动画和控制按钮的主页面
class FireworksApp extends StatefulWidget {
  const FireworksApp({super.key});

  @override
  State<FireworksApp> createState() => _FireworksPageState();
}

class _FireworksPageState extends State<FireworksApp> {
  late final FireworksController _fireworksController;

  @override
  void initState() {
    super.initState();
    _fireworksController = FireworksController();
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
          body: LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              return Stack(
                children: [
                  // CustomPaint 绘制烟花效果
                  ListenableBuilder(
                    listenable: _fireworksController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: size,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 壮观发射按钮
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: _fireworksController.isRunning
                                ? () {
                                    _fireworksController.launchSpectacularBatch(size);
                                  }
                                : null,
                            child: const Text('💥 壮观发射'),
                          ),
                          const SizedBox(height: 16),
                          // 控制按钮
                          Row(
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
                                  _fireworksController.start(size);
                                },
                                child: const Text('开始'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
