import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
    required this.title,
    required this.children,
    this.useSecondaryHeading = false,
  });

  final String title;
  final List<Widget> children;
  final bool useSecondaryHeading;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: useSecondaryHeading
          ? AppTheme.tokens.colors.secondary
          : null,
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      container: true,
      header: true,
      label: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          SizedBox(height: AppTheme.tokens.spacing.sm),
          for (final child in children) child,
        ],
      ),
    );
  }
}
