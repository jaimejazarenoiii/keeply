import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class StatCardSkeleton extends StatelessWidget {
  const StatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.tokens.spacing.sm),
        child: const Column(
          children: [
            DashboardSkeletonBox(height: 28, width: 28, radius: 14),
            SizedBox(height: 8),
            DashboardSkeletonBox(height: 20, width: 36),
            SizedBox(height: 8),
            DashboardSkeletonBox(height: 12, width: 56),
          ],
        ),
      ),
    );
  }
}
