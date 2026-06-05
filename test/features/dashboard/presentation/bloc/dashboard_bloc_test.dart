import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

void main() {
  test('filters search results across spaces, containers, and items', () {
    const summary = DashboardSummary(
      totalSpaces: 1,
      totalContainers: 1,
      totalItems: 1,
      latestSpaces: [
        DashboardSpace(
          id: 'space-1',
          name: 'Garage',
          containerCount: 1,
          itemCount: 1,
        ),
      ],
      latestContainers: [
        DashboardContainer(
          id: 'container-1',
          name: 'Cable Bin',
          spaceId: 'space-1',
          spaceName: 'Garage',
          itemCount: 1,
        ),
      ],
      latestItems: [
        DashboardItem(
          id: 'item-1',
          name: 'Extension Cord',
          containerId: 'container-1',
          containerName: 'Cable Bin',
          spaceId: 'space-1',
          spaceName: 'Garage',
        ),
      ],
    );

    final results = summary.search('cable');
    expect(
      results.map((result) => result.type),
      containsAll([NodeType.container, NodeType.item]),
    );
  });
}
