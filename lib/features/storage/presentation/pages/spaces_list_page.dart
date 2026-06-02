import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/storage/presentation/bloc/spaces_cubit.dart';
import 'package:keeply/features/storage/presentation/widgets/node_tree_row.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/empty_state.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class SpacesListPage extends StatelessWidget {
  const SpacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SpacesCubit>()..load(),
      child: const _SpacesListView(),
    );
  }
}

class _SpacesListView extends StatelessWidget {
  const _SpacesListView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Spaces',
      actions: [
        IconButton(
          onPressed: () => context.go('/settings'),
          icon: const Icon(Icons.person_outline),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/spaces/new'),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SpacesCubit, ResourceState<List<StorageNode>>>(
        builder: (context, state) {
          if (state.status == ResourceStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ResourceStatus.error) {
            return ErrorBanner(
              message: state.message ?? 'Unable to load spaces',
              onRetry: context.read<SpacesCubit>().load,
            );
          }
          final spaces = state.data ?? const <StorageNode>[];
          if (spaces.isEmpty) {
            return EmptyState(
              title: 'No Spaces yet',
              message: 'Create your first top-level storage location.',
              actionLabel: 'Add Space',
              onAction: () => context.go('/spaces/new'),
            );
          }
          return ListView(
            children: [
              for (final space in spaces)
                NodeTreeRow(
                  node: space,
                  onTap: () => context.go('/spaces/${space.id}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
