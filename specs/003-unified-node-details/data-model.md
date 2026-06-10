# Data Model: Unified Node Details Page

## Scope

Defines UI-facing view models and state shapes for `NodeDetailsPage` and
`NodeExplorerPage`. Extends existing `StorageNode`, `StorageTreeNode`, and
`NodeImage` entities from `lib/features/storage/domain/`. No duplicate domain
entities.

## Domain Entities (Existing)

### StorageNode

- `id`, `type`, `name`, `parentId`, `spaceId`
- `images: List<NodeImage>`
- `metadata: Map<String, dynamic>` — description, tags
- `createdAt`, `updatedAt`

### NodeImage

- `id`, `url`, `altText`, `sortOrder`, `createdAt`

## View Models

### NodeDetailsViewData

Primary loaded payload for details page.

| Field | Type | Notes |
| ----- | ---- | ----- |
| `node` | `StorageNode` | Current node |
| `statistics` | `NodeStatistics` | Derived counts |
| `previewContainers` | `List<ChildContainerSummary>` | Max 10 direct containers |
| `previewItems` | `List<ChildItemSummary>` | Max 10 direct items |
| `totalDirectContainers` | `int` | Full count for "View All" visibility |
| `totalDirectItems` | `int` | Full count for "View All" visibility |
| `hasMoreContainers` | `bool` | `totalDirectContainers > 10` |
| `hasMoreItems` | `bool` | `totalDirectItems > 10` |

### NodeStatistics

| Field | Type | Source |
| ----- | ---- | ------ |
| `containerCount` | `int` | Direct child containers |
| `itemCount` | `int` | Direct child items |
| `photoCount` | `int` | `node.images.length` |
| `tagCount` | `int` | `metadata.tags.length` |

### ChildContainerSummary

| Field | Type | Notes |
| ----- | ---- | ----- |
| `id` | `String` | Container id |
| `name` | `String` | Display name |
| `itemCount` | `int` | Direct items inside container |
| `thumbnailUrl` | `String?` | First image URL if any |

### ChildItemSummary

| Field | Type | Notes |
| ----- | ---- | ----- |
| `id` | `String` | Item id |
| `name` | `String` | Display name |
| `descriptionPreview` | `String?` | Truncated metadata description |
| `tags` | `List<String>` | From metadata |
| `thumbnailUrl` | `String?` | First image URL |
| `updatedAt` | `DateTime?` | Last updated |

### NodeExplorerPageData

| Field | Type | Notes |
| ----- | ---- | ----- |
| `parentNodeId` | `String` | Parent node |
| `parentNodeType` | `NodeType` | Space or Container |
| `explorerType` | `NodeExplorerType` | `containers` or `items` |
| `searchQuery` | `String` | Current filter |
| `allResults` | `List<ExplorerRowData>` | Full filtered set in memory (MVP) |
| `visibleResults` | `List<ExplorerRowData>` | Currently displayed page slice |
| `pageSize` | `int` | Default 20 |
| `loadedCount` | `int` | `visibleResults.length` |
| `totalCount` | `int` | `allResults.length` |
| `hasMore` | `bool` | `loadedCount < totalCount` |

### ExplorerRowData

Union-like row for explorer list rendering.

- Container row: `ChildContainerSummary`
- Item row: `ChildItemSummary`

## State Machines

### NodeDetailsState

```text
NodeDetailsInitial
  → NodeDetailsLoading
  → NodeDetailsLoaded(NodeDetailsViewData)
  → NodeDetailsRefreshing(NodeDetailsViewData)  // pull-to-refresh
  → NodeDetailsError(message, previous?)
```

Transitions:
- `load()` / `refresh()` from any state except loading without cancel
- `refresh()` keeps `NodeDetailsViewData` visible
- Guard `emit` with `isClosed` / generation counter on async completion

### NodeExplorerState

```text
NodeExplorerInitial
  → NodeExplorerLoading
  → NodeExplorerLoaded(NodeExplorerPageData)
  → NodeExplorerLoadingMore(NodeExplorerPageData)
  → NodeExplorerError(message)
```

Transitions:
- `load()` fetches children and resets pagination
- `search(query)` filters `allResults`, resets to first page
- `loadMore()` appends next 20 to `visibleResults`
- `loadMore()` blocked while `NodeExplorerLoadingMore`

## Metadata Conventions

| Key | Type | Usage |
| --- | ---- | ----- |
| `description` | `String` | Node information section |
| `tags` | `List<String>` | Metadata chips + item cards |

If absent, UI hides the corresponding element.

## Repository Extensions (Phase 1 — Client Derived)

### NodeDetailsRepository (facade over StorageRepository)

| Method | Returns |
| ------ | ------- |
| `getNodeDetails(nodeId, nodeType)` | `NodeDetailsViewData` |
| `getExplorerChildren(parentId, parentType, explorerType)` | `List<ExplorerRowData>` |

Implementation derives direct children from tree responses or `getItem` for
item nodes (empty children).

### NodeDetailsRepository (Phase 2 — Server Pagination)

| Method | Returns |
| ------ | ------- |
| `getExplorerPage(parentId, type, explorerType, {cursor, limit, query})` | Paginated slice + next cursor |

## Delegate Contracts

### NodeDetailsDelegate (abstract)

| Responsibility | Methods |
| -------------- | ------- |
| App bar actions | `List<Widget> buildActions(context)` |
| FAB | `Widget? buildFab(context)` or null for Item |
| Empty state CTAs | `NodeEmptyStateAction? containerAction, itemAction` |
| Permissions | `bool canCreateContainer, canCreateItem, canMove, canDelete` |
| Metadata extras | `List<Widget> buildExtraChips(context, node)` |

### SpaceDetailsDelegate / ContainerDetailsDelegate / ItemDetailsDelegate

Concrete implementations in `space`, `container`, `item` modules.

## Validation Rules

- Preview lists MUST contain only direct children (depth = 1).
- Preview lists MUST NOT exceed 10 entries; overflow routes to explorer.
- Explorer page size MUST be 20 per "Show More" action.
- Image carousel MUST sort by `NodeImage.sortOrder` ascending.
- Search filter MUST be case-insensitive on name; include description/tags for items.

## Performance Notes

- `NodeDetailsViewData` and explorer results MUST be `Equatable` for `BlocSelector`.
- Thumbnail URLs MUST use cached image widget with fixed dimensions.
- Tree fetch MUST NOT rebuild entire page when only FAB overlay changes — use
  `BlocSelector` per section.
