import 'package:flutter/material.dart';

extension ResponsiveSizeExtensions on BuildContext {
  double responsive(double value) {
    final width = MediaQuery.of(this).size.width;
    final scale = width / 375.0;
    return (value * scale).clamp(value * 0.85, value * 1.2).toDouble();
  }
}

extension ResponsiveNumExtensions on num {
  double r(BuildContext context) => context.responsive(toDouble());
}
