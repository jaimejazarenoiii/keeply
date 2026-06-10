import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/node_details/data/node_details_repository_impl.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

void main() {
  late MockStorageRepository storage;
  late NodeDetailsRepositoryImpl repository;

  setUp(() {
    storage = MockStorageRepository();
    repository = NodeDetailsRepositoryImpl(storage);
  });

  test('maps direct children only from space tree', () async {
    when(() => storage.getSpaceTree('space-1')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
        children: [
          StorageTreeNode(
            id: 'container-1',
            type: NodeType.container,
            name: 'Shelf',
            spaceId: 'space-1',
            children: [
              StorageTreeNode(
                id: 'item-1',
                type: NodeType.item,
                name: 'Hammer',
                spaceId: 'space-1',
              ),
            ],
          ),
          StorageTreeNode(
            id: 'item-2',
            type: NodeType.item,
            name: 'Tape',
            spaceId: 'space-1',
          ),
        ],
      ),
    );

    final details = await repository.getNodeDetails(
      nodeId: 'space-1',
      nodeType: NodeType.space,
    );

    expect(details.totalDirectContainers, 1);
    expect(details.totalDirectItems, 1);
    expect(details.previewContainers.single.name, 'Shelf');
    expect(details.previewItems.single.name, 'Tape');
  });

  test('returns explorer container rows', () async {
    when(() => storage.getSpaceTree('space-1')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
        children: [
          StorageTreeNode(
            id: 'container-1',
            type: NodeType.container,
            name: 'Shelf',
            spaceId: 'space-1',
          ),
        ],
      ),
    );

    final rows = await repository.getExplorerChildren(
      parentNodeId: 'space-1',
      parentNodeType: NodeType.space,
      explorerType: NodeExplorerType.containers,
    );

    expect(rows, hasLength(1));
    expect(rows.first, isA<ExplorerContainerRow>());
  });

  test('builds nested container breadcrumbs', () async {
    when(() => storage.getContainerTree('container-2')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'container-2',
        type: NodeType.container,
        name: 'Bin',
        parentId: 'container-1',
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
    when(() => storage.getSpaceTree('space-1')).thenAnswer(
      (_) async => const StorageTreeNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
      ),
    );

    final details = await repository.getNodeDetails(
      nodeId: 'container-2',
      nodeType: NodeType.container,
    );

    expect(details.breadcrumbs, [
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
