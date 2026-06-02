import 'package:bloc/bloc.dart';
import 'package:keeply/features/storage/domain/entities/move_destination_rules.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';

class MoveDestinationCubit extends Cubit<ResourceState<List<StorageTreeNode>>> {
  MoveDestinationCubit(this._repository) : super(const ResourceState());
  final StorageRepository _repository;
  NodeType? _type;
  String? _id;
  Future<void> load({
    required NodeType movingType,
    required String movingId,
  }) async {
    _type = movingType;
    _id = movingId;
    emit(state.copyWith(status: ResourceStatus.loading));
    try {
      final spaces = await _repository.listSpaces();
      final trees = <StorageTreeNode>[];
      for (final space in spaces) {
        trees.add(await _repository.getSpaceTree(space.id));
      }
      final disabled = const MoveDestinationRules().disabledIds(
        movingType: movingType,
        movingId: movingId,
        roots: trees,
      );
      emit(
        ResourceState(
          status: trees.isEmpty ? ResourceStatus.empty : ResourceStatus.loaded,
          data: trees,
          disabledIds: disabled,
        ),
      );
    } on Object catch (error) {
      emit(
        ResourceState(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }

  Future<void> moveTo(String parentId) async {
    final type = _type;
    final id = _id;
    if (type == null || id == null || state.disabledIds.contains(parentId))
      return;
    emit(state.copyWith(status: ResourceStatus.submitting));
    try {
      if (type == NodeType.container) {
        await _repository.moveContainer(id: id, parentId: parentId);
      } else {
        await _repository.moveItem(id: id, parentId: parentId);
      }
      emit(state.copyWith(status: ResourceStatus.success));
    } on Object catch (error) {
      emit(
        state.copyWith(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }
}
