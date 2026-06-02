import 'package:bloc/bloc.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';

class SpacesCubit extends Cubit<ResourceState<List<StorageNode>>> {
  SpacesCubit(this._repository) : super(const ResourceState());
  final StorageRepository _repository;
  Future<void> load() async {
    emit(state.copyWith(status: ResourceStatus.loading));
    try {
      final spaces = await _repository.listSpaces();
      emit(
        ResourceState(
          status: spaces.isEmpty ? ResourceStatus.empty : ResourceStatus.loaded,
          data: spaces,
        ),
      );
    } on Object catch (error) {
      emit(
        ResourceState(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }

  Future<void> create(String name) async {
    emit(state.copyWith(status: ResourceStatus.submitting));
    try {
      await _repository.createSpace(name);
      await load();
    } on Object catch (error) {
      emit(
        state.copyWith(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }
}
