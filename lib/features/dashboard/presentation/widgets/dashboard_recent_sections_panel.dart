import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardRecentSectionsPanel extends StatelessWidget {
  const DashboardRecentSectionsPanel({
    super.key,
    required this.child,
    this.minHeight,
  });

  final Widget child;
  final double? minHeight;

  static const topRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    final safeMinHeight =
        minHeight != null && minHeight!.isFinite && minHeight! > 0
        ? minHeight
        : null;

    return Container(
      width: double.infinity,
      constraints: safeMinHeight == null
          ? null
          : BoxConstraints(minHeight: safeMinHeight!),
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.xl,
        spacing.xl,
        spacing.lg + bottomInset,
      ),
      decoration: BoxDecoration(
        color: AppTheme.tokens.colors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.tokens.colors.secondary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: AppTheme.tokens.colors.secondary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: child,
    );
  }
}
