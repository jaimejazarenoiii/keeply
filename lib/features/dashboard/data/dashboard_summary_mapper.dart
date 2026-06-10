import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/storage/domain/entities/dashboard_api_summary.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

DashboardSummary mapDashboardApiSummary(DashboardApiSummary api) {
  return DashboardSummary(
    totalSpaces: api.counts.spaces,
    totalContainers: api.counts.containers,
    totalItems: api.counts.items,
    latestSpaces: [
      for (final node in api.recentSpaces)
        DashboardSpace(
          id: node.id,
          name: node.name,
          containerCount: 0,
          itemCount: 0,
        ),
    ],
    latestContainers: [
      for (final node in api.recentContainers)
        DashboardContainer(
          id: node.id,
          name: node.name,
          spaceId: node.spaceId,
          spaceName: '',
          itemCount: 0,
        ),
    ],
    latestItems: [
      for (final node in api.recentItems)
        DashboardItem(
          id: node.id,
          name: node.name,
          containerId: _itemContainerId(node),
          containerName: '',
          spaceId: node.spaceId,
          spaceName: '',
        ),
    ],
  );
}

String _itemContainerId(StorageNode node) {
  if (node.parentId == null || node.parentId == node.spaceId) return '';
  return node.parentId!;
}
