import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';

class NodeExplorerPaginationFooter extends StatelessWidget {
  const NodeExplorerPaginationFooter({
    super.key,
    required this.data,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final NodeExplorerPageData data;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;

    if (isLoadingMore) {
      return Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (data.hasMore) {
      return Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: onLoadMore,
            child: const Text('Show More'),
          ),
        ),
      );
    }

    if (data.totalCount == 0) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Center(
        child: Text(
          'Showing all ${data.totalCount} ${data.footerLabel}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.tokens.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
