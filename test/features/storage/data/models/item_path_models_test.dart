import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

void main() {
  test('parses item breadcrumb path', () {
    final path = ItemPath.fromJson({
      'itemId': 'item-1',
      'path': [
        {'id': 'space-1', 'type': 'SPACE', 'name': 'Garage', 'images': []},
        {'id': 'item-1', 'type': 'ITEM', 'name': 'Cord', 'images': []},
      ],
    });

    expect(path.path.first.type, NodeType.space);
    expect(path.path.last.name, 'Cord');
  });
}
