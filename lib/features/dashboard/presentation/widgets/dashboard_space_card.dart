import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';

class DashboardSpaceCard extends StatelessWidget {
  const DashboardSpaceCard({
    super.key,
    required this.space,
    required this.onTap,
    this.imageAsset = kDashboardNodePlaceholder,
  });

  final DashboardSpace space;
  final VoidCallback onTap;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return DashboardPreviewThumbnailCard(
      title: space.name,
      subtitle: space.containerCount == 0 && space.itemCount == 0
          ? ''
          : '${space.containerCount} containers · ${space.itemCount} items',
      semanticsLabel: 'Open space ${space.name}',
      imageAsset: imageAsset,
      width: double.infinity,
      onTap: onTap,
    );
  }
}
