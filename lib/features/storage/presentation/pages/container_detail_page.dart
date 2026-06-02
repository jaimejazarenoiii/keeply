import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/presentation/bloc/container_detail_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/storage/presentation/widgets/node_tree_row.dart';
import 'package:keeply/shared/widgets/app_button.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class ContainerDetailPage extends StatelessWidget {
  const ContainerDetailPage({super.key, required this.containerId});
  final String containerId;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ContainerDetailCubit>()..load(containerId),
    child: AppScaffold(
      title: 'Container',
      actions: [
        IconButton(
          onPressed: () => context.go('/move/container/$containerId'),
          icon: const Icon(Icons.drive_file_move_outline),
        ),
      ],
      body: BlocBuilder<ContainerDetailCubit, ResourceState<StorageTreeNode>>(
        builder: (context, state) {
          if (state.status == ResourceStatus.loading)
            return const Center(child: CircularProgressIndicator());
          if (state.status == ResourceStatus.error)
            return ErrorBanner(
              message: state.message ?? 'Unable to load container',
            );
          final root = state.data;
          if (root == null) return const SizedBox.shrink();
          return ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Add Container',
                      onPressed: () => context.go('/containers/new/${root.id}'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Add Item',
                      variant: AppButtonVariant.secondary,
                      onPressed: () => context.go('/items/new/${root.id}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._rows(context, root),
            ],
          );
        },
      ),
    ),
  );
  List<Widget> _rows(
    BuildContext context,
    StorageTreeNode node, [
    int depth = 0,
  ]) => [
    NodeTreeRow(
      node: node,
      depth: depth,
      onTap: () {
        switch (node.type) {
          case NodeType.space:
            context.go('/spaces/${node.id}');
          case NodeType.container:
            context.go('/containers/${node.id}');
          case NodeType.item:
            context.go('/items/${node.id}');
        }
      },
    ),
    for (final child in node.children) ..._rows(context, child, depth + 1),
  ];
}
