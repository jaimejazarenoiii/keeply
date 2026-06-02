import 'package:bloc/bloc.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';

class ItemDetailCubit extends Cubit<ResourceState<StorageNode>> {
  ItemDetailCubit(this._repository) : super(const ResourceState());
  final StorageRepository _repository;
  Future<void> load(String id) async {
    emit(state.copyWith(status: ResourceStatus.loading));
    try {
      emit(
        ResourceState(
          status: ResourceStatus.loaded,
          data: await _repository.getItem(id),
        ),
      );
    } on Object catch (error) {
      emit(
        ResourceState(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }
}
