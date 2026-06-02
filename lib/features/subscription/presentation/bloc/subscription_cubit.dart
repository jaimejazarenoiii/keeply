import 'package:bloc/bloc.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';
import 'package:keeply/features/subscription/domain/subscription_repository.dart';

class SubscriptionCubit extends Cubit<ResourceState<SubscriptionStatus>> {
  SubscriptionCubit(this._repository) : super(const ResourceState());
  final SubscriptionRepository _repository;
  Future<void> load() async {
    emit(state.copyWith(status: ResourceStatus.loading));
    try {
      emit(
        ResourceState(
          status: ResourceStatus.loaded,
          data: await _repository.status(),
        ),
      );
    } on Object catch (error) {
      emit(
        ResourceState(status: ResourceStatus.error, message: error.toString()),
      );
    }
  }
}
