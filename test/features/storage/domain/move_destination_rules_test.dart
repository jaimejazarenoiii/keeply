import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/storage/domain/entities/move_destination_rules.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';

void main() {
  test('disables item targets and moving container descendants', () {
    const tree = StorageTreeNode(
      id: 'space',
      type: NodeType.space,
      name: 'Garage',
      spaceId: 'space',
      children: [
        StorageTreeNode(
          id: 'box',
          type: NodeType.container,
          name: 'Box',
          spaceId: 'space',
          children: [
            StorageTreeNode(
              id: 'cord',
              type: NodeType.item,
              name: 'Cord',
              spaceId: 'space',
            ),
          ],
        ),
      ],
    );

    final disabled = const MoveDestinationRules().disabledIds(
      movingType: NodeType.container,
      movingId: 'box',
      roots: [tree],
    );

    expect(disabled, containsAll(['box', 'cord']));
    expect(disabled, isNot(contains('space')));
  });
}
