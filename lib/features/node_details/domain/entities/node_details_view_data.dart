import 'package:equatable/equatable.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';
import 'package:keeply/features/node_details/domain/entities/node_statistics.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeDetailsViewData extends Equatable {
  const NodeDetailsViewData({
    required this.node,
    required this.statistics,
    required this.breadcrumbs,
    required this.previewContainers,
    required this.previewItems,
    required this.totalDirectContainers,
    required this.totalDirectItems,
  });

  static const previewLimit = 10;

  final StorageNode node;
  final NodeStatistics statistics;
  final List<PathSegment> breadcrumbs;
  final List<ChildContainerSummary> previewContainers;
  final List<ChildItemSummary> previewItems;
  final int totalDirectContainers;
  final int totalDirectItems;

  bool get hasMoreContainers => totalDirectContainers > previewLimit;
  bool get hasMoreItems => totalDirectItems > previewLimit;

  @override
  List<Object?> get props => [
    node,
    statistics,
    breadcrumbs,
    previewContainers,
    previewItems,
    totalDirectContainers,
    totalDirectItems,
  ];
}
