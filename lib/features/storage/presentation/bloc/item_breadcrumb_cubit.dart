import 'package:bloc/bloc.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';

class ItemBreadcrumbCubit extends Cubit<ResourceState<ItemPath>> {
  ItemBreadcrumbCubit(this._repository) : super(const ResourceState());
  final StorageRepository _repository;
  Future<void> load(String itemId) async {
    emit(state.copyWith(status: ResourceStatus.loading));
    try {
      emit(
        ResourceState(
          status: ResourceStatus.loaded,
          data: await _repository.getItemPath(itemId),
        ),
      );
    } on Object catch (error) {
      emit(
        ResourceState(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }
}
