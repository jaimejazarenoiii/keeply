import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardSearchPrompt extends StatelessWidget {
  const DashboardSearchPrompt({super.key});

  static const headline = 'Quickly locate anything\nyou\'ve stored';

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;

    return Text(
      headline,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: colors.secondary,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
