import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class SpaceCardSkeleton extends StatelessWidget {
  const SpaceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.tokens.components.cardPadding),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSkeletonBox(height: 18, width: 160),
            SizedBox(height: 8),
            DashboardSkeletonBox(height: 14, width: 110),
          ],
        ),
      ),
    );
  }
}
