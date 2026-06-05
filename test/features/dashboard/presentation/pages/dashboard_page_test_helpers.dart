import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class FakeDashboardRepository implements StorageRepository {
  FakeDashboardRepository({
    this.shouldThrow = false,
    this.neverComplete = false,
  });

  final bool shouldThrow;
  final bool neverComplete;

  @override
  Future<List<StorageNode>> listSpaces() async {
    if (neverComplete) return Completer<List<StorageNode>>().future;
    if (shouldThrow) throw StateError('boom');
    return const [
      StorageNode(
        id: 'space-1',
        type: NodeType.space,
        name: 'Garage',
        spaceId: 'space-1',
      ),
    ];
  }

  @override
  Future<StorageTreeNode> getSpaceTree(String id) async {
    return const StorageTreeNode(
      id: 'space-1',
      type: NodeType.space,
      name: 'Garage',
      spaceId: 'space-1',
      children: [
        StorageTreeNode(
          id: 'container-1',
          type: NodeType.container,
          name: 'Cable Bin',
          spaceId: 'space-1',
          children: [
            StorageTreeNode(
              id: 'item-1',
              type: NodeType.item,
              name: 'Extension Cord',
              spaceId: 'space-1',
            ),
          ],
        ),
      ],
    );
  }

  @override
  Future<StorageNode> createContainer({
    required String name,
    required String parentId,
  }) => throw UnimplementedError();
  @override
  Future<StorageNode> createItem({
    required String name,
    required String parentId,
  }) => throw UnimplementedError();
  @override
  Future<StorageNode> createSpace(String name) => throw UnimplementedError();
  @override
  Future<void> deleteContainer(String id) => throw UnimplementedError();
  @override
  Future<void> deleteItem(String id) => throw UnimplementedError();
  @override
  Future<void> deleteSpace(String id) => throw UnimplementedError();
  @override
  Future<StorageTreeNode> getContainerTree(String id) =>
      throw UnimplementedError();
  @override
  Future<StorageNode> getItem(String id) => throw UnimplementedError();
  @override
  Future<ItemPath> getItemPath(String id) => throw UnimplementedError();
  @override
  Future<List<StorageNode>> listContainerItems(String id) =>
      throw UnimplementedError();
  @override
  Future<StorageNode> moveContainer({
    required String id,
    required String parentId,
  }) => throw UnimplementedError();
  @override
  Future<StorageNode> moveItem({
    required String id,
    required String parentId,
  }) => throw UnimplementedError();
  @override
  Future<StorageNode> updateContainer(String id, String name) =>
      throw UnimplementedError();
  @override
  Future<StorageNode> updateItem(String id, String name) =>
      throw UnimplementedError();
  @override
  Future<StorageNode> updateSpace(String id, String name) =>
      throw UnimplementedError();
}

Future<void> pumpDashboardPage(
  WidgetTester tester,
  StorageRepository repository, {
  Size? size,
}) async {
  await sl.reset();
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(repository));
  if (size != null) {
    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));
  }
  addTearDown(sl.reset);
  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.light(), home: const DashboardPage()),
  );
}
