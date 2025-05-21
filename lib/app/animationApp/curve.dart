// ignore_for_file: lines_longer_than_80_chars
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCurve extends Curve {
  /// Creates an elastic-out curve.
  ///
  /// Rather than creating a new instance, consider using [Curves.elasticOut].
  const CustomCurve([this.period = 0.4]);

  /// The duration of the oscillation.
  final double period;

  @override
  double transformInternal(double t) {
    final double s = period / 4.0;
    return math.pow(2.0, -10 * t) * math.sin((t - s) * (math.pi * 2.0) / period) + 1.0;
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'ElasticOutCurve')}($period)';
  }
}
