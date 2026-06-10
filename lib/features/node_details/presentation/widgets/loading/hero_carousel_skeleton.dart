import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_shimmer.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_hero_carousel.dart';

class HeroCarouselSkeleton extends StatelessWidget {
  const HeroCarouselSkeleton({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.tokens.spacing.sm),
      child: DashboardShimmer(
        child: NodeCarouselThumbnailFrame(
          height: height,
          child: DashboardSkeletonBox(
            height: height,
            radius: 0,
          ),
        ),
      ),
    );
  }
}
