import 'package:keeply/features/node_details/data/node_breadcrumb_resolver.dart';
import 'package:keeply/features/node_details/data/node_metadata_helpers.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';
import 'package:keeply/features/node_details/domain/entities/node_details_view_data.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/domain/entities/node_statistics.dart';
import 'package:keeply/features/node_details/domain/node_details_repository.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class NodeDetailsRepositoryImpl implements NodeDetailsRepository {
  NodeDetailsRepositoryImpl(this._storage)
    : _breadcrumbResolver = NodeBreadcrumbResolver(_storage);

  final StorageRepository _storage;
  final NodeBreadcrumbResolver _breadcrumbResolver;

  @override
  Future<NodeDetailsViewData> getNodeDetails({
    required String nodeId,
    required NodeType nodeType,
  }) async {
    final node = await _loadNode(nodeId, nodeType);
    final children = await _loadDirectChildren(node);
    final containers = children.containers;
    final items = children.items;
    final breadcrumbs = await _safeBreadcrumbs(node);

    return NodeDetailsViewData(
      node: node,
      breadcrumbs: breadcrumbs,
      statistics: NodeStatistics(
        containerCount: containers.length,
        itemCount: items.length,
        photoCount: node.images.length,
        tagCount: nodeTags(node).length,
      ),
      previewContainers: containers
          .take(NodeDetailsViewData.previewLimit)
          .toList(),
      previewItems: items.take(NodeDetailsViewData.previewLimit).toList(),
      totalDirectContainers: containers.length,
      totalDirectItems: items.length,
    );
  }

  @override
  Future<List<ExplorerRowData>> getExplorerChildren({
    required String parentNodeId,
    required NodeType parentNodeType,
    required NodeExplorerType explorerType,
  }) async {
    final node = await _loadNode(parentNodeId, parentNodeType);
    final children = await _loadDirectChildren(node);
    return switch (explorerType) {
      NodeExplorerType.containers => [
        for (final container in children.containers)
          ExplorerContainerRow(container),
      ],
      NodeExplorerType.items => [
        for (final item in children.items) ExplorerItemRow(item),
      ],
    };
  }

  Future<StorageNode> _loadNode(String nodeId, NodeType nodeType) async {
    return switch (nodeType) {
      NodeType.space => (await _storage.getSpaceTree(nodeId)),
      NodeType.container => (await _storage.getContainerTree(nodeId)),
      NodeType.item => _storage.getItem(nodeId),
    };
  }

  Future<
    ({List<ChildContainerSummary> containers, List<ChildItemSummary> items})
  >
  _loadDirectChildren(StorageNode node) async {
    if (node.type == NodeType.item) {
      return (
        containers: <ChildContainerSummary>[],
        items: <ChildItemSummary>[],
      );
    }

    final tree = node is StorageTreeNode
        ? node
        : switch (node.type) {
            NodeType.space => await _storage.getSpaceTree(node.id),
            NodeType.container => await _storage.getContainerTree(node.id),
            NodeType.item => null,
          };

    if (tree == null) {
      return (
        containers: <ChildContainerSummary>[],
        items: <ChildItemSummary>[],
      );
    }

    final containers = <ChildContainerSummary>[];
    final items = <ChildItemSummary>[];

    for (final child in tree.children) {
      switch (child.type) {
        case NodeType.container:
          containers.add(_mapContainer(child));
        case NodeType.item:
          items.add(_mapItem(child));
        case NodeType.space:
          break;
      }
    }

    return (containers: containers, items: items);
  }

  ChildContainerSummary _mapContainer(StorageTreeNode node) {
    final itemCount = node.children
        .where((c) => c.type == NodeType.item)
        .length;
    return ChildContainerSummary(
      id: node.id,
      name: node.name,
      itemCount: itemCount,
      thumbnailUrl: firstImageUrl(node),
    );
  }

  Future<List<PathSegment>> _safeBreadcrumbs(StorageNode node) async {
    try {
      return await _breadcrumbResolver.resolve(node);
    } on Object {
      return const [];
    }
  }

  ChildItemSummary _mapItem(StorageTreeNode node) {
    return ChildItemSummary(
      id: node.id,
      name: node.name,
      descriptionPreview: truncatePreview(nodeDescription(node)),
      tags: nodeTags(node),
      thumbnailUrl: firstImageUrl(node),
      updatedAt: node.updatedAt,
    );
  }
}
