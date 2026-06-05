import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';
import 'package:keeply/features/storage/domain/entities/storage_tree_node.dart';
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
            subtitle:
                '${space.containerCount} containers ? ${space.itemCount} items',
          ),
      for (final container in latestContainers)
        if (container.name.toLowerCase().contains(normalized) ||
            container.spaceName.toLowerCase().contains(normalized))
          DashboardSearchResult(
            id: container.id,
            type: NodeType.container,
            title: container.name,
            subtitle: container.spaceName,
          ),
      for (final item in latestItems)
        if (item.name.toLowerCase().contains(normalized) ||
            item.containerName.toLowerCase().contains(normalized) ||
            item.spaceName.toLowerCase().contains(normalized))
          DashboardSearchResult(
            id: item.id,
            type: NodeType.item,
            title: item.name,
            subtitle: item.containerName.isEmpty
                ? item.spaceName
                : '${item.containerName} ? ${item.spaceName}',
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

  Future<void> _onRequested(
    DashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    final previous = state is DashboardLoaded
        ? (state as DashboardLoaded).summary
        : null;
    if (event.keepCurrentContent && previous != null) {
      emit(
        DashboardLoaded(
          summary: previous,
          query: state.query,
          isRefreshing: true,
        ),
      );
    } else {
      emit(DashboardLoading(query: state.query));
    }

    try {
      final summary = await _loadSummary();
      if (!emit.isDone) {
        emit(DashboardLoaded(summary: summary, query: state.query));
      }
    } on Object {
      if (!emit.isDone) {
        emit(
          DashboardError(
            message: 'Unable to load dashboard. Please try again.',
            query: state.query,
            previous: previous,
          ),
        );
      }
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
    final spaces = await _repository.listSpaces();
    final trees = <StorageTreeNode>[];
    for (final space in spaces) {
      try {
        trees.add(await _repository.getSpaceTree(space.id));
      } on Object {
        // Keep dashboard usable if one tree fails.
      }
    }

    final containers = <DashboardContainer>[];
    final items = <DashboardItem>[];
    var totalContainers = 0;
    var totalItems = 0;

    void visit(
      StorageTreeNode node,
      String spaceId,
      String spaceName, [
      String containerId = '',
      String containerName = '',
    ]) {
      switch (node.type) {
        case NodeType.space:
          for (final child in node.children) {
            visit(child, node.id, node.name);
          }
        case NodeType.container:
          totalContainers++;
          final directItems = node.children
              .where((child) => child.type == NodeType.item)
              .length;
          containers.add(
            DashboardContainer(
              id: node.id,
              name: node.name,
              spaceId: spaceId,
              spaceName: spaceName,
              itemCount: directItems,
            ),
          );
          for (final child in node.children) {
            visit(child, spaceId, spaceName, node.id, node.name);
          }
        case NodeType.item:
          totalItems++;
          items.add(
            DashboardItem(
              id: node.id,
              name: node.name,
              containerId: containerId,
              containerName: containerName,
              spaceId: spaceId,
              spaceName: spaceName,
            ),
          );
      }
    }

    for (final tree in trees) {
      visit(tree, tree.id, tree.name);
    }

    return DashboardSummary(
      totalSpaces: spaces.length,
      totalContainers: totalContainers,
      totalItems: totalItems,
      latestSpaces: [
        for (final tree in trees.take(5))
          DashboardSpace(
            id: tree.id,
            name: tree.name,
            containerCount: _countType(tree, NodeType.container),
            itemCount: _countType(tree, NodeType.item),
          ),
      ],
      latestContainers: containers.take(5).toList(),
      latestItems: items.take(10).toList(),
    );
  }

  int _countType(StorageTreeNode node, NodeType type) {
    var count = node.type == type ? 1 : 0;
    for (final child in node.children) {
      count += _countType(child, type);
    }
    return count;
  }
}
