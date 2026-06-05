import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardSearchPrompt extends StatelessWidget {
  const DashboardSearchPrompt({
    super.key,
    required this.onSearchTap,
  });

  final VoidCallback onSearchTap;

  static const headline = 'Quickly locate anything\nyou\'ve stored';

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final colors = AppTheme.tokens.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            headline,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(width: spacing.md),
        Semantics(
          button: true,
          label: 'Search stored items',
          child: IconButton.filledTonal(
            onPressed: onSearchTap,
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
