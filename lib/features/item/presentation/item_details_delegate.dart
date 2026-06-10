import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/features/node_details/domain/delegates/node_details_delegate.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class ItemDetailsDelegate implements NodeDetailsDelegate {
  @override
  String get typeBadgeLabel => 'Item';

  @override
  IconData get placeholderIcon => Icons.category_outlined;

  @override
  bool get canCreateChildren => false;

  @override
  List<Widget> buildAppBarActions(BuildContext context, StorageNode node) {
    return [
      IconButton(
        onPressed: () => context.push('/move/item/${node.id}'),
        icon: const Icon(Icons.drive_file_move_outline),
        tooltip: 'Move item',
      ),
    ];
  }

  @override
  Widget? buildFab(BuildContext context, StorageNode node) => null;

  @override
  NodeEmptyStateAction? containerEmptyAction(
    BuildContext context,
    StorageNode node,
  ) => null;

  @override
  NodeEmptyStateAction? itemEmptyAction(
    BuildContext context,
    StorageNode node,
  ) => null;
}
