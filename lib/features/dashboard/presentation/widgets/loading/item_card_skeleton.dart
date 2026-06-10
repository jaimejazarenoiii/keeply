import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class ItemCardSkeleton extends StatelessWidget {
  const ItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing.md),
      child: const Row(
        children: [
          DashboardSkeletonBox(
            height: DashboardRecentRow.imageHeight,
            width: DashboardRecentRow.imageWidth,
            radius: DashboardRecentRow.imageRadius,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardSkeletonBox(height: 18, width: 160),
                SizedBox(height: 8),
                DashboardSkeletonBox(height: 14),
                SizedBox(height: 8),
                DashboardSkeletonBox(height: 12, width: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
