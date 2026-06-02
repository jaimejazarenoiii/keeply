import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class DeleteNodeState extends Equatable {
  const DeleteNodeState({
    this.isDeleting = false,
    this.deleted = false,
    this.errorMessage,
  });
  final bool isDeleting;
  final bool deleted;
  final String? errorMessage;
  @override
  List<Object?> get props => [isDeleting, deleted, errorMessage];
}

class DeleteNodeCubit extends Cubit<DeleteNodeState> {
  DeleteNodeCubit(this._repository) : super(const DeleteNodeState());
  final StorageRepository _repository;
  Future<void> delete(StorageNode node) async {
    emit(const DeleteNodeState(isDeleting: true));
    try {
      switch (node.type) {
        case NodeType.space:
          await _repository.deleteSpace(node.id);
        case NodeType.container:
          await _repository.deleteContainer(node.id);
        case NodeType.item:
          await _repository.deleteItem(node.id);
      }
      emit(const DeleteNodeState(deleted: true));
    } on Object {
      emit(
        const DeleteNodeState(
          errorMessage: 'Move or delete the contents first.',
        ),
      );
    }
  }
}
