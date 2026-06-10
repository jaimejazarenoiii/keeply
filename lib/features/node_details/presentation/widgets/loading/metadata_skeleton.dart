import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_shimmer.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class MetadataSkeleton extends StatelessWidget {
  const MetadataSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    return DashboardShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSkeletonBox(height: 28),
          SizedBox(height: spacing.xs),
          const DashboardSkeletonBox(height: 14, width: 180),
          SizedBox(height: spacing.sm),
          const DashboardSkeletonBox(height: 28, width: 96),
          SizedBox(height: spacing.md),
          const DashboardSkeletonBox(height: 18),
          SizedBox(height: spacing.xs),
          const DashboardSkeletonBox(height: 18),
          SizedBox(height: spacing.md),
          Row(
            children: [
              DashboardSkeletonBox(
                height: 32,
                width: 88,
                radius: 999,
              ),
              SizedBox(width: spacing.sm),
              DashboardSkeletonBox(
                height: 32,
                width: 88,
                radius: 999,
              ),
              SizedBox(width: spacing.sm),
              DashboardSkeletonBox(
                height: 32,
                width: 72,
                radius: 999,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
