import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/delegates/node_details_delegate.dart';
import 'package:keeply/features/node_details/domain/entities/node_details_view_data.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_details_cubit.dart';
import 'package:keeply/features/node_details/presentation/node_details_delegate_factory.dart';
import 'package:keeply/features/node_details/presentation/pages/fullscreen_image_preview.dart';
import 'package:keeply/features/node_details/presentation/widgets/loading/node_details_skeleton.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_container_preview.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_error_view.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_pattern_background.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_details_responsive_container.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_hero_carousel.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_item_preview.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_metadata_section.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeDetailsPage extends StatelessWidget {
  const NodeDetailsPage({
    super.key,
    required this.nodeId,
    required this.nodeType,
  });

  final String nodeId;
  final NodeType nodeType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<NodeDetailsCubit>()..load(nodeId: nodeId, nodeType: nodeType),
      child: _NodeDetailsView(nodeType: nodeType),
    );
  }
}

class _NodeDetailsView extends StatelessWidget {
  const _NodeDetailsView({required this.nodeType});

  final NodeType nodeType;

  @override
  Widget build(BuildContext context) {
    final delegate = nodeDetailsDelegateFor(nodeType);
    final carouselHeight = nodeCarouselHeight(context);

    return Scaffold(
      backgroundColor: AppTheme.tokens.colors.background,
      appBar: AppBar(
        title: Text(delegate.typeBadgeLabel),
        actions: [
          BlocBuilder<NodeDetailsCubit, NodeDetailsState>(
            buildWhen: (prev, curr) {
              final prevNode = switch (prev) {
                NodeDetailsLoaded(:final data) => data.node,
                _ => null,
              };
              final currNode = switch (curr) {
                NodeDetailsLoaded(:final data) => data.node,
                _ => null,
              };
              return prevNode?.id != currNode?.id;
            },
            builder: (context, state) {
              final node = switch (state) {
                NodeDetailsLoaded(:final data) => data.node,
                _ => null,
              };
              if (node == null) return const SizedBox.shrink();
              return Row(children: delegate.buildAppBarActions(context, node));
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<NodeDetailsCubit, NodeDetailsState>(
        builder: (context, state) {
          final node = switch (state) {
            NodeDetailsLoaded(:final data) => data.node,
            _ => null,
          };
          if (node == null) return const SizedBox.shrink();
          return delegate.buildFab(context, node) ?? const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<NodeDetailsCubit, NodeDetailsState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: switch (state) {
              NodeDetailsLoading() => NodeDetailsSkeleton(
                key: const ValueKey('node-details-loading'),
                carouselHeight: carouselHeight,
                nodeType: nodeType,
              ),
              NodeDetailsError(:final message) => NodeDetailsPatternBackground(
                key: const ValueKey('node-details-error'),
                child: NodeDetailsErrorView(
                  message: message,
                  onRetry: () => context.read<NodeDetailsCubit>().retry(),
                ),
              ),
              NodeDetailsLoaded(:final data, :final isRefreshing) => Stack(
                key: const ValueKey('node-details-loaded'),
                children: [
                  RefreshIndicator(
                    color: AppTheme.tokens.colors.primary,
                    onRefresh: () => context.read<NodeDetailsCubit>().refresh(),
                    child:
                        _LoadedContent(
                              data: data,
                              delegate: delegate,
                              carouselHeight: carouselHeight,
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideY(
                              begin: 0.02,
                              end: 0,
                              duration: 400.ms,
                            ),
                  ),
                  if (isRefreshing)
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            },
          );
        },
      ),
    );
  }
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({
    required this.data,
    required this.delegate,
    required this.carouselHeight,
  });

  final NodeDetailsViewData data;
  final NodeDetailsDelegate delegate;
  final double carouselHeight;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final padding = nodePagePadding(context);
    final node = data.node;
    final sortedImages = [...node.images]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final mediaQuery = MediaQuery.of(context);
    final minPatternHeight =
        mediaQuery.size.height -
        mediaQuery.padding.top -
        kToolbarHeight -
        nodeCarouselSectionHeight(context, imageCount: sortedImages.length);

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: BlocSelector<NodeDetailsCubit, NodeDetailsState, StorageNode>(
            selector: (state) => switch (state) {
              NodeDetailsLoaded(:final data) => data.node,
              _ => node,
            },
            builder: (context, selectedNode) {
              return NodeHeroCarousel(
                node: selectedNode,
                placeholderIcon: delegate.placeholderIcon,
                onImageTap: sortedImages.isEmpty
                    ? null
                    : (index) {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => FullscreenImagePreview(
                              nodeId: selectedNode.id,
                              images: sortedImages,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: minPatternHeight.clamp(0, double.infinity),
            ),
            child: NodeDetailsPatternBackground(
              child: NodeDetailsResponsiveContainer(
                child: Padding(
                  padding: padding.copyWith(top: spacing.lg, bottom: spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NodeMetadataSection(
                        node: node,
                        typeBadgeLabel: delegate.typeBadgeLabel,
                        breadcrumbs: data.breadcrumbs,
                      ),
                      if (node.type != NodeType.item) ...[
                        SizedBox(height: spacing.xl),
                        NodeContainerPreview(
                          node: node,
                          containers: data.previewContainers,
                          totalCount: data.totalDirectContainers,
                          hasMore: data.hasMoreContainers,
                          delegate: delegate,
                        ),
                        SizedBox(height: spacing.xl),
                        NodeItemPreview(
                          node: node,
                          items: data.previewItems,
                          totalCount: data.totalDirectItems,
                          hasMore: data.hasMoreItems,
                          delegate: delegate,
                        ),
                      ],
                      SizedBox(height: spacing.xxl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
