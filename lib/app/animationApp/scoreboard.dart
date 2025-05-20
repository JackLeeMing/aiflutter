import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const Scoreboard({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < totalQuestions; i++)
            AnimatedStar(
              isAvtive: score > i,
            ),
        ],
      ),
    );
  }
}

class AnimatedStar extends StatelessWidget {
  final bool isAvtive;
  final Duration _duration = const Duration(milliseconds: 1000);
  final Color _deactivatedColor = Colors.grey.shade400;
  final Color _activatedColor = Colors.yellow.shade700;
  final Curve _curve = Curves.elasticOut;
  AnimatedStar({super.key, required this.isAvtive});

  @override
  Widget build(BuildContext context) {
    // 隐式动画
    return AnimatedScale(
      scale: isAvtive ? 1.0 : 0.5,
      duration: _duration,
      child: TweenAnimationBuilder(
        curve: _curve,
        tween: ColorTween(
          begin: _deactivatedColor,
          end: isAvtive ? _activatedColor : _deactivatedColor,
        ),
        duration: _duration,
        builder: (context, value, child) {
          return Icon(
            Icons.star,
            size: 50,
            color: value,
          );
        },
      ),
    );
  }
}
