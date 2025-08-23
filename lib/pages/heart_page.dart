import 'package:aiflutter/pages/firworks/heart.dart';
import 'package:aiflutter/pages/firworks/widgets.dart';
import 'package:aiflutter/widgets/triangle_painter.dart';
import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';

class HeartFeaturePage extends StatefulWidget {
  const HeartFeaturePage({super.key});

  @override
  State<HeartFeaturePage> createState() => _HeartFeaturePageState();
}

class _HeartFeaturePageState extends State<HeartFeaturePage> {
  late final HeartController _heartController;
  var isRunning = true;

  @override
  void initState() {
    super.initState();
    _heartController = HeartController();
    // 注册一个回调，在下一帧绘制完成后执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _heartController.start();
      }
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(
      child: ListenableBuilder(
        listenable: _heartController,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: _heartController.heartColor),
              title: Icon(Icons.favorite, size: 32, color: _heartController.heartColor),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 浪漫动画覆盖层
                  _buildHeartWidget(),
                  Icon(
                    Icons.favorite,
                    size: 64,
                    color: _heartController.heartColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '心想事成',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _heartController.heartColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '浪漫 Brilliant & Romantic',
                    style: TextStyle(
                      color: _heartController.heartColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(colors.length, (index) {
                        // 使用 Padding 替代 Sizedbox 来控制间隔
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: TriangleCorner(
                            triangleColor:
                                _heartController.colorIndex == index ? Colors.pinkAccent : Colors.transparent,
                            position: TrianglePosition.left,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: colors[index],
                                // borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建跳动爱心Widget
  Widget _buildHeartWidget() {
    return Center(
      child: SizedBox(
        width: 520,
        height: 520,
        child: CustomPaint(
          painter: HeartPainter(
            scale: _heartController.heartScale,
            color: _heartController.heartColor,
            alpha: _heartController.heartAlpha,
          ),
        ),
      ),
    );
  }
}
