import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class DashboardSearchResults extends StatelessWidget {
  const DashboardSearchResults({
    super.key,
    required this.results,
    required this.onOpen,
  });

  final List<DashboardSearchResult> results;
  final ValueChanged<DashboardSearchResult> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Search results', style: Theme.of(context).textTheme.titleLarge),
        for (final result in results)
          Card(
            child: ListTile(
              leading: Icon(_iconFor(result.type)),
              title: Text(result.title),
              subtitle: Text(result.subtitle),
              trailing: const Icon(Icons.arrow_forward, size: 20),
              onTap: () => onOpen(result),
            ),
          ),
      ],
    );
  }

  IconData _iconFor(NodeType type) => switch (type) {
    NodeType.space => Icons.home_work_outlined,
    NodeType.container => Icons.inventory_2_outlined,
    NodeType.item => Icons.category_outlined,
  };
}
