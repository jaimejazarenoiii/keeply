import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';

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
    return DashboardRecentRow(
      title: container.name,
      subtitle: '${container.spaceName} · ${container.itemCount} items',
      semanticsLabel: 'Open container ${container.name}',
      onTap: onTap,
    );
  }
}
