import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_background_pattern.dart';

class NodeDetailsPatternBackground extends StatelessWidget {
  const NodeDetailsPatternBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: AppTheme.tokens.colors.background,
            child: const AppBackgroundPattern(
              variant: AppBackgroundPatternVariant.dashboard,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
