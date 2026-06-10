import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/node_details/domain/entities/node_details_view_data.dart';
import 'package:keeply/features/node_details/domain/node_details_repository.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

sealed class NodeDetailsState extends Equatable {
  const NodeDetailsState();
  @override
  List<Object?> get props => [];
}

class NodeDetailsLoading extends NodeDetailsState {
  const NodeDetailsLoading();
}

class NodeDetailsLoaded extends NodeDetailsState {
  const NodeDetailsLoaded({
    required this.data,
    this.isRefreshing = false,
  });

  final NodeDetailsViewData data;
  final bool isRefreshing;

  @override
  List<Object?> get props => [data, isRefreshing];
}

class NodeDetailsError extends NodeDetailsState {
  const NodeDetailsError({
    required this.message,
    this.previous,
  });

  final String message;
  final NodeDetailsViewData? previous;

  @override
  List<Object?> get props => [message, previous];
}

class NodeDetailsCubit extends Cubit<NodeDetailsState> {
  NodeDetailsCubit(this._repository) : super(const NodeDetailsLoading());

  final NodeDetailsRepository _repository;
  var _requestGeneration = 0;
  String? _nodeId;
  NodeType? _nodeType;

  Future<void> load({
    required String nodeId,
    required NodeType nodeType,
  }) async {
    _nodeId = nodeId;
    _nodeType = nodeType;
    final generation = ++_requestGeneration;
    emit(const NodeDetailsLoading());

    try {
      final data = await _repository.getNodeDetails(
        nodeId: nodeId,
        nodeType: nodeType,
      );
      if (isClosed || generation != _requestGeneration) return;
      emit(NodeDetailsLoaded(data: data));
    } on Object {
      if (isClosed || generation != _requestGeneration) return;
      final previous = state is NodeDetailsLoaded
          ? (state as NodeDetailsLoaded).data
          : state is NodeDetailsError
          ? (state as NodeDetailsError).previous
          : null;
      emit(
        NodeDetailsError(
          message: 'Unable to load node details. Please try again.',
          previous: previous,
        ),
      );
    }
  }

  Future<void> refresh() async {
    final nodeId = _nodeId;
    final nodeType = _nodeType;
    if (nodeId == null || nodeType == null) return;

    final previous = state is NodeDetailsLoaded
        ? (state as NodeDetailsLoaded).data
        : null;
    if (previous != null) {
      emit(NodeDetailsLoaded(data: previous, isRefreshing: true));
    }

    final generation = ++_requestGeneration;
    try {
      final data = await _repository.getNodeDetails(
        nodeId: nodeId,
        nodeType: nodeType,
      );
      if (isClosed || generation != _requestGeneration) return;
      emit(NodeDetailsLoaded(data: data));
    } on Object {
      if (isClosed || generation != _requestGeneration) return;
      emit(
        NodeDetailsError(
          message: 'Unable to refresh node details. Please try again.',
          previous: previous,
        ),
      );
    }
  }

  void retry() {
    final nodeId = _nodeId;
    final nodeType = _nodeType;
    if (nodeId == null || nodeType == null) return;
    load(nodeId: nodeId, nodeType: nodeType);
  }
}
