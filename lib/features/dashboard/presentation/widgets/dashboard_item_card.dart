import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';

class DashboardItemCard extends StatelessWidget {
  const DashboardItemCard({super.key, required this.item, required this.onTap});

  final DashboardItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final location = item.containerName.isEmpty
        ? item.spaceName
        : '${item.containerName} · ${item.spaceName}';
    return DashboardRecentRow(
      title: item.name,
      subtitle: location,
      semanticsLabel: 'Open item ${item.name}',
      onTap: onTap,
    );
  }
}
