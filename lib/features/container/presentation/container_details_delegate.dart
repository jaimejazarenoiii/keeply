import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/features/node_details/domain/delegates/node_details_delegate.dart';
import 'package:keeply/features/node_details/presentation/widgets/expandable_keeply_fab.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class ContainerDetailsDelegate implements NodeDetailsDelegate {
  @override
  String get typeBadgeLabel => 'Container';

  @override
  IconData get placeholderIcon => Icons.inventory_2_outlined;

  @override
  bool get canCreateChildren => true;

  @override
  List<Widget> buildAppBarActions(BuildContext context, StorageNode node) {
    return [
      IconButton(
        onPressed: () => context.push('/move/container/${node.id}'),
        icon: const Icon(Icons.drive_file_move_outline),
        tooltip: 'Move container',
      ),
    ];
  }

  @override
  Widget? buildFab(BuildContext context, StorageNode node) {
    return ExpandableKeeplyFab(
      onCreateContainer: () => context.push('/containers/new/${node.id}'),
      onCreateItem: () => context.push('/items/new/${node.id}'),
    );
  }

  @override
  NodeEmptyStateAction? containerEmptyAction(
    BuildContext context,
    StorageNode node,
  ) {
    return NodeEmptyStateAction(
      label: 'Add Container',
      onAction: () => context.push('/containers/new/${node.id}'),
    );
  }

  @override
  NodeEmptyStateAction? itemEmptyAction(
    BuildContext context,
    StorageNode node,
  ) {
    return NodeEmptyStateAction(
      label: 'Add Item',
      onAction: () => context.push('/items/new/${node.id}'),
    );
  }
}
