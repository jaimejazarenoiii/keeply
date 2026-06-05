import 'package:flutter/widgets.dart';

class DashboardAnimationSpecs {
  static const headerDuration = Duration(milliseconds: 300);
  static const searchDuration = Duration(milliseconds: 350);
  static const skeletonTransition = Duration(milliseconds: 250);
  static const tapScaleDuration = Duration(milliseconds: 150);
  static const overviewStagger = Duration(milliseconds: 100);
  static const sectionStagger = Duration(milliseconds: 50);
  static const itemStagger = Duration(milliseconds: 30);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const maxWidth = 1200.0;
  static const tapScale = 0.97;

  static Offset slideUp(double distance) => Offset(0, distance);
}
