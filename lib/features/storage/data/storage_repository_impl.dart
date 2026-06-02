import 'package:keeply/features/storage/data/storage_api.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  StorageRepositoryImpl(this._api);
  final StorageApi _api;
  @override
  Future<List<StorageNode>> listSpaces() => _api.listSpaces();
  @override
  Future<StorageNode> createSpace(String name) => _api.createSpace(name);
  @override
  Future<StorageNode> updateSpace(String id, String name) =>
      _api.updateSpace(id, name);
  @override
  Future<void> deleteSpace(String id) => _api.deleteSpace(id);
  @override
  Future<StorageTreeNode> getSpaceTree(String id) => _api.getSpaceTree(id);
  @override
  Future<StorageNode> createContainer({
    required String name,
    required String parentId,
  }) => _api.createContainer(name: name, parentId: parentId);
  @override
  Future<StorageNode> updateContainer(String id, String name) =>
      _api.updateContainer(id, name);
  @override
  Future<void> deleteContainer(String id) => _api.deleteContainer(id);
  @override
  Future<StorageNode> moveContainer({
    required String id,
    required String parentId,
  }) => _api.moveContainer(id: id, parentId: parentId);
  @override
  Future<StorageTreeNode> getContainerTree(String id) =>
      _api.getContainerTree(id);
  @override
  Future<List<StorageNode>> listContainerItems(String id) =>
      _api.listContainerItems(id);
  @override
  Future<StorageNode> createItem({
    required String name,
    required String parentId,
  }) => _api.createItem(name: name, parentId: parentId);
  @override
  Future<StorageNode> getItem(String id) => _api.getItem(id);
  @override
  Future<StorageNode> updateItem(String id, String name) =>
      _api.updateItem(id, name);
  @override
  Future<void> deleteItem(String id) => _api.deleteItem(id);
  @override
  Future<StorageNode> moveItem({
    required String id,
    required String parentId,
  }) => _api.moveItem(id: id, parentId: parentId);
  @override
  Future<ItemPath> getItemPath(String id) => _api.getItemPath(id);
}
