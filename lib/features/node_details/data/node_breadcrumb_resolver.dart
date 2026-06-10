import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class NodeBreadcrumbResolver {
  const NodeBreadcrumbResolver(this._storage);

  final StorageRepository _storage;

  static const _maxAncestorDepth = 32;

  Future<List<PathSegment>> resolve(StorageNode node) async {
    try {
      return await switch (node.type) {
        NodeType.space => const [],
        NodeType.item => _resolveItemAncestors(node),
        NodeType.container => _resolveContainerAncestors(node),
      };
    } on Object {
      return const [];
    }
  }

  Future<List<PathSegment>> _resolveItemAncestors(StorageNode node) async {
    try {
      final itemPath = await _storage.getItemPath(node.id);
      return itemPath.path.where((segment) => segment.id != node.id).toList();
    } on Object {
      return _resolveContainerAncestors(node);
    }
  }

  Future<List<PathSegment>> _resolveContainerAncestors(StorageNode node) async {
    if (node.spaceId.isEmpty) return const [];

    final ancestors = <PathSegment>[];
    try {
      final space = await _storage.getSpaceTree(node.spaceId);
      ancestors.add(
        PathSegment(
          id: space.id,
          type: NodeType.space,
          name: space.name,
          images: space.images,
        ),
      );
    } on Object {
      return const [];
    }

    final containers = <PathSegment>[];
    var parentId = node.parentId;
    var depth = 0;
    while (parentId != null &&
        parentId.isNotEmpty &&
        parentId != node.spaceId &&
        depth < _maxAncestorDepth) {
      depth++;
      try {
        final parent = await _storage.getContainerTree(parentId);
        containers.insert(
          0,
          PathSegment(
            id: parent.id,
            type: NodeType.container,
            name: parent.name,
            images: parent.images,
          ),
        );
        parentId = parent.parentId;
      } on Object {
        break;
      }
    }

    return [...ancestors, ...containers];
  }
}
