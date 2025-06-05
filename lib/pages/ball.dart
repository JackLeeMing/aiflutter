import 'dart:math';

import 'package:aiflutter/models/ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class BallAnimationPage extends StatefulWidget {
  const BallAnimationPage({super.key});

  @override
  State<BallAnimationPage> createState() => _BallAnimationPageState();
}

class _BallAnimationPageState extends State<BallAnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final double _ballSize = 50.0; // 小球直径
  final double _gravity = 980.0; // 重力加速度（像素/秒²）
  final double _friction = 0.5; // 摩擦系数（每秒减少速度的比例）

  // 小球状态
  List<Ball> _balls = [];
  final int _ballCount = 10; // 两个小球

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(_updatePosition);

    // 初始化小球
    _balls = List.generate(
        _ballCount,
        (index) => Ball(
              x: _random.nextDouble() * 100,
              y: _random.nextDouble() * 100,
              vx: _random.nextDouble() * 200 - 100,
              vy: 0.0,
              color: index % 2 == 0 ? Colors.blue : Colors.red, // 不同颜色区分小球
            ));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updatePosition() {
    setState(() {
      final size = MediaQuery.of(context).size;
      final maxX = size.width - _ballSize;
      final maxY = size.height - _ballSize - kToolbarHeight * 2;
      final dt = (_controller.lastElapsedDuration?.inMilliseconds ?? 16) / 1000.0;

      // 更新每个小球
      for (var ball in _balls) {
        // 弹簧动画优先
        if (ball.springX != null || ball.springY != null) {
          final springTime = (dt * 1000 - ball.springStartTime).clamp(0.0, double.infinity) / 1000.0;
          if (ball.springX != null) {
            ball.x = ball.springStartX + ball.springX!.x(springTime);
            if (ball.springX!.isDone(springTime)) {
              ball.springX = null;
              ball.vx = (_random.nextDouble() * 200 - 100);
            }
          }
          if (ball.springY != null) {
            ball.y = ball.springStartY + ball.springY!.x(springTime);
            if (ball.springY!.isDone(springTime)) {
              ball.springY = null;
              ball.vy = (_random.nextDouble() * 200 - 100);
            }
          }
          continue;
        }

        // 常规运动：重力和摩擦力
        ball.vy += _gravity * dt;
        ball.vx *= (1 - _friction * dt);
        ball.vy *= (1 - _friction * dt);

        // 检查静止条件
        if (ball.y >= maxY && (ball.vx.abs() < 1.0 && ball.vy.abs() < 1.0)) {
          ball.vx = 0;
          ball.vy = 0;
          ball.y = maxY;
          continue;
        }

        // 更新位置
        ball.x += ball.vx * dt;
        ball.y += ball.vy * dt;

        // 边界检测与弹簧回弹
        if (ball.x <= 0 || ball.x >= maxX) {
          ball.springStartX = ball.x <= 0 ? 0 : maxX;
          ball.x = ball.springStartX;
          ball.springStartTime = dt * 1000;
          ball.springX = SpringSimulation(
            SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
            0.0,
            ball.x <= 0 ? 50.0 : -50.0,
            ball.vx,
          );
          ball.vx = 0;
        }
        if (ball.y <= 0 || ball.y >= maxY) {
          ball.springStartY = ball.y <= 0 ? 0 : maxY;
          ball.y = ball.springStartY;
          ball.springStartTime = dt * 1000;
          ball.springY = SpringSimulation(
            SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
            0.0,
            ball.y <= 0 ? 50.0 : -50.0,
            ball.vy,
          );
          ball.vy = 0;
        }
      }

      // 检测小球间碰撞
      for (int i = 0; i < _balls.length - 1; i++) {
        for (int j = i + 1; j < _balls.length; j++) {
          final ball1 = _balls[i];
          final ball2 = _balls[j];

          // 跳过弹簧动画中的小球
          if (ball1.springX != null || ball1.springY != null || ball2.springX != null || ball2.springY != null) {
            continue;
          }

          // 计算距离
          final dx = ball2.x - ball1.x;
          final dy = ball2.y - ball1.y;
          final distance = sqrt(dx * dx + dy * dy);
          final minDistance = _ballSize; // 两小球直径（假设接触时距离为 2 * 半径）

          // 检测碰撞
          if (distance < minDistance) {
            // 计算碰撞法线方向
            final nx = dx / distance; // 单位向量 X 分量
            final ny = dy / distance; // 单位向量 Y 分量

            // 计算沿法线方向的相对速度
            final v1n = ball1.vx * nx + ball1.vy * ny; // ball1 法线速度
            final v2n = ball2.vx * nx + ball2.vy * ny; // ball2 法线速度

            // 弹性碰撞：交换法线速度（质量相等）
            final v1nAfter = v2n;
            final v2nAfter = v1n;

            // 更新速度（仅法线方向）
            ball1.vx += (v1nAfter - v1n) * nx;
            ball1.vy += (v1nAfter - v1n) * ny;
            ball2.vx += (v2nAfter - v2n) * nx;
            ball2.vy += (v2nAfter - v2n) * ny;

            // 防止小球重叠：调整位置
            final overlap = (minDistance - distance) / 2;
            ball1.x -= overlap * nx;
            ball1.y -= overlap * ny;
            ball2.x += overlap * nx;
            ball2.y += overlap * ny;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('小球弹性碰撞')),
      body: Stack(
        children: _balls.map((ball) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: ball.x,
                top: ball.y,
                child: child!,
              );
            },
            child: Container(
              width: _ballSize,
              height: _ballSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ball.color,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // 重置小球
            _balls = List.generate(
                _ballCount,
                (index) => Ball(
                      x: _random.nextDouble() * (MediaQuery.of(context).size.width - _ballSize),
                      y: 0.0,
                      vx: _random.nextDouble() * 200 - 100,
                      vy: 0.0,
                      color: index % 2 != 0 ? Colors.blue : Colors.red,
                    ));
            if (!_controller.isAnimating) {
              _controller.repeat();
            }
          });
        },
        tooltip: '重置',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class TenBallPage extends StatefulWidget {
  const TenBallPage({super.key});

  @override
  State<TenBallPage> createState() => _TenBallPageState();
}

class _TenBallPageState extends State<TenBallPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final double _ballSize = 20.0; // 小球直径
  final double _gravity = 980.0; // 重力加速度（像素/秒²）
  final double _friction = 0.5; // 摩擦系数（每秒减少速度的比例）
  final double _restitution = 0.8; // 弹性系数（0.0 到 1.0）
  final int _ballCount = 10; // 小球数量
  final double _gridSize = 50.0; // 网格大小
  List<Ball> _balls = [];
  late ValueNotifier<List<Ball>> _ballsNotifier;

  @override
  void initState() {
    super.initState();
    _ballsNotifier = ValueNotifier<List<Ball>>([]);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(() {
        setState(() {
          _updatePosition();
        });
      });

    // 初始化小球
    _resetBalls();
    _controller.repeat();
  }

  void _resetBalls() {
    _balls = List.generate(
        _ballCount,
        (index) => Ball(
              x: _random.nextDouble() * 300,
              y: _random.nextDouble() * 100,
              vx: _random.nextDouble() * 200 - 100,
              vy: 0.0,
              color: Color.fromRGBO(
                _random.nextInt(256),
                _random.nextInt(256),
                _random.nextInt(256),
                1.0,
              ),
            ));
    _ballsNotifier.value = _balls;
  }

  @override
  void dispose() {
    _controller.dispose();
    _ballsNotifier.dispose();
    super.dispose();
  }

  void _updatePosition() {
    // print("_updatePosition");
    final size = MediaQuery.of(context).size;
    final maxX = size.width - _ballSize;
    final maxY = size.height - _ballSize - kToolbarHeight * 2;
    final dt = (_controller.lastElapsedDuration?.inMilliseconds ?? 16) / 1000.0;

    // 构建网格
    final grid = <int, List<int>>{};
    for (int i = 0; i < _balls.length; i++) {
      final ball = _balls[i];
      final gridX = (ball.x / _gridSize).floor();
      final gridY = (ball.y / _gridSize).floor();
      final key = gridX * 1000 + gridY; // 简单哈希
      grid[key] ??= [];
      grid[key]!.add(i);
    }

    // 更新每个小球
    for (var ball in _balls) {
      // 弹簧动画优先
      if (ball.springX != null || ball.springY != null) {
        final springTime = (dt * 1000 - ball.springStartTime).clamp(0.0, double.infinity) / 1000.0;
        if (ball.springX != null) {
          ball.x = ball.springStartX + ball.springX!.x(springTime);
          if (ball.springX!.isDone(springTime)) {
            ball.springX = null;
            ball.vx = (_random.nextDouble() * 200 - 100);
          }
        }
        if (ball.springY != null) {
          ball.y = ball.springStartY + ball.springY!.x(springTime);
          if (ball.springY!.isDone(springTime)) {
            ball.springY = null;
            ball.vy = (_random.nextDouble() * 200 - 100);
          }
        }
        continue;
      }

      // 常规运动：重力和摩擦力
      ball.vy += _gravity * dt;
      ball.vx *= (1 - _friction * dt);
      ball.vy *= (1 - _friction * dt);

      // 检查静止条件
      if (ball.y >= maxY && (ball.vx.abs() < 1.0 && ball.vy.abs() < 1.0)) {
        ball.vx = 0;
        ball.vy = 0;
        ball.y = maxY;
        continue;
      }

      // 更新位置
      ball.x += ball.vx * dt;
      ball.y += ball.vy * dt;

      // 边界检测与弹簧回弹
      if (ball.x <= 0 || ball.x >= maxX) {
        ball.springStartX = ball.x <= 0 ? 0 : maxX;
        ball.x = ball.springStartX;
        ball.springStartTime = dt * 1000;
        ball.springX = SpringSimulation(
          SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
          0.0,
          ball.x <= 0 ? 50.0 : -50.0,
          ball.vx,
        );
        ball.vx = 0;
      }
      if (ball.y <= 0 || ball.y >= maxY) {
        ball.springStartY = ball.y <= 0 ? 0 : maxY;
        ball.y = ball.springStartY;
        ball.springStartTime = dt * 1000;
        ball.springY = SpringSimulation(
          SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
          0.0,
          ball.y <= 0 ? 50.0 : -50.0,
          ball.vy,
        );
        ball.vy = 0;
      }
    }

    // 检测碰撞（网格优化）
    final processedPairs = <String>{}; // 避免重复检测
    for (final key in grid.keys) {
      final gridX = key ~/ 1000;
      final gridY = key % 1000;
      // 检查当前网格和邻近网格
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          final neighborKey = (gridX + dx) * 1000 + (gridY + dy);
          final currentBalls = grid[key] ?? [];
          final neighborBalls = grid[neighborKey] ?? [];

          for (final i in currentBalls) {
            for (final j in neighborBalls) {
              if (i >= j) continue; // 避免重复检测
              final pair = '$i-$j';
              if (processedPairs.contains(pair)) continue;
              processedPairs.add(pair);

              final ball1 = _balls[i];
              final ball2 = _balls[j];

              // 跳过弹簧动画中的小球
              if (ball1.springX != null || ball1.springY != null || ball2.springX != null || ball2.springY != null) {
                continue;
              }

              // 计算距离
              final dx = ball2.x - ball1.x;
              final dy = ball2.y - ball1.y;
              final distance = sqrt(dx * dx + dy * dy);
              final minDistance = _ballSize;

              // 检测碰撞
              if (distance < minDistance) {
                // 计算碰撞法线
                final nx = distance > 0 ? dx / distance : 1.0;
                final ny = distance > 0 ? dy / distance : 0.0;

                // 法线方向速度
                final v1n = ball1.vx * nx + ball1.vy * ny;
                final v2n = ball2.vx * nx + ball2.vy * ny;

                // 弹性碰撞（带弹性系数）
                final v1nAfter = v2n * _restitution;
                final v2nAfter = v1n * _restitution;

                // 更新速度
                ball1.vx += (v1nAfter - v1n) * nx;
                ball1.vy += (v1nAfter - v1n) * ny;
                ball2.vx += (v2nAfter - v2n) * nx;
                ball2.vy += (v2nAfter - v2n) * ny;

                // 防止重叠
                final overlap = (minDistance - distance) / 2;
                ball1.x -= overlap * nx;
                ball1.y -= overlap * ny;
                ball2.x += overlap * nx;
                ball2.y += overlap * ny;
              }
            }
          }
        }
      }
    }

    // 更新 ValueNotifier
    _ballsNotifier.value = _balls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('多小球弹性碰撞（优化）')),
      body: ValueListenableBuilder<List<Ball>>(
        valueListenable: _ballsNotifier,
        builder: (context, balls, child) {
          return Stack(
            children: balls.map((ball) {
              return Positioned(
                left: ball.x,
                top: ball.y,
                child: Container(
                  width: _ballSize,
                  height: _ballSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ball.color,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetBalls,
        tooltip: '重置',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
