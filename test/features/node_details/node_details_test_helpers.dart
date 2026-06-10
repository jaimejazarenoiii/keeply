import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';
import 'package:keeply/features/node_details/domain/entities/node_details_view_data.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/domain/entities/node_statistics.dart';
import 'package:keeply/features/node_details/domain/node_details_repository.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class FakeNodeDetailsRepository implements NodeDetailsRepository {
  FakeNodeDetailsRepository({
    this.viewData,
    this.explorerRows = const [],
    this.shouldThrow = false,
  });

  NodeDetailsViewData? viewData;
  List<ExplorerRowData> explorerRows;
  final bool shouldThrow;

  @override
  Future<NodeDetailsViewData> getNodeDetails({
    required String nodeId,
    required NodeType nodeType,
  }) async {
    if (shouldThrow) throw StateError('boom');
    return viewData ??
        NodeDetailsViewData(
          node: StorageNode(
            id: nodeId,
            type: nodeType,
            name: 'Test Node',
            spaceId: nodeId,
          ),
          statistics: const NodeStatistics(
            containerCount: 1,
            itemCount: 1,
            photoCount: 0,
            tagCount: 0,
          ),
          breadcrumbs: const [],
          previewContainers: const [
            ChildContainerSummary(
              id: 'container-1',
              name: 'Shelf A',
              itemCount: 2,
            ),
          ],
          previewItems: const [
            ChildItemSummary(id: 'item-1', name: 'Hammer'),
          ],
          totalDirectContainers: 1,
          totalDirectItems: 1,
        );
  }

  @override
  Future<List<ExplorerRowData>> getExplorerChildren({
    required String parentNodeId,
    required NodeType parentNodeType,
    required NodeExplorerType explorerType,
  }) async {
    if (shouldThrow) throw StateError('boom');
    return explorerRows;
  }
}

Future<void> pumpNodeWidget(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: child),
    ),
  );
}
