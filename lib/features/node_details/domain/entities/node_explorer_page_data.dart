import 'package:equatable/equatable.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

enum NodeExplorerType { containers, items }

sealed class ExplorerRowData extends Equatable {
  const ExplorerRowData();
}

class ExplorerContainerRow extends ExplorerRowData {
  const ExplorerContainerRow(this.data);
  final ChildContainerSummary data;
  @override
  List<Object?> get props => [data];
}

class ExplorerItemRow extends ExplorerRowData {
  const ExplorerItemRow(this.data);
  final ChildItemSummary data;
  @override
  List<Object?> get props => [data];
}

class NodeExplorerPageData extends Equatable {
  const NodeExplorerPageData({
    required this.parentNodeId,
    required this.parentNodeType,
    required this.explorerType,
    required this.searchQuery,
    required this.allResults,
    required this.visibleResults,
    this.pageSize = 20,
  });

  final String parentNodeId;
  final NodeType parentNodeType;
  final NodeExplorerType explorerType;
  final String searchQuery;
  final List<ExplorerRowData> allResults;
  final List<ExplorerRowData> visibleResults;
  final int pageSize;

  int get loadedCount => visibleResults.length;
  int get totalCount => allResults.length;
  bool get hasMore => loadedCount < totalCount;

  String get footerLabel => switch (explorerType) {
    NodeExplorerType.containers => 'containers',
    NodeExplorerType.items => 'items',
  };

  @override
  List<Object?> get props => [
    parentNodeId,
    parentNodeType,
    explorerType,
    searchQuery,
    allResults,
    visibleResults,
    pageSize,
  ];
}
