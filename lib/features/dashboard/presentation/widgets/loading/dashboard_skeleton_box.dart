import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardSkeletonBox extends StatelessWidget {
  const DashboardSkeletonBox({
    super.key,
    required this.height,
    this.width,
    this.radius,
  });

  final double height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppTheme.tokens.colors.divider,
        borderRadius: BorderRadius.circular(
          radius ?? AppTheme.tokens.radius.md,
        ),
      ),
    );
  }
}
