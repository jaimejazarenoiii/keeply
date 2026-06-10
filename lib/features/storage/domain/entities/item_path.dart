import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class PathSegment extends Equatable {
  const PathSegment({
    required this.id,
    required this.type,
    required this.name,
    this.images = const [],
    this.tags = const [],
    this.description,
    this.quantity,
  });

  factory PathSegment.fromJson(Map<String, dynamic> json) => PathSegment(
    id: json['id'] as String? ?? '',
    type: nodeTypeFromApi(json['type'] as String? ?? 'ITEM'),
    name: json['name'] as String? ?? '',
    images: ((json['images'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(NodeImage.fromJson)
        .toList(),
    tags: ((json['tags'] as List?) ?? const [])
        .whereType<String>()
        .where((tag) => tag.isNotEmpty)
        .toList(),
    description: json['description'] as String?,
    quantity: json['quantity'] as int?,
  );

  final String id;
  final NodeType type;
  final String name;
  final List<NodeImage> images;
  final List<String> tags;
  final String? description;
  final int? quantity;

  @override
  List<Object?> get props => [
    id,
    type,
    name,
    images,
    tags,
    description,
    quantity,
  ];
}

class ItemPath extends Equatable {
  const ItemPath({required this.itemId, required this.path});

  factory ItemPath.fromJson(Map<String, dynamic> json) => ItemPath(
    itemId: json['itemId'] as String? ?? '',
    path: ((json['path'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(PathSegment.fromJson)
        .toList(),
  );

  final String itemId;
  final List<PathSegment> path;

  @override
  List<Object?> get props => [itemId, path];
}
