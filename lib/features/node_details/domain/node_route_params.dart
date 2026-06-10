import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

NodeType nodeTypeFromPath(String value) => switch (value.toLowerCase()) {
  'space' => NodeType.space,
  'container' => NodeType.container,
  'item' => NodeType.item,
  _ => NodeType.item,
};

String nodeTypeToPath(NodeType type) => switch (type) {
  NodeType.space => 'space',
  NodeType.container => 'container',
  NodeType.item => 'item',
};

NodeExplorerType explorerTypeFromPath(String value) =>
    switch (value.toLowerCase()) {
      'containers' => NodeExplorerType.containers,
      'items' => NodeExplorerType.items,
      _ => NodeExplorerType.containers,
    };

String explorerTypeToPath(NodeExplorerType type) => switch (type) {
  NodeExplorerType.containers => 'containers',
  NodeExplorerType.items => 'items',
};

String nodeDetailsPath(NodeType type, String id) =>
    '/nodes/${nodeTypeToPath(type)}/$id';

String nodeExplorerPath(
  NodeType parentType,
  String parentId,
  NodeExplorerType explorerType, {
  String? query,
}) {
  final base =
      '/nodes/${nodeTypeToPath(parentType)}/$parentId/explorer/${explorerTypeToPath(explorerType)}';
  if (query == null || query.isEmpty) return base;
  return '$base?q=${Uri.encodeQueryComponent(query)}';
}
