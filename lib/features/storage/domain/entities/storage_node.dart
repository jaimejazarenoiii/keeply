import 'package:equatable/equatable.dart';

enum NodeType { space, container, item }

NodeType nodeTypeFromApi(String value) => switch (value) {
  'SPACE' => NodeType.space,
  'CONTAINER' => NodeType.container,
  'ITEM' => NodeType.item,
  _ => NodeType.item,
};
String nodeTypeToApi(NodeType type) => switch (type) {
  NodeType.space => 'SPACE',
  NodeType.container => 'CONTAINER',
  NodeType.item => 'ITEM',
};

class NodeImage extends Equatable {
  const NodeImage({
    required this.id,
    required this.url,
    this.altText,
    this.sortOrder = 0,
    this.createdAt,
  });
  factory NodeImage.fromJson(Map<String, dynamic> json) => NodeImage(
    id: json['id'] as String? ?? '',
    url: json['url'] as String? ?? '',
    altText: json['altText'] as String?,
    sortOrder: json['sortOrder'] as int? ?? 0,
    createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
  );
  final String id;
  final String url;
  final String? altText;
  final int sortOrder;
  final DateTime? createdAt;
  @override
  List<Object?> get props => [id, url, altText, sortOrder, createdAt];
}

class StorageNode extends Equatable {
  const StorageNode({
    required this.id,
    required this.type,
    required this.name,
    this.parentId,
    required this.spaceId,
    this.images = const [],
    this.metadata = const {},
    this.createdAt,
    this.updatedAt,
  });
  factory StorageNode.fromJson(Map<String, dynamic> json) => StorageNode(
    id: json['id'] as String? ?? '',
    type: nodeTypeFromApi(json['type'] as String? ?? 'ITEM'),
    name: json['name'] as String? ?? '',
    parentId: json['parentId'] as String?,
    spaceId: json['spaceId'] as String? ?? json['id'] as String? ?? '',
    images: ((json['images'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(NodeImage.fromJson)
        .toList(),
    metadata: Map<String, dynamic>.from(
      json['metadata'] as Map? ?? const <String, dynamic>{},
    ),
    createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
  );
  final String id;
  final NodeType type;
  final String name;
  final String? parentId;
  final String spaceId;
  final List<NodeImage> images;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @override
  List<Object?> get props => [
    id,
    type,
    name,
    parentId,
    spaceId,
    images,
    metadata,
    createdAt,
    updatedAt,
  ];
}
