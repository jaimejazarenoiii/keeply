import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';

abstract class StorageRepository {
  Future<List<StorageNode>> listSpaces();
  Future<StorageNode> createSpace(String name);
  Future<StorageNode> updateSpace(String id, String name);
  Future<void> deleteSpace(String id);
  Future<StorageTreeNode> getSpaceTree(String id);
  Future<StorageNode> createContainer({
    required String name,
    required String parentId,
  });
  Future<StorageNode> updateContainer(String id, String name);
  Future<void> deleteContainer(String id);
  Future<StorageNode> moveContainer({
    required String id,
    required String parentId,
  });
  Future<StorageTreeNode> getContainerTree(String id);
  Future<List<StorageNode>> listContainerItems(String id);
  Future<StorageNode> createItem({
    required String name,
    required String parentId,
  });
  Future<StorageNode> getItem(String id);
  Future<StorageNode> updateItem(String id, String name);
  Future<void> deleteItem(String id);
  Future<StorageNode> moveItem({required String id, required String parentId});
  Future<ItemPath> getItemPath(String id);
}
