# State Contract: Unified Node Details

## NodeDetailsCubit

### Events / Methods

| Method | Behavior |
| ------ | -------- |
| `load(nodeId, nodeType)` | Fetch and emit loaded or error |
| `refresh()` | Keep loaded data visible, set refreshing, reload |
| `retry()` | Alias to `load` after error |

### States

```dart
sealed class NodeDetailsState extends Equatable

class NodeDetailsLoading extends NodeDetailsState
class NodeDetailsLoaded extends NodeDetailsState {
  final NodeDetailsViewData data
  final bool isRefreshing
}
class NodeDetailsError extends NodeDetailsState {
  final String message
  final NodeDetailsViewData? previous
}
```

### BlocSelector Targets

| Selector | Rebuild scope |
| -------- | ------------- |
| `state.data.node.images` | Carousel only |
| `state.data.statistics` | Statistics cards |
| `state.data.previewContainers` | Container preview |
| `state.data.previewItems` | Item preview |
| `state.isRefreshing` | Refresh indicator only |

### Lifecycle

- Register cubit as `registerFactory` in service locator.
- Cancel in-flight load via generation counter on new `load` or dispose.
- Guard `emit` with `isClosed` after async gaps.

---

## NodeExplorerCubit

### Methods

| Method | Behavior |
| ------ | -------- |
| `load(parentId, parentType, explorerType)` | Fetch all direct children |
| `search(query)` | Filter in memory, reset to page 1 |
| `loadMore()` | Append next 20 to visible list |
| `retry()` | Reload from scratch |

### States

```dart
sealed class NodeExplorerState extends Equatable

class NodeExplorerLoading extends NodeExplorerState
class NodeExplorerLoaded extends NodeExplorerState {
  final NodeExplorerPageData data
}
class NodeExplorerLoadingMore extends NodeExplorerState {
  final NodeExplorerPageData data
}
class NodeExplorerError extends NodeExplorerState {
  final String message
}
```

### Pagination Rules

- `pageSize = 20`
- `loadMore()` no-op if `!hasMore` or state is `NodeExplorerLoadingMore`
- Footer copy:
  - More available: show "Show More"
  - Loading: spinner replaces button
  - Complete: "Showing all {n} containers" or "Showing all {n} items"

---

## Delegate Injection

`NodeDetailsPage` resolves delegate at build time:

```dart
NodeDetailsDelegate delegateFor(NodeType type) => switch (type) {
  NodeType.space => sl<SpaceDetailsDelegate>(),
  NodeType.container => sl<ContainerDetailsDelegate>(),
  NodeType.item => sl<ItemDetailsDelegate>(),
};
```

Delegates are stateless services registered in service locator.

---

## ResourceState Compatibility

Explorer and details cubits do NOT reuse `ResourceState<T>` from storage
cubits. New sealed states provide clearer section semantics and pagination.

Legacy cubits (`SpaceTreeCubit`, `ContainerDetailCubit`, `ItemDetailCubit`)
deprecated after migration.
