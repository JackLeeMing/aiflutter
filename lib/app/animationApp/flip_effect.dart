import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class CardFlipEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double delayAmount;
  const CardFlipEffect({
    super.key,
    required this.child,
    required this.duration,
    required this.delayAmount,
  });

  @override
  State<CardFlipEffect> createState() => _CardFlipEffectState();
}

class _CardFlipEffectState extends State<CardFlipEffect> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Widget? _previousChild;
  late final Animation<double> _animationWithDelay; // NEW
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: widget.duration);

    _animationController.addListener(() {
      if (_animationController.value == 1) {
        _animationController.reset();
      }
    });
    _animationWithDelay = TweenSequence<double>([
      // NEW
      if (widget.delayAmount > 0) // NEW
        TweenSequenceItem(
          // NEW
          tween: ConstantTween<double>(0.0), // NEW
          weight: widget.delayAmount, // NEW
        ), // NEW
      TweenSequenceItem(
        // NEW
        tween: Tween(begin: 0.0, end: 1.0), // NEW
        weight: 1.0, // NEW
      ), // NEW
    ]).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant CardFlipEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child.key != oldWidget.child.key) {
      _handleChildChanged(widget.child, oldWidget.child);
    }
  }

  void _handleChildChanged(Widget newChild, Widget previousChild) {
    _previousChild = previousChild;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationWithDelay,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateX(_animationWithDelay.value * math.pi),
          child: _animationController.isAnimating
              ? _animationWithDelay.value < 0.5
                  ? _previousChild
                  : Transform.flip(flipY: true, child: child)
              : child,
        );
      },
      child: widget.child,
    );
  }
}
