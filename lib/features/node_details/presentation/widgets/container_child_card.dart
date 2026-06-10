import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';

class ContainerChildCard extends StatelessWidget {
  const ContainerChildCard({
    super.key,
    required this.container,
    required this.onTap,
    this.width = DashboardPreviewThumbnailCard.defaultCardWidth,
  });

  final ChildContainerSummary container;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return DashboardPreviewThumbnailCard(
      title: container.name,
      subtitle: '${container.itemCount} items',
      semanticsLabel:
          'Open container ${container.name}, ${container.itemCount} items',
      onTap: onTap,
      imageUrl: container.thumbnailUrl,
      width: width,
    );
  }
}
