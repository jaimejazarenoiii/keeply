import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeTreeRow extends StatelessWidget {
  const NodeTreeRow({
    super.key,
    required this.node,
    this.depth = 0,
    this.onTap,
    this.enabled = true,
  });
  final StorageNode node;
  final int depth;
  final VoidCallback? onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    final icon = switch (node.type) {
      NodeType.space => Icons.home_work_outlined,
      NodeType.container => Icons.inventory_2_outlined,
      NodeType.item => Icons.category_outlined,
    };
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: AppTheme.tokens.spacing.md + depth * AppTheme.tokens.spacing.lg,
          right: AppTheme.tokens.spacing.sm,
        ),
        leading: CircleAvatar(
          backgroundColor: AppTheme.tokens.colors.primaryLight,
          child: Icon(icon, color: AppTheme.tokens.colors.primaryDark),
        ),
        title: Text(node.name),
        subtitle: Text(node.type.name.toUpperCase()),
        trailing: const Icon(Icons.chevron_right),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}
