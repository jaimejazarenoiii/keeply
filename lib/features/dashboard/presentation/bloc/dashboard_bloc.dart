import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/dashboard/data/dashboard_summary_mapper.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';

class DashboardSummary extends Equatable {
  const DashboardSummary({
    required this.totalSpaces,
    required this.totalContainers,
    required this.totalItems,
    required this.latestSpaces,
    required this.latestContainers,
    required this.latestItems,
  });

  final int totalSpaces;
  final int totalContainers;
  final int totalItems;
  final List<DashboardSpace> latestSpaces;
  final List<DashboardContainer> latestContainers;
  final List<DashboardItem> latestItems;

  String _spaceSearchSubtitle(DashboardSpace space) {
    if (space.containerCount == 0 && space.itemCount == 0) return '';
    return '${space.containerCount} containers · ${space.itemCount} items';
  }

  String _containerSearchSubtitle(DashboardContainer container) {
    final parts = <String>[
      if (container.spaceName.isNotEmpty) container.spaceName,
      if (container.itemCount > 0) '${container.itemCount} items',
    ];
    return parts.join(' · ');
  }

  String _itemSearchSubtitle(DashboardItem item) {
    if (item.containerName.isEmpty && item.spaceName.isEmpty) return '';
    if (item.containerName.isEmpty) return item.spaceName;
    if (item.spaceName.isEmpty) return item.containerName;
    return '${item.containerName} · ${item.spaceName}';
  }

  List<DashboardSearchResult> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const [];
    return [
      for (final space in latestSpaces)
        if (space.name.toLowerCase().contains(normalized))
          DashboardSearchResult(
            id: space.id,
            type: NodeType.space,
            title: space.name,
            subtitle: _spaceSearchSubtitle(space),
          ),
      for (final container in latestContainers)
        if (container.name.toLowerCase().contains(normalized) ||
            container.spaceName.toLowerCase().contains(normalized))
          DashboardSearchResult(
            id: container.id,
            type: NodeType.container,
            title: container.name,
            subtitle: _containerSearchSubtitle(container),
          ),
      for (final item in latestItems)
        if (item.name.toLowerCase().contains(normalized) ||
            item.containerName.toLowerCase().contains(normalized) ||
            item.spaceName.toLowerCase().contains(normalized))
          DashboardSearchResult(
            id: item.id,
            type: NodeType.item,
            title: item.name,
            subtitle: _itemSearchSubtitle(item),
          ),
    ];
  }

  @override
  List<Object?> get props => [
    totalSpaces,
    totalContainers,
    totalItems,
    latestSpaces,
    latestContainers,
    latestItems,
  ];
}

class DashboardSpace extends Equatable {
  const DashboardSpace({
    required this.id,
    required this.name,
    required this.containerCount,
    required this.itemCount,
  });

  final String id;
  final String name;
  final int containerCount;
  final int itemCount;

  @override
  List<Object?> get props => [id, name, containerCount, itemCount];
}

class DashboardContainer extends Equatable {
  const DashboardContainer({
    required this.id,
    required this.name,
    required this.spaceId,
    required this.spaceName,
    required this.itemCount,
  });

  final String id;
  final String name;
  final String spaceId;
  final String spaceName;
  final int itemCount;

  @override
  List<Object?> get props => [id, name, spaceId, spaceName, itemCount];
}

class DashboardItem extends Equatable {
  const DashboardItem({
    required this.id,
    required this.name,
    required this.containerId,
    required this.containerName,
    required this.spaceId,
    required this.spaceName,
  });

  final String id;
  final String name;
  final String containerId;
  final String containerName;
  final String spaceId;
  final String spaceName;

  @override
  List<Object?> get props => [
    id,
    name,
    containerId,
    containerName,
    spaceId,
    spaceName,
  ];
}

class DashboardSearchResult extends Equatable {
  const DashboardSearchResult({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final NodeType type;
  final String title;
  final String subtitle;

  @override
  List<Object?> get props => [id, type, title, subtitle];
}

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object?> get props => [];
}

class DashboardRequested extends DashboardEvent {
  const DashboardRequested({this.keepCurrentContent = false});
  final bool keepCurrentContent;
  @override
  List<Object?> get props => [keepCurrentContent];
}

class DashboardSearchChanged extends DashboardEvent {
  const DashboardSearchChanged(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

sealed class DashboardState extends Equatable {
  const DashboardState({this.query = ''});
  final String query;
  @override
  List<Object?> get props => [query];
}

class DashboardLoading extends DashboardState {
  const DashboardLoading({super.query});
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded({
    required this.summary,
    super.query,
    this.isRefreshing = false,
  });

  final DashboardSummary summary;
  final bool isRefreshing;
  List<DashboardSearchResult> get searchResults => summary.search(query);

  @override
  List<Object?> get props => [summary, query, isRefreshing];
}

class DashboardError extends DashboardState {
  const DashboardError({required this.message, super.query, this.previous});
  final String message;
  final DashboardSummary? previous;
  @override
  List<Object?> get props => [message, query, previous];
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._repository) : super(const DashboardLoading()) {
    on<DashboardRequested>(_onRequested);
    on<DashboardSearchChanged>(_onSearchChanged);
  }

  final StorageRepository _repository;
  var _requestGeneration = 0;

  Future<void> _onRequested(
    DashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    final generation = ++_requestGeneration;
    final query = state.query;
    final previous = state is DashboardLoaded
        ? (state as DashboardLoaded).summary
        : null;
    if (event.keepCurrentContent && previous != null) {
      emit(
        DashboardLoaded(
          summary: previous,
          query: query,
          isRefreshing: true,
        ),
      );
    } else {
      emit(DashboardLoading(query: query));
    }

    try {
      final summary = await _loadSummary();
      if (isClosed || generation != _requestGeneration || emit.isDone) return;
      emit(DashboardLoaded(summary: summary, query: query));
    } on Object {
      if (isClosed || generation != _requestGeneration || emit.isDone) return;
      emit(
        DashboardError(
          message: 'Unable to load dashboard. Please try again.',
          query: query,
          previous: previous,
        ),
      );
    }
  }

  void _onSearchChanged(
    DashboardSearchChanged event,
    Emitter<DashboardState> emit,
  ) {
    final current = state;
    if (current is DashboardLoaded) {
      emit(
        DashboardLoaded(
          summary: current.summary,
          query: event.query,
          isRefreshing: current.isRefreshing,
        ),
      );
    } else if (current is DashboardLoading) {
      emit(DashboardLoading(query: event.query));
    } else if (current is DashboardError) {
      emit(
        DashboardError(
          message: current.message,
          previous: current.previous,
          query: event.query,
        ),
      );
    }
  }

  Future<DashboardSummary> _loadSummary() async {
    final apiSummary = await _repository.getDashboardSummary();
    return mapDashboardApiSummary(apiSummary);
  }
}
