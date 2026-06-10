import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/node_details/domain/node_details_repository.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

sealed class NodeExplorerState extends Equatable {
  const NodeExplorerState();
  @override
  List<Object?> get props => [];
}

class NodeExplorerLoading extends NodeExplorerState {
  const NodeExplorerLoading();
}

class NodeExplorerLoaded extends NodeExplorerState {
  const NodeExplorerLoaded(this.data);
  final NodeExplorerPageData data;
  @override
  List<Object?> get props => [data];
}

class NodeExplorerLoadingMore extends NodeExplorerState {
  const NodeExplorerLoadingMore(this.data);
  final NodeExplorerPageData data;
  @override
  List<Object?> get props => [data];
}

class NodeExplorerError extends NodeExplorerState {
  const NodeExplorerError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class NodeExplorerCubit extends Cubit<NodeExplorerState> {
  NodeExplorerCubit(this._repository) : super(const NodeExplorerLoading());

  final NodeDetailsRepository _repository;
  Timer? _searchDebounce;
  List<ExplorerRowData> _allResults = const [];
  String _parentNodeId = '';
  NodeType _parentNodeType = NodeType.space;
  NodeExplorerType _explorerType = NodeExplorerType.containers;
  String _searchQuery = '';
  var _requestGeneration = 0;

  static const pageSize = 20;

  Future<void> load({
    required String parentNodeId,
    required NodeType parentNodeType,
    required NodeExplorerType explorerType,
    String initialQuery = '',
  }) async {
    _parentNodeId = parentNodeId;
    _parentNodeType = parentNodeType;
    _explorerType = explorerType;
    _searchQuery = initialQuery;
    final generation = ++_requestGeneration;
    emit(const NodeExplorerLoading());

    try {
      _allResults = await _repository.getExplorerChildren(
        parentNodeId: parentNodeId,
        parentNodeType: parentNodeType,
        explorerType: explorerType,
      );
      if (isClosed || generation != _requestGeneration) return;
      _emitFiltered(generation);
    } on Object {
      if (isClosed || generation != _requestGeneration) return;
      emit(
        const NodeExplorerError('Unable to load results. Please try again.'),
      );
    }
  }

  void search(String query) {
    _searchQuery = query;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 250), () {
      if (isClosed) return;
      _emitFiltered(_requestGeneration);
    });
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! NodeExplorerLoaded || !current.data.hasMore) return;

    emit(NodeExplorerLoadingMore(current.data));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (isClosed) return;

    final filtered = _filteredResults();
    final nextCount = (current.data.loadedCount + pageSize).clamp(
      0,
      filtered.length,
    );
    emit(
      NodeExplorerLoaded(
        _buildPageData(filtered.take(nextCount).toList(), filtered),
      ),
    );
  }

  void retry() {
    load(
      parentNodeId: _parentNodeId,
      parentNodeType: _parentNodeType,
      explorerType: _explorerType,
      initialQuery: _searchQuery,
    );
  }

  void _emitFiltered(int generation) {
    if (isClosed || generation != _requestGeneration) return;
    final filtered = _filteredResults();
    emit(
      NodeExplorerLoaded(
        _buildPageData(filtered.take(pageSize).toList(), filtered),
      ),
    );
  }

  List<ExplorerRowData> _filteredResults() {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return _allResults;

    return [
      for (final row in _allResults)
        if (_matches(row, query)) row,
    ];
  }

  bool _matches(ExplorerRowData row, String query) {
    return switch (row) {
      ExplorerContainerRow(:final data) => data.name.toLowerCase().contains(
        query,
      ),
      ExplorerItemRow(:final data) =>
        data.name.toLowerCase().contains(query) ||
            (data.descriptionPreview?.toLowerCase().contains(query) ?? false) ||
            data.tags.any((tag) => tag.toLowerCase().contains(query)),
    };
  }

  NodeExplorerPageData _buildPageData(
    List<ExplorerRowData> visible,
    List<ExplorerRowData> all,
  ) {
    return NodeExplorerPageData(
      parentNodeId: _parentNodeId,
      parentNodeType: _parentNodeType,
      explorerType: _explorerType,
      searchQuery: _searchQuery,
      allResults: all,
      visibleResults: visible,
      pageSize: pageSize,
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
