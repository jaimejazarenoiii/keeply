import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class StorageTreeNode extends StorageNode {
  const StorageTreeNode({
    required super.id,
    required super.type,
    required super.name,
    super.parentId,
    required super.spaceId,
    super.images,
    super.metadata,
    super.tags,
    super.description,
    super.quantity,
    super.createdAt,
    super.updatedAt,
    this.children = const [],
  });

  factory StorageTreeNode.fromJson(Map<String, dynamic> json) {
    final node = StorageNode.fromJson(json);
    return StorageTreeNode(
      id: node.id,
      type: node.type,
      name: node.name,
      parentId: node.parentId,
      spaceId: node.spaceId,
      images: node.images,
      metadata: node.metadata,
      tags: node.tags,
      description: node.description,
      quantity: node.quantity,
      createdAt: node.createdAt,
      updatedAt: node.updatedAt,
      children: ((json['children'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(StorageTreeNode.fromJson)
          .toList(),
    );
  }

  final List<StorageTreeNode> children;

  @override
  List<Object?> get props => [...super.props, children];
}
