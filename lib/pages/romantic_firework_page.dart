import 'dart:math';

import 'package:aiflutter/widgets/flip_panel.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';

import './firworks/widgets.dart';

// MARK: - 主页面

/// 包含烟花动画和控制按钮的主页面
class FireworksPage extends StatefulWidget {
  const FireworksPage({super.key});

  @override
  State<FireworksPage> createState() => _FireworksPageState();
}

class _FireworksPageState extends State<FireworksPage> {
  late final FireworksController _fireworksController;
  var isRunning = true;
  final countNumber = 10;

  @override
  void initState() {
    super.initState();
    _fireworksController = FireworksController();
    // 注册一个回调，在下一帧绘制完成后执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.size != null) {
        _fireworksController.start(context.size!);
      }
    });
  }

  @override
  void dispose() {
    _fireworksController.dispose();
    super.dispose();
  }

  /// 构建浪漫动画Widget
  Widget _buildRomanticAnimation() {
    switch (_fireworksController.romanticState) {
      case RomanticAnimationState.initial:
        return const SizedBox.shrink(); // 初始状态不显示任何内容

      case RomanticAnimationState.countdown:
        return _buildCountdownWidget();

      case RomanticAnimationState.loveText:
        return _buildLoveTextWidget();
      case RomanticAnimationState.heartWithText:
        return _buildHeartWithTextWidget();
      case RomanticAnimationState.heartAnimation:
        return _buildHeartWidget();
    }
  }

  Widget buildFlip() {
    return FlipPanel.builder(
      onCountComplete: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // 确保在 build 方法完成后再调用
          _fireworksController.startCountdown();
        });
      },
      direction: FlipDirection.down,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          width: 102.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(41, 41, 41, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '${countNumber - index}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 80.0,
              color: Colors.white,
            ),
          ),
        );
      },
      itemsCount: countNumber,
      period: const Duration(milliseconds: 1000),
      loop: -1,
    );
  }

  /// 构建倒计时Widget
  Widget _buildCountdownWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 标题文字
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
            ),
            child: const Text(
              '开始倒计时',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.pink,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          // 翻页数字
          buildFlip(),
          const SizedBox(height: 20),

          // 底部提示文字
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              '准备好了吗？',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                shadows: [
                  Shadow(
                    blurRadius: 8.0,
                    color: Colors.blue,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建"我喜欢你"文字Widget
  Widget _buildLoveTextWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景心形粒子效果
          ..._buildBackgroundHearts(),

          // 主文字容器
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.withValues(alpha: 0.9),
                  Colors.purple.withValues(alpha: 0.7),
                  Colors.red.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withValues(alpha: 0.6),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.4),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 主文字 - 打字机效果
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: Text(
                    key: ValueKey(_fireworksController.displayedText),
                    _fireworksController.displayedText,
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 12,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Colors.white, Colors.yellow, Colors.white],
                        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      shadows: const [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.white,
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 40.0,
                          color: Colors.pink,
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 60.0,
                          color: Colors.purple,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),

                // 添加闪烁的小心形
                if (_fireworksController.displayedText.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPulsingHeart(0),
                      const SizedBox(width: 15),
                      _buildPulsingHeart(500),
                      const SizedBox(width: 15),
                      _buildPulsingHeart(1000),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建背景心形效果
  List<Widget> _buildBackgroundHearts() {
    return List.generate(8, (index) {
      final angle = (index * 45.0) * (pi / 180);
      final radius = 150.0 + (index % 3) * 30;
      final x = cos(angle) * radius;
      final y = sin(angle) * radius;

      return Positioned(
        left: 200 + x,
        top: 200 + y,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000 + index * 200),
          curve: Curves.easeInOut,
          child: Text(
            '💖',
            style: TextStyle(
              fontSize: 20 + (index % 3) * 10,
              color: Colors.pink.withValues(alpha: 0.3 + (index % 3) * 0.1),
            ),
          ),
        ),
      );
    });
  }

  /// 构建脉冲跳动的小心形
  Widget _buildPulsingHeart(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.2),
      duration: const Duration(milliseconds: 800),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: const Text(
            '💕',
            style: TextStyle(
              fontSize: 24,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.pink,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        );
      },
      onEnd: () {
        // 重新启动动画形成循环
        setState(() {});
      },
    );
  }

  /// 构建心形+文字组合Widget
  Widget _buildHeartWithTextWidget() {
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 心形背景
            CustomPaint(
              painter: HeartPainter(
                scale: _fireworksController.heartScale,
                color: Colors.red,
                alpha: _fireworksController.heartAlpha,
              ),
            ),

            // 叠加在心形上的文字
            if (_fireworksController.displayedText.isNotEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 主文字
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: Text(
                      key: ValueKey(_fireworksController.displayedText),
                      _fireworksController.displayedText,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Colors.white, Colors.yellow, Colors.white],
                          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 48.0)),
                        shadows: const [
                          Shadow(
                            blurRadius: 15.0,
                            color: Colors.white,
                            offset: Offset(0, 0),
                          ),
                          Shadow(
                            blurRadius: 25.0,
                            color: Colors.pink,
                            offset: Offset(0, 0),
                          ),
                          Shadow(
                            blurRadius: 35.0,
                            color: Colors.purple,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 文字完成后显示小心形
                  if (_fireworksController.displayedText == '我喜欢你') ...[
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPulsingHeart(0),
                        const SizedBox(width: 10),
                        _buildPulsingHeart(300),
                        const SizedBox(width: 10),
                        _buildPulsingHeart(600),
                      ],
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// 构建跳动爱心Widget
  Widget _buildHeartWidget() {
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: CustomPaint(
          painter: HeartPainter(
            scale: _fireworksController.heartScale,
            color: Colors.red,
            alpha: _fireworksController.heartAlpha,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              '烂漫的烟花秀',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white)),
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
                // 浪漫动画覆盖层
                ListenableBuilder(
                  listenable: _fireworksController,
                  builder: (context, child) {
                    return _buildRomanticAnimation();
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
                        // 重新开始按钮 - 放在上方
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: Colors.pink.withValues(alpha: 0.5),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {
                            _fireworksController.restart();
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 8),
                              Text('💕再来一次💕'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 原有控制按钮 - 放在下方，使用Wrap确保小屏幕兼容性
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                var runState = _fireworksController.toggle();
                                setState(() {
                                  isRunning = runState;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(isRunning ? Icons.pause_circle_filled : Icons.play_arrow),
                                  SizedBox(width: 5),
                                  Text(isRunning ? '暂停' : '继续')
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                if (_fireworksController.isRunning) {
                                  _fireworksController.launchSpectacularBatch(size);
                                }
                              },
                              child: const Text('💥来波大的'),
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
    );
  }
}
