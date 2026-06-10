import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class SpaceCardSkeleton extends StatelessWidget {
  const SpaceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final radius = AppTheme.tokens.radius.md;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSkeletonBox(
          height: DashboardPreviewThumbnailCard.fullWidthImageHeight,
          radius: radius,
        ),
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardSkeletonBox(height: 18, width: 180),
              SizedBox(height: 8),
              DashboardSkeletonBox(height: 14, width: 140),
            ],
          ),
        ),
      ],
    );
  }
}
