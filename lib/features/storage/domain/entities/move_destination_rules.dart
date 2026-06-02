import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';

class MoveDestinationRules {
  const MoveDestinationRules();
  Set<String> disabledIds({
    required NodeType movingType,
    required String movingId,
    required List<StorageTreeNode> roots,
  }) {
    final disabled = <String>{};
    void visit(StorageTreeNode node, {bool insideMoving = false}) {
      if (node.type == NodeType.item) disabled.add(node.id);
      final nextInside = insideMoving || node.id == movingId;
      if (movingType == NodeType.container && nextInside) disabled.add(node.id);
      for (final child in node.children) visit(child, insideMoving: nextInside);
    }

    for (final root in roots) visit(root);
    return disabled;
  }
}
