import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/container_card_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/hero_carousel_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/item_card_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/metadata_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_pattern_background.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_responsive_container.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeDetailsSkeleton extends StatelessWidget {
  const NodeDetailsSkeleton({
    super.key,
    required this.carouselHeight,
    required this.nodeType,
  });

  final double carouselHeight;
  final NodeType nodeType;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final mediaQuery = MediaQuery.of(context);
    final minPatternHeight =
        mediaQuery.size.height -
        mediaQuery.padding.top -
        kToolbarHeight -
        nodeCarouselSectionHeight(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroCarouselSkeleton(height: carouselHeight),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: minPatternHeight.clamp(0, double.infinity),
            ),
            child: NodeDetailsPatternBackground(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  spacing.lg,
                  spacing.lg,
                  spacing.lg,
                  spacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MetadataSkeleton(),
                    if (nodeType != NodeType.item) ...[
                      SizedBox(height: spacing.xl),
                      SizedBox(
                        height: 236,
                        child: Row(
                          children: [
                            const ContainerCardSkeleton(),
                            SizedBox(width: spacing.md),
                            const ContainerCardSkeleton(),
                          ],
                        ),
                      ),
                      SizedBox(height: spacing.xl),
                      const ItemCardSkeleton(),
                      const ItemCardSkeleton(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
