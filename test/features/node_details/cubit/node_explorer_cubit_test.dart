import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_explorer_cubit.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

import '../node_details_test_helpers.dart';

void main() {
  blocTest<NodeExplorerCubit, NodeExplorerState>(
    'loads first page of explorer results',
    build: () => NodeExplorerCubit(
      FakeNodeDetailsRepository(
        explorerRows: List.generate(
          25,
          (i) => ExplorerContainerRow(
            ChildContainerSummary(
              id: 'c-$i',
              name: 'Container $i',
              itemCount: 0,
            ),
          ),
        ),
      ),
    ),
    act: (cubit) => cubit.load(
      parentNodeId: 'space-1',
      parentNodeType: NodeType.space,
      explorerType: NodeExplorerType.containers,
    ),
    expect: () => [
      isA<NodeExplorerLoading>(),
      isA<NodeExplorerLoaded>().having(
        (s) => s.data.visibleResults.length,
        'visible count',
        20,
      ),
    ],
  );
}
