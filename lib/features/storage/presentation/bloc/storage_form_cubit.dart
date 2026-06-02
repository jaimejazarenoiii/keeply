import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class StorageFormState extends Equatable {
  const StorageFormState({
    this.name = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.saved,
  });
  final String name;
  final bool isSubmitting;
  final String? errorMessage;
  final StorageNode? saved;
  bool get canSubmit => name.trim().isNotEmpty && !isSubmitting;
  StorageFormState copyWith({
    String? name,
    bool? isSubmitting,
    String? errorMessage,
    StorageNode? saved,
  }) => StorageFormState(
    name: name ?? this.name,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: errorMessage,
    saved: saved ?? this.saved,
  );
  @override
  List<Object?> get props => [name, isSubmitting, errorMessage, saved];
}

class StorageFormCubit extends Cubit<StorageFormState> {
  StorageFormCubit(this._repository) : super(const StorageFormState());
  final StorageRepository _repository;
  void nameChanged(String value) => emit(state.copyWith(name: value));
  Future<void> createSpace() async =>
      _save(() => _repository.createSpace(state.name));
  Future<void> createContainer(String parentId) async => _save(
    () => _repository.createContainer(name: state.name, parentId: parentId),
  );
  Future<void> createItem(String parentId) async =>
      _save(() => _repository.createItem(name: state.name, parentId: parentId));
  Future<void> _save(Future<StorageNode> Function() action) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    try {
      emit(state.copyWith(isSubmitting: false, saved: await action()));
    } on Object catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: error.toString()));
    }
  }
}
