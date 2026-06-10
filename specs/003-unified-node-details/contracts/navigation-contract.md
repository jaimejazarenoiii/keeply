# Navigation Contract: Unified Node Details

## Routes

### Unified Details (replaces legacy detail pages)

| Path | Page | Params |
| ---- | ---- | ------ |
| `/nodes/:nodeType/:nodeId` | `NodeDetailsPage` | `nodeType`: space \| container \| item |
| `/spaces/:spaceId` | redirect → `/nodes/space/:spaceId` | backward compatible |
| `/containers/:containerId` | redirect → `/nodes/container/:containerId` | backward compatible |
| `/items/:itemId` | redirect → `/nodes/item/:itemId` | backward compatible |

### Explorer

| Path | Page | Params |
| ---- | ---- | ------ |
| `/nodes/:nodeType/:nodeId/explorer/:explorerType` | `NodeExplorerPage` | `explorerType`: containers \| items |

Query (optional):
- `q` — initial search query

### Fullscreen Media

| Path | Page | Notes |
| ---- | ---- | ----- |
| `/nodes/:nodeType/:nodeId/media` | `FullscreenImagePreview` | Optional named route; may use overlay instead |

### Create Flows (existing, unchanged)

| Action | Route |
| ------ | ----- |
| Create Container | `/containers/new/:parentId` |
| Create Item | `/items/new/:parentId` |
| Create Space | `/spaces/new` |
| Move Container | `/move/container/:id` |
| Move Item | `/move/item/:id` |

## Navigation Patterns

- Use `context.push()` for drill-down (details → child details, details → explorer).
- Use `context.pop()` for back from explorer to details.
- Dashboard and storage list taps route to unified details paths.
- "View All Containers/Items" pushes explorer route with correct `explorerType`.

## Deep Link Examples

```text
/nodes/space/abc123
/nodes/container/def456
/nodes/item/ghi789
/nodes/space/abc123/explorer/containers
/nodes/container/def456/explorer/items?q=cable
```

## Migration Mapping

| Source | Target |
| ------ | ------ |
| `SpaceDetailPage` | `NodeDetailsPage` + `SpaceDetailsDelegate` |
| `ContainerDetailPage` | `NodeDetailsPage` + `ContainerDetailsDelegate` |
| `ItemDetailPage` | `NodeDetailsPage` + `ItemDetailsDelegate` |

Legacy pages remain until parity tests pass, then deleted.
