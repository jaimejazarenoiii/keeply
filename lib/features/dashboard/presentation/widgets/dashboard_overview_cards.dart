import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_stat_card.dart';

class DashboardOverviewCards extends StatelessWidget {
  const DashboardOverviewCards({
    super.key,
    required this.summary,
    required this.onSpacesTap,
    required this.onContainersTap,
    required this.onItemsTap,
  });

  final DashboardSummary summary;
  final VoidCallback onSpacesTap;
  final VoidCallback onContainersTap;
  final VoidCallback onItemsTap;

  @override
  Widget build(BuildContext context) {
    final cards = [
      DashboardStatCard(
        icon: Icons.home_work_outlined,
        count: summary.totalSpaces,
        label: 'Spaces',
        onTap: onSpacesTap,
      ),
      DashboardStatCard(
        icon: Icons.inventory_2_outlined,
        count: summary.totalContainers,
        label: 'Containers',
        onTap: onContainersTap,
      ),
      DashboardStatCard(
        icon: Icons.category_outlined,
        count: summary.totalItems,
        label: 'Items',
        onTap: onItemsTap,
      ),
    ];
    return Row(
      children: [
        for (var i = 0; i < cards.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == cards.length - 1 ? 0 : 8),
              child: cards[i],
            ),
          ),
      ],
    );
  }
}
