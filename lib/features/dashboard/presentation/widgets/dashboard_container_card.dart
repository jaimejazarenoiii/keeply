import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';

class DashboardContainerCard extends StatelessWidget {
  const DashboardContainerCard({
    super.key,
    required this.container,
    required this.onTap,
  });

  final DashboardContainer container;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DashboardPreviewThumbnailCard(
      title: container.name,
      subtitle: [
        if (container.spaceName.isNotEmpty) container.spaceName,
        if (container.itemCount > 0) '${container.itemCount} items',
      ].join(' · '),
      semanticsLabel: 'Open container ${container.name}',
      onTap: onTap,
    );
  }
}
