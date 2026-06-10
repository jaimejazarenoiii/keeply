import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_container_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart';

class DashboardContainersSection extends StatelessWidget {
  const DashboardContainersSection({
    super.key,
    required this.containers,
    required this.onOpenContainer,
    required this.onShowAll,
    required this.onCreateSpace,
  });

  final List<DashboardContainer> containers;
  final ValueChanged<DashboardContainer> onOpenContainer;
  final VoidCallback onShowAll;
  final VoidCallback onCreateSpace;

  @override
  Widget build(BuildContext context) {
    if (containers.isEmpty) {
      return DashboardEmptyState(
        message:
            'No Containers yet. Add one inside a Space when you are ready.',
        actionLabel: 'View Spaces',
        onAction: onCreateSpace,
        flat: true,
      );
    }

    final visible = containers.take(5).toList();
    final spacing = AppTheme.tokens.spacing;

    return DashboardSection(
      title: 'Recent Containers',
      useSecondaryHeading: true,
      children: [
        SizedBox(
          height: DashboardPreviewThumbnailCard.listHeight,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(0, spacing.md, 0, spacing.xs),
            scrollDirection: Axis.horizontal,
            itemCount: visible.length,
            separatorBuilder: (_, __) => SizedBox(width: spacing.md),
            itemBuilder: (context, index) {
              final container = visible[index];
              return DashboardContainerCard(
                container: container,
                onTap: () => onOpenContainer(container),
              );
            },
          ),
        ),
        TextButton(
          onPressed: onShowAll,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.tokens.colors.secondary,
          ),
          child: const Text('Show all Containers'),
        ),
      ],
    );
  }
}
