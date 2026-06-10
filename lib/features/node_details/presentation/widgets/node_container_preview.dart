import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/delegates/node_details_delegate.dart';
import 'package:keeply/features/node_details/domain/entities/child_container_summary.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/domain/node_route_params.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_preview_thumbnail_card.dart';
import 'package:keeply/features/node_details/presentation/widgets/container_child_card.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_empty_state.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeContainerPreview extends StatelessWidget {
  const NodeContainerPreview({
    super.key,
    required this.node,
    required this.containers,
    required this.totalCount,
    required this.hasMore,
    required this.delegate,
  });

  final StorageNode node;
  final List<ChildContainerSummary> containers;
  final int totalCount;
  final bool hasMore;
  final NodeDetailsDelegate delegate;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Containers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: spacing.sm),
            _CountBadge(count: totalCount),
          ],
        ),
        SizedBox(height: spacing.md),
        if (containers.isEmpty)
          _buildEmpty(context)
        else ...[
          SizedBox(
            height: DashboardPreviewThumbnailCard.listHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: spacing.xs),
              itemCount: containers.length,
              separatorBuilder: (_, __) => SizedBox(width: spacing.md),
              itemBuilder: (context, index) {
                final container = containers[index];
                return ContainerChildCard(
                  container: container,
                  onTap: () => context.push(
                    nodeDetailsPath(NodeType.container, container.id),
                  ),
                ).animate(delay: (40 * index).ms).fadeIn(duration: 300.ms).slideY(
                  begin: 0.06,
                  end: 0,
                );
              },
            ),
          ),
          if (hasMore) ...[
            SizedBox(height: spacing.md),
            TextButton(
              onPressed: () => context.push(
                nodeExplorerPath(
                  node.type,
                  node.id,
                  NodeExplorerType.containers,
                ),
              ),
              child: const Text('View All Containers'),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final action = delegate.containerEmptyAction(context, node);
    if (node.type == NodeType.item || action == null) {
      return const NodeEmptyState(
        title: 'No containers yet',
        message: 'Items do not contain child containers.',
      );
    }
    return NodeEmptyState(
      title: 'No containers yet',
      message:
          'Create a container to organize items inside this ${node.type.name}.',
      actionLabel: action.label,
      onAction: action.onAction,
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.tokens.colors.primaryLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppTheme.tokens.colors.primaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
