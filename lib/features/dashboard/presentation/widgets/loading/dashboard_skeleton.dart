import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/container_card_skeleton.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_shimmer.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/item_card_skeleton.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/space_card_skeleton.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/stat_card_skeleton.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    return DashboardShimmer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Row(
            children: [
              DashboardSkeletonBox(height: 40, width: 120),
              Spacer(),
              DashboardSkeletonBox(height: 48, width: 48, radius: 24),
              SizedBox(width: 8),
              DashboardSkeletonBox(height: 48, width: 48, radius: 24),
            ],
          ),
          SizedBox(height: spacing.lg),
          const DashboardSkeletonBox(height: 56, width: double.infinity),
          SizedBox(height: spacing.lg),
          const Row(
            children: [
              Expanded(child: StatCardSkeleton()),
              Expanded(child: StatCardSkeleton()),
              Expanded(child: StatCardSkeleton()),
            ],
          ),
          SizedBox(height: spacing.lg),
          for (var i = 0; i < 5; i++) const SpaceCardSkeleton(),
          SizedBox(height: spacing.md),
          SizedBox(
            height: 236,
            child: Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) SizedBox(width: spacing.md),
                  const ContainerCardSkeleton(),
                ],
              ],
            ),
          ),
          SizedBox(height: spacing.md),
          for (var i = 0; i < 10; i++) const ItemCardSkeleton(),
        ],
      ),
    );
  }
}
