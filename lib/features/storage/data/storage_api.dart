import 'package:keeply/core/network/api_client.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';

class StorageApi {
  StorageApi(this._client);
  final ApiClient _client;
  Future<List<StorageNode>> listSpaces() => _client.get(
    '/spaces',
    parser: (json) => (json! as List)
        .whereType<Map<String, dynamic>>()
        .map(StorageNode.fromJson)
        .toList(),
  );
  Future<StorageNode> createSpace(String name) => _client.post(
    '/spaces',
    data: {'name': name},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageNode> updateSpace(String id, String name) => _client.patch(
    '/spaces/$id',
    data: {'name': name},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<void> deleteSpace(String id) => _client.delete('/spaces/$id');
  Future<StorageTreeNode> getSpaceTree(String id) => _client.get(
    '/spaces/$id/tree',
    parser: (json) => StorageTreeNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageNode> createContainer({
    required String name,
    required String parentId,
  }) => _client.post(
    '/containers',
    data: {'name': name, 'parentId': parentId},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageNode> updateContainer(String id, String name) => _client.patch(
    '/containers/$id',
    data: {'name': name},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<void> deleteContainer(String id) => _client.delete('/containers/$id');
  Future<StorageNode> moveContainer({
    required String id,
    required String parentId,
  }) => _client.patch(
    '/containers/$id/move',
    data: {'parentId': parentId},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageTreeNode> getContainerTree(String id) => _client.get(
    '/containers/$id/tree',
    parser: (json) => StorageTreeNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<List<StorageNode>> listContainerItems(String id) => _client.get(
    '/containers/$id/items',
    parser: (json) => (json! as List)
        .whereType<Map<String, dynamic>>()
        .map(StorageNode.fromJson)
        .toList(),
  );
  Future<StorageNode> createItem({
    required String name,
    required String parentId,
  }) => _client.post(
    '/items',
    data: {'name': name, 'parentId': parentId},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageNode> getItem(String id) => _client.get(
    '/items/$id',
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<StorageNode> updateItem(String id, String name) => _client.patch(
    '/items/$id',
    data: {'name': name},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<void> deleteItem(String id) => _client.delete('/items/$id');
  Future<StorageNode> moveItem({
    required String id,
    required String parentId,
  }) => _client.patch(
    '/items/$id/move',
    data: {'parentId': parentId},
    parser: (json) => StorageNode.fromJson(json! as Map<String, dynamic>),
  );
  Future<ItemPath> getItemPath(String id) => _client.get(
    '/items/$id/path',
    parser: (json) => ItemPath.fromJson(json! as Map<String, dynamic>),
  );
}
