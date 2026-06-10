import 'package:flutter/material.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeEmptyStateAction {
  const NodeEmptyStateAction({
    required this.label,
    required this.onAction,
  });

  final String label;
  final VoidCallback onAction;
}

abstract class NodeDetailsDelegate {
  String get typeBadgeLabel;

  IconData get placeholderIcon;

  List<Widget> buildAppBarActions(BuildContext context, StorageNode node);

  Widget? buildFab(BuildContext context, StorageNode node);

  NodeEmptyStateAction? containerEmptyAction(
    BuildContext context,
    StorageNode node,
  );

  NodeEmptyStateAction? itemEmptyAction(BuildContext context, StorageNode node);

  bool get canCreateChildren;
}
