import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_containers_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_create_fab.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_items_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_overview_cards.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_sections_panel.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_responsive_container.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_search_prompt.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_spaces_section.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_error_view.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton.dart';
import 'package:keeply/shared/widgets/app_background_pattern.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()..add(const DashboardRequested()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  final _createFabKey = GlobalKey<DashboardCreateFabState>();
  var _createMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.tokens.colors.primaryLight,
      floatingActionButton: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is! DashboardLoaded) return const SizedBox.shrink();
          return DashboardCreateFab(
            key: _createFabKey,
            onOpenChanged: (isOpen) {
              if (!mounted) return;
              setState(() => _createMenuOpen = isOpen);
            },
            onCreateSpace: () => context.push('/spaces/new'),
            onCreateContainer: () => _openCreateContainer(context, state),
            onCreateItem: () => context.push('/items/new'),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AppBackgroundPattern(
            variant: AppBackgroundPatternVariant.dashboard,
          ),
          DashboardResponsiveContainer(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: switch (state) {
                    DashboardLoading() => Padding(
                      key: const ValueKey('dashboard-loading'),
                      padding: EdgeInsets.all(spacing.lg),
                      child: const DashboardSkeleton(),
                    ),
                    DashboardLoaded() => _LoadedDashboard(
                      key: const ValueKey('dashboard-loaded'),
                      state: state,
                    ),
                    DashboardError() => Padding(
                      key: const ValueKey('dashboard-error'),
                      padding: EdgeInsets.all(spacing.lg),
                      child: DashboardErrorView(
                        message: state.message,
                        onRetry: () => context.read<DashboardBloc>().add(
                          const DashboardRequested(),
                        ),
                      ),
                    ),
                  },
                );
              },
            ),
          ),
          Positioned.fill(
            child: DashboardCreateFabOverlay(
              visible: _createMenuOpen,
              onDismiss: () => _createFabKey.currentState?.close(),
            ),
          ),
        ],
      ),
    );
  }

  void _openCreateContainer(BuildContext context, DashboardLoaded state) {
    final spaces = state.summary.latestSpaces;
    if (spaces.isEmpty) {
      context.push('/spaces/new');
      return;
    }
    context.push('/containers/new/${spaces.first.id}');
  }
}

class _LoadedDashboard extends StatelessWidget {
  const _LoadedDashboard({
    super.key,
    required this.state,
  });

  final DashboardLoaded state;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final summary = state.summary;
    final hasContent =
        summary.totalSpaces + summary.totalContainers + summary.totalItems > 0;
    final showRecentPanel = hasContent;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(
          const DashboardRequested(keepCurrentContent: true),
        );
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(spacing.lg, spacing.lg, spacing.lg, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardHeader(
                    onSearchTap: () {
                      // Dedicated search view will be wired here.
                    },
                  ),
                  SizedBox(height: spacing.lg),
                  const DashboardSearchPrompt(),
                  SizedBox(height: spacing.lg),
                  DashboardOverviewCards(
                    summary: summary,
                    onSpacesTap: () => context.push('/spaces'),
                    onContainersTap: () => context.push('/spaces'),
                    onItemsTap: () => context.push('/spaces'),
                  ),
                  if (!hasContent) ...[
                    SizedBox(height: spacing.lg),
                    DashboardEmptyState(
                      message:
                          'Create your first Space to start organizing your things.',
                      actionLabel: 'Create Space',
                      onAction: () => context.push('/spaces/new'),
                    ),
                  ] else
                    SizedBox(height: spacing.lg),
                ],
              ),
            ),
          ),
          if (showRecentPanel)
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final remaining = constraints.remainingPaintExtent;
                final minHeight = remaining.isFinite && remaining > 0
                    ? remaining
                    : null;
                return SliverToBoxAdapter(
                  child: DashboardRecentSectionsPanel(
                    minHeight: minHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardSpacesSection(
                          spaces: summary.latestSpaces,
                          onOpenSpace: (space) =>
                              context.push('/spaces/${space.id}'),
                          onShowAll: () => context.push('/spaces'),
                          onCreateSpace: () => context.push('/spaces/new'),
                        ),
                        SizedBox(height: spacing.md),
                        Divider(color: AppTheme.tokens.colors.divider),
                        SizedBox(height: spacing.md),
                        DashboardContainersSection(
                          containers: summary.latestContainers,
                          onOpenContainer: (container) =>
                              context.push('/containers/${container.id}'),
                          onShowAll: () => context.push('/spaces'),
                          onCreateSpace: () => context.push('/spaces'),
                        ),
                        SizedBox(height: spacing.md),
                        Divider(color: AppTheme.tokens.colors.divider),
                        SizedBox(height: spacing.md),
                        DashboardItemsSection(
                          items: summary.latestItems,
                          onOpenItem: (item) =>
                              context.push('/items/${item.id}'),
                          onShowAll: () => context.push('/spaces'),
                          onCreateSpace: () => context.push('/spaces'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          if (state.isRefreshing)
            const SliverToBoxAdapter(child: LinearProgressIndicator()),
        ],
      ),
    );
  }
}
