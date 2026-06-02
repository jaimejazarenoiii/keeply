import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class PathSegment extends Equatable {
  const PathSegment({
    required this.id,
    required this.type,
    required this.name,
    this.images = const [],
  });
  factory PathSegment.fromJson(Map<String, dynamic> json) => PathSegment(
    id: json['id'] as String? ?? '',
    type: nodeTypeFromApi(json['type'] as String? ?? 'ITEM'),
    name: json['name'] as String? ?? '',
    images: ((json['images'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(NodeImage.fromJson)
        .toList(),
  );
  final String id;
  final NodeType type;
  final String name;
  final List<NodeImage> images;
  @override
  List<Object?> get props => [id, type, name, images];
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
