import 'package:flutter_test/flutter_test.dart';
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
}
