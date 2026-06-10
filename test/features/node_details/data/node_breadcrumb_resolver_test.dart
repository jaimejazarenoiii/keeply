import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/node_details/data/node_breadcrumb_resolver.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

void main() {
  late MockStorageRepository storage;
  late NodeBreadcrumbResolver resolver;

  setUp(() {
    storage = MockStorageRepository();
    resolver = NodeBreadcrumbResolver(storage);
  });

  test('returns empty breadcrumbs for a space', () async {
    final breadcrumbs = await resolver.resolve(
      const StorageNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
      ),
    );

    expect(breadcrumbs, isEmpty);
  });

  test('returns ancestor path for an item', () async {
    when(() => storage.getItemPath('item-1')).thenAnswer(
      (_) async => const ItemPath(
        itemId: 'item-1',
        path: [
          PathSegment(
            id: 'space-1',
            type: NodeType.space,
            name: 'Garage',
          ),
          PathSegment(
            id: 'container-1',
            type: NodeType.container,
            name: 'Shelf',
          ),
          PathSegment(
            id: 'item-1',
            type: NodeType.item,
            name: 'Hammer',
          ),
        ],
      ),
    );

    final breadcrumbs = await resolver.resolve(
      const StorageNode(
        id: 'item-1',
        type: NodeType.item,
        name: 'Hammer',
        spaceId: 'space-1',
      ),
    );

    expect(breadcrumbs, [
      const PathSegment(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
      ),
      const PathSegment(
        id: 'container-1',
        type: NodeType.container,
        name: 'Shelf',
      ),
    ]);
  });

  test('falls back to parent walk when item path fails', () async {
    when(() => storage.getItemPath('item-1')).thenThrow(StateError('no path'));
    when(() => storage.getSpaceTree('space-1')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
      ),
    );
    when(() => storage.getContainerTree('container-1')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'container-1',
        type: NodeType.container,
        name: 'Shelf',
        parentId: 'space-1',
        spaceId: 'space-1',
      ),
    );

    final breadcrumbs = await resolver.resolve(
      const StorageNode(
        id: 'item-1',
        type: NodeType.item,
        name: 'Hammer',
        parentId: 'container-1',
        spaceId: 'space-1',
      ),
    );

    expect(breadcrumbs, [
      const PathSegment(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
      ),
      const PathSegment(
        id: 'container-1',
        type: NodeType.container,
        name: 'Shelf',
      ),
    ]);
  });
}
