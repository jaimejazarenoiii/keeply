import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/presentation/bloc/move_destination_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/storage/presentation/widgets/node_tree_row.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class MoveDestinationPage extends StatelessWidget {
  const MoveDestinationPage({
    super.key,
    required this.nodeType,
    required this.nodeId,
  });
  final String nodeType;
  final String nodeId;
  @override
  Widget build(BuildContext context) {
    final type = nodeType == 'container' ? NodeType.container : NodeType.item;
    return BlocProvider(
      create: (_) =>
          sl<MoveDestinationCubit>()..load(movingType: type, movingId: nodeId),
      child: AppScaffold(
        title: 'Move to...',
        body:
            BlocConsumer<
              MoveDestinationCubit,
              ResourceState<List<StorageTreeNode>>
            >(
              listener: (context, state) {
                if (state.status == ResourceStatus.success)
                  context.go('/spaces');
              },
              builder: (context, state) {
                if (state.status == ResourceStatus.loading ||
                    state.status == ResourceStatus.submitting)
                  return const Center(child: CircularProgressIndicator());
                if (state.status == ResourceStatus.error)
                  return ErrorBanner(
                    message: state.message ?? 'Unable to move',
                  );
                final roots = state.data ?? const <StorageTreeNode>[];
                return ListView(
                  children: [
                    for (final root in roots)
                      ..._rows(context, root, state.disabledIds),
                  ],
                );
              },
            ),
      ),
    );
  }

  List<Widget> _rows(
    BuildContext context,
    StorageTreeNode node,
    Set<String> disabled, [
    int depth = 0,
  ]) => [
    NodeTreeRow(
      node: node,
      depth: depth,
      enabled: !disabled.contains(node.id),
      onTap: () => context.read<MoveDestinationCubit>().moveTo(node.id),
    ),
    for (final child in node.children)
      ..._rows(context, child, disabled, depth + 1),
  ];
}
