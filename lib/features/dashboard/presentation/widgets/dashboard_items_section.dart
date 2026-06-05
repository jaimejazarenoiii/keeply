import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_item_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart';

class DashboardItemsSection extends StatelessWidget {
  const DashboardItemsSection({
    super.key,
    required this.items,
    required this.onOpenItem,
    required this.onShowAll,
    required this.onCreateSpace,
  });

  final List<DashboardItem> items;
  final ValueChanged<DashboardItem> onOpenItem;
  final VoidCallback onShowAll;
  final VoidCallback onCreateSpace;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return DashboardEmptyState(
        message: 'No Items yet. Add an Item inside a Space or Container.',
        actionLabel: 'View Spaces',
        onAction: onCreateSpace,
        flat: true,
      );
    }

    final visible = items.take(10).toList();
    return DashboardSection(
      title: 'Recent Items',
      useSecondaryHeading: true,
      children: [
        ...separatedRecentRows([
          for (final item in visible)
            DashboardItemCard(item: item, onTap: () => onOpenItem(item)),
        ]),
        TextButton(
          onPressed: onShowAll,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.tokens.colors.secondary,
          ),
          child: const Text('Show all Items'),
        ),
      ],
    );
  }
}
