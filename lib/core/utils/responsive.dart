import 'package:flutter/widgets.dart';

/// Tiny responsive helper. Designs are calibrated for a 390pt iPhone width
/// (same scale as Figma "Pixel 3a" / iPhone 13). Use [r] to scale sizes.
class R {
  R._();

  static const double _designWidth = 390;

  static double of(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    return value * (width / _designWidth);
  }
}

extension ResponsiveX on num {
  double r(BuildContext context) => R.of(context, toDouble());
}
