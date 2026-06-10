import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class DashboardApiCounts extends Equatable {
  const DashboardApiCounts({
    required this.spaces,
    required this.containers,
    required this.items,
  });

  factory DashboardApiCounts.fromJson(Map<String, dynamic> json) =>
      DashboardApiCounts(
        spaces: json['spaces'] as int? ?? 0,
        containers: json['containers'] as int? ?? 0,
        items: json['items'] as int? ?? 0,
      );

  final int spaces;
  final int containers;
  final int items;

  @override
  List<Object?> get props => [spaces, containers, items];
}

class DashboardApiSummary extends Equatable {
  const DashboardApiSummary({
    required this.counts,
    required this.recentSpaces,
    required this.recentContainers,
    required this.recentItems,
  });

  factory DashboardApiSummary.fromJson(Map<String, dynamic> json) {
    final recent = json['recent'] as Map<String, dynamic>? ?? const {};
    return DashboardApiSummary(
      counts: DashboardApiCounts.fromJson(
        json['counts'] as Map<String, dynamic>? ?? const {},
      ),
      recentSpaces: _parseNodes(recent['spaces']),
      recentContainers: _parseNodes(recent['containers']),
      recentItems: _parseNodes(recent['items']),
    );
  }

  final DashboardApiCounts counts;
  final List<StorageNode> recentSpaces;
  final List<StorageNode> recentContainers;
  final List<StorageNode> recentItems;

  @override
  List<Object?> get props => [
    counts,
    recentSpaces,
    recentContainers,
    recentItems,
  ];
}

List<StorageNode> _parseNodes(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map<String, dynamic>>()
      .map(StorageNode.fromJson)
      .toList();
}
