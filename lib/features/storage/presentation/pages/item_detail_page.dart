import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/presentation/bloc/item_breadcrumb_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/item_detail_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/storage/presentation/widgets/breadcrumb_bar.dart';
import 'package:keeply/shared/widgets/app_button.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ItemDetailCubit>()..load(itemId)),
        BlocProvider(create: (_) => sl<ItemBreadcrumbCubit>()..load(itemId)),
      ],
      child: AppScaffold(
        title: 'Item',
        actions: [
          IconButton(
            onPressed: () => context.go('/move/item/$itemId'),
            icon: const Icon(Icons.drive_file_move_outline),
          ),
        ],
        body: const _ItemDetailView(),
      ),
    );
  }
}

class _ItemDetailView extends StatelessWidget {
  const _ItemDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailCubit, ResourceState<StorageNode>>(
      builder: (context, state) {
        if (state.status == ResourceStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == ResourceStatus.error) {
          return ErrorBanner(message: state.message ?? 'Unable to load item');
        }
        final item = state.data;
        if (item == null) return const SizedBox.shrink();
        return ListView(
          children: [
            BlocBuilder<ItemBreadcrumbCubit, ResourceState<ItemPath>>(
              builder: (context, pathState) {
                final path = pathState.data?.path ?? const <PathSegment>[];
                if (path.isEmpty) return const SizedBox.shrink();
                return BreadcrumbBar(
                  segments: path,
                  onTap: (segment) {
                    switch (segment.type) {
                      case NodeType.space:
                        context.go('/spaces/${segment.id}');
                      case NodeType.container:
                        context.go('/containers/${segment.id}');
                      case NodeType.item:
                        context.go('/items/${segment.id}');
                    }
                  },
                );
              },
            ),
            SizedBox(height: AppTheme.tokens.spacing.lg),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppTheme.tokens.components.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: AppTheme.tokens.spacing.sm),
                    Text('Stored in: ${item.spaceId}'),
                    SizedBox(height: AppTheme.tokens.spacing.lg),
                    AppButton(
                      label: 'Delete Item',
                      variant: AppButtonVariant.destructive,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
