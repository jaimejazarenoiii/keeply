import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';

class DashboardSpaceCard extends StatelessWidget {
  const DashboardSpaceCard({
    super.key,
    required this.space,
    required this.onTap,
  });

  final DashboardSpace space;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DashboardRecentRow(
      title: space.name,
      subtitle:
          '${space.containerCount} containers · ${space.itemCount} items',
      semanticsLabel: 'Open space ${space.name}',
      onTap: onTap,
    );
  }
}
