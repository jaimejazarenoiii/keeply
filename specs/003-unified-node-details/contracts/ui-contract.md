# UI Contract: Unified Node Details

Design sources (required together):
- `.specify/design-token.json`
- `.specify/assets/design-system-v1.jpeg`

Align visually with dashboard: primary `#22C55E`, secondary `#0F172A`,
`primaryLight` backgrounds, card radius 20, soft elevation.

## NodeDetailsPage

**Inputs**: `nodeId`, `nodeType`  
**State source**: `NodeDetailsCubit`  
**Layout**: Single `CustomScrollView` (no nested vertical scroll)

### Section 1 — NodeHeroCarousel

| Property | Value |
| -------- | ----- |
| Height | 40% viewport width, clamp 220–360 dp |
| Radius | `radius.lg` (24) bottom corners optional |
| Multi-image | Horizontal `PageView`, worm indicator |
| Tap | Opens `FullscreenImagePreview` with Hero |
| Empty | Type placeholder illustration + icon |
| Parallax | Subtle on scroll (optional phase 2) |
| Skeleton | Full-width shimmer rectangle matching height |

Semantics: "Image X of Y" or "No photos added, [type]"

### Section 2 — NodeMetadataSection

| Element | Style |
| ------- | ----- |
| Title | `h2`, `textPrimary`, max 2 lines |
| Type badge | Pill, type label text + icon |
| Description | `bodyLarge`, hidden if empty |
| Chips | Created, Updated, Child count, Tags |

Animation: staggered fade + slide up, 40 ms between elements, 400 ms total window.

Skeleton: title bar 70%, badge pill, 2 description lines, 3 chip pills.

### Section 3 — NodeStatisticsCards

Dashboard-style row of four equal cards:

| Card | Value |
| ---- | ----- |
| Containers | `statistics.containerCount` |
| Items | `statistics.itemCount` |
| Photos | `statistics.photoCount` |
| Tags | `statistics.tagCount` |

Reuse `DashboardStatCard` visual language (tap scale 0.98, spring entrance).

Skeleton: four `StatCardSkeleton` equivalents.

### Section 4 — NodeContainerPreview

| Property | Value |
| -------- | ----- |
| Header | "Containers" + count badge |
| List | Max 10 `ContainerChildCard` |
| Overflow CTA | "View All Containers" if `hasMoreContainers` |
| Empty | `NodeEmptyState` — "No containers yet" + CTA |
| Card content | Icon, name, item count, thumbnail?, chevron |

Animation: stagger 40 ms, fade + slide.

### Section 5 — NodeItemPreview

| Property | Value |
| -------- | ----- |
| Header | "Items" + count badge |
| List | Max 10 `ItemChildCard` |
| Overflow CTA | "View All Items" if `hasMoreItems` |
| Empty | `NodeEmptyState` — "No items yet" + CTA |
| Card content | Thumbnail, name, description preview, tags, updated |

Animation: stagger 40 ms, fade + scale.

### App Bar

- Back: system back / `context.pop()`
- Title: optional collapsed title on scroll (phase 2)
- Actions: from delegate (move, edit, delete as applicable)

### FAB — ExpandableKeeplyFAB

| Node Type | Options |
| --------- | ------- |
| Space | Create Container, Create Item |
| Container | Create Container, Create Item |
| Item | None (future: Add Attachment, Add Note) |

Reuse dashboard expandable FAB pattern: spring expansion, rotating icon, dark overlay.

### Pull-to-Refresh

Custom branded indicator using primary green; content stays visible; triggers
`NodeDetailsCubit.refresh()`.

### Fatal Error

Full-page `NodeDetailsErrorView` with retry.

---

## NodeExplorerPage

**Inputs**: `parentNodeId`, `parentNodeType`, `explorerType`  
**State source**: `NodeExplorerCubit`

### NodeExplorerSearchBar

- Persistent at top of scroll content
- Expands smoothly on focus (200 ms)
- Debounced local filter 250 ms
- Placeholder: "Search containers" or "Search items"

### NodeExplorerList

- `SliverList` of container or item cards (same card contracts as preview)
- No nested scroll

### NodeExplorerPaginationFooter

| State | UI |
| ----- | -- |
| `hasMore` | "Show More" button |
| `loadingMore` | Button morphs to loading indicator |
| `allLoaded` | "Showing all N containers/items" |

### Explorer Empty States

| Case | Copy |
| ---- | ---- |
| No children | Same as preview empty states |
| Search no match | "No results found" + clear search CTA |

---

## Shared Components

| Widget | Purpose |
| ------ | ------- |
| `NodeHeroCarousel` | Media header |
| `NodeMetadataSection` | Title, badge, description, chips |
| `NodeStatisticsCards` | Four-up stat row |
| `NodeContainerPreview` | Section 4 wrapper |
| `NodeItemPreview` | Section 5 wrapper |
| `ContainerChildCard` | Container row card |
| `ItemChildCard` | Item row card |
| `NodeExplorerSearchBar` | Explorer search |
| `NodeExplorerList` | Explorer sliver list |
| `NodeExplorerPaginationFooter` | Show More footer |
| `NodeEmptyState` | Illustration + message + CTA |
| `NodeLoadingSkeleton` | Full page skeleton |
| `ExpandableKeeplyFAB` | Contextual create menu |
| `FullscreenImagePreview` | Zoom + swipe overlay |

---

## Responsive Rules

| Breakpoint | Behavior |
| ---------- | -------- |
| < 360 dp | 24 dp padding, carousel clamp min |
| 360–599 dp | Default phone layout |
| ≥ 600 dp | Max width 720 dp centered, 32 dp padding |

---

## Accessibility Contract

- Minimum touch target 48 dp
- WCAG AA contrast on text and badges
- Screen reader labels on all cards and FAB options
- Search field exposes result count after filter
- Fullscreen preview close button labeled "Close image preview"
