import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/domain/node_route_params.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_explorer_cubit.dart';
import 'package:keeply/features/node_details/presentation/widgets/container_child_card.dart';
import 'package:keeply/features/node_details/presentation/widgets/item_child_card.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/container_card_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_responsive_container.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_empty_state.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_explorer_pagination_footer.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_explorer_search_bar.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class NodeExplorerPage extends StatelessWidget {
  const NodeExplorerPage({
    super.key,
    required this.parentNodeId,
    required this.parentNodeType,
    required this.explorerType,
    this.initialQuery,
  });

  final String parentNodeId;
  final NodeType parentNodeType;
  final NodeExplorerType explorerType;
  final String? initialQuery;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NodeExplorerCubit>()
        ..load(
          parentNodeId: parentNodeId,
          parentNodeType: parentNodeType,
          explorerType: explorerType,
          initialQuery: initialQuery ?? '',
        ),
      child: _NodeExplorerView(explorerType: explorerType),
    );
  }
}

class _NodeExplorerView extends StatelessWidget {
  const _NodeExplorerView({required this.explorerType});

  final NodeExplorerType explorerType;

  @override
  Widget build(BuildContext context) {
    final title = switch (explorerType) {
      NodeExplorerType.containers => 'All Containers',
      NodeExplorerType.items => 'All Items',
    };
    final hint = switch (explorerType) {
      NodeExplorerType.containers => 'Search containers',
      NodeExplorerType.items => 'Search items',
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocBuilder<NodeExplorerCubit, NodeExplorerState>(
        builder: (context, state) {
          return switch (state) {
            NodeExplorerLoading() => ListView(
              padding: nodePagePadding(context).copyWith(top: 24),
              children: const [
                ContainerCardSkeleton(),
                SizedBox(height: 16),
                ContainerCardSkeleton(),
              ],
            ),
            NodeExplorerError(:final message) => ErrorBanner(
              message: message,
              onRetry: () => context.read<NodeExplorerCubit>().retry(),
            ),
            NodeExplorerLoaded(:final data) => _ExplorerBody(
              data: data,
              hint: hint,
              isLoadingMore: false,
            ),
            NodeExplorerLoadingMore(:final data) => _ExplorerBody(
              data: data,
              hint: hint,
              isLoadingMore: true,
            ),
          };
        },
      ),
    );
  }
}

class _ExplorerBody extends StatelessWidget {
  const _ExplorerBody({
    required this.data,
    required this.hint,
    required this.isLoadingMore,
  });

  final NodeExplorerPageData data;
  final String hint;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final hasSearch = data.searchQuery.trim().isNotEmpty;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: NodeDetailsResponsiveContainer(
            child: Padding(
              padding: nodePagePadding(context).copyWith(
                top: spacing.lg,
                bottom: spacing.md,
              ),
              child: NodeExplorerSearchBar(
                hint: hint,
                initialValue: data.searchQuery,
                onChanged: context.read<NodeExplorerCubit>().search,
              ),
            ),
          ),
        ),
        if (data.visibleResults.isEmpty)
          SliverToBoxAdapter(
            child: NodeEmptyState(
              title: hasSearch
                  ? 'No results found'
                  : 'No ${data.footerLabel} yet',
              message: hasSearch
                  ? 'Try a different search term.'
                  : 'Nothing to show here yet.',
              actionLabel: hasSearch ? 'Clear search' : null,
              onAction: hasSearch
                  ? () => context.read<NodeExplorerCubit>().search('')
                  : null,
            ),
          )
        else
          SliverPadding(
            padding: nodePagePadding(context),
            sliver: SliverList.separated(
              itemCount: data.visibleResults.length,
              separatorBuilder: (_, __) => SizedBox(height: spacing.md),
              itemBuilder: (context, index) {
                final row = data.visibleResults[index];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: switch (row) {
                    ExplorerContainerRow(:final data) => ContainerChildCard(
                      key: ValueKey('container-${data.id}'),
                      container: data,
                      width: double.infinity,
                      onTap: () => context.push(
                        nodeDetailsPath(NodeType.container, data.id),
                      ),
                    ),
                    ExplorerItemRow(:final data) => ItemChildCard(
                      key: ValueKey('item-${data.id}'),
                      item: data,
                      onTap: () => context.push(
                        nodeDetailsPath(NodeType.item, data.id),
                      ),
                    ),
                  },
                );
              },
            ),
          ),
        SliverToBoxAdapter(
          child: NodeExplorerPaginationFooter(
            data: data,
            isLoadingMore: isLoadingMore,
            onLoadMore: () => context.read<NodeExplorerCubit>().loadMore(),
          ),
        ),
      ],
    );
  }
}
