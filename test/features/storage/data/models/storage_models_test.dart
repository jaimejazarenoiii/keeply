import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/storage/domain/entities/dashboard_api_summary.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';

void main() {
  test('parses storage node and tree children', () {
    final tree = StorageTreeNode.fromJson({
      'id': 'space-1',
      'type': 'SPACE',
      'name': 'Garage',
      'parentId': null,
      'spaceId': 'space-1',
      'images': [],
      'metadata': {},
      'children': [
        {'id': 'item-1', 'type': 'ITEM', 'name': 'Cord', 'spaceId': 'space-1'},
      ],
    });

    expect(tree.type, NodeType.space);
    expect(tree.children.single.type, NodeType.item);
  });

  test('parses top-level tags, description, and quantity', () {
    final node = StorageNode.fromJson({
      'id': 'item-1',
      'type': 'ITEM',
      'name': 'Cord',
      'parentId': 'container-1',
      'spaceId': 'space-1',
      'images': [],
      'tags': ['power', 'outdoor'],
      'description': 'Heavy-duty cord',
      'quantity': 2,
      'createdAt': '2026-01-01T00:00:00.000Z',
      'updatedAt': '2026-01-02T00:00:00.000Z',
    });

    expect(node.tags, ['power', 'outdoor']);
    expect(node.description, 'Heavy-duty cord');
    expect(node.quantity, 2);
    expect(node.parentId, 'container-1');
  });

  test('falls back to metadata tags and description', () {
    final node = StorageNode.fromJson({
      'id': 'item-1',
      'type': 'ITEM',
      'name': 'Cord',
      'spaceId': 'space-1',
      'images': [],
      'metadata': {
        'tags': ['legacy'],
        'description': 'From metadata',
      },
    });

    expect(node.tags, ['legacy']);
    expect(node.description, 'From metadata');
  });

  test('parses dashboard summary payload', () {
    final summary = DashboardApiSummary.fromJson({
      'counts': {'spaces': 2, 'containers': 4, 'items': 9},
      'recent': {
        'spaces': [
          {'id': 'space-1', 'type': 'SPACE', 'name': 'Garage', 'spaceId': 'space-1'},
        ],
        'containers': [],
        'items': [],
      },
    });

    expect(summary.counts.spaces, 2);
    expect(summary.counts.containers, 4);
    expect(summary.counts.items, 9);
    expect(summary.recentSpaces.single.name, 'Garage');
  });
}
