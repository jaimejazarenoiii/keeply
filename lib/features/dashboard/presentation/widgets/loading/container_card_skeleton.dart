import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';

class ContainerCardSkeleton extends StatelessWidget {
  const ContainerCardSkeleton({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final radius = AppTheme.tokens.radius.md;
    final cardWidth = width ?? DashboardPreviewThumbnailCard.defaultCardWidth;

    return SizedBox(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSkeletonBox(
            height: DashboardPreviewThumbnailCard.imageHeight,
            width: cardWidth,
            radius: radius,
          ),
          Padding(
            padding: EdgeInsets.all(spacing.md),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardSkeletonBox(height: 18, width: 120),
                SizedBox(height: 8),
                DashboardSkeletonBox(height: 14, width: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
