import 'package:flutter/material.dart';

enum TrianglePosition { left, right }

// 自定义绘制类，用于绘制三角形
class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePosition position = TrianglePosition.left;

  TrianglePainter({
    required this.color,
    this.position = TrianglePosition.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 创建一个画笔
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    // 创建一个路径，定义三角形的三个点
    if (position == TrianglePosition.left) {
      path.moveTo(size.width * 0.5, 0); // 右上角
      path.lineTo(0, size.height * 0.5); // 右侧向下移动
      path.lineTo(0, 0); // 左侧移动
    } else {
      path.moveTo(size.width, 0); // 右上角
      path.lineTo(size.width, size.height * 0.3); // 右侧向下移动
      path.lineTo(size.width * 0.7, 0); // 左侧移动
    }
    path.close(); // 闭合路径
    // 在 Canvas 上绘制路径
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 只有当颜色改变时才需要重绘
    return (oldDelegate as TrianglePainter).color != color;
  }
}

// 可重用的 Widget，用于添加三角形角标
class TriangleCorner extends StatelessWidget {
  final Widget child;
  final Color triangleColor;
  final TrianglePosition position;
  const TriangleCorner({
    super.key,
    required this.child,
    required this.triangleColor,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: const Size(20, 20), // 三角形的大小
            painter: TrianglePainter(
              color: triangleColor,
              position: position,
            ),
          ),
        ),
      ],
    );
  }
}
