import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_space_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart';

class DashboardSpacesSection extends StatelessWidget {
  const DashboardSpacesSection({
    super.key,
    required this.spaces,
    required this.onOpenSpace,
    required this.onShowAll,
    required this.onCreateSpace,
  });

  final List<DashboardSpace> spaces;
  final ValueChanged<DashboardSpace> onOpenSpace;
  final VoidCallback onShowAll;
  final VoidCallback onCreateSpace;

  @override
  Widget build(BuildContext context) {
    if (spaces.isEmpty) {
      return DashboardEmptyState(
        message: 'No Spaces yet. Create your first Space to start organizing.',
        actionLabel: 'Create Space',
        onAction: onCreateSpace,
        flat: true,
      );
    }

    final visible = spaces.take(5).toList();
    return DashboardSection(
      title: 'Recent Spaces',
      useSecondaryHeading: true,
      children: [
        ...separatedRecentRows([
          for (final space in visible)
            DashboardSpaceCard(space: space, onTap: () => onOpenSpace(space)),
        ]),
        TextButton(
          onPressed: onShowAll,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.tokens.colors.secondary,
          ),
          child: const Text('Show all Spaces'),
        ),
      ],
    );
  }
}
