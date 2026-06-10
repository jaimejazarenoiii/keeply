# Research: Unified Node Details Page

**Feature**: `003-unified-node-details`  
**Date**: 2026-06-05

## R-001: Spec vs Plan Input Reconciliation

**Decision**: Adopt the `/speckit.plan` input as the implementation layout. Keep the
spec's media, metadata, accessibility, and loading requirements; replace the
in-page tab model with preview sections plus a dedicated explorer page.

| Topic | Spec | Plan Input | Resolution |
| ----- | ---- | ---------- | ---------- |
| Child browsing | Segmented Containers/Items tabs | Preview sections (max 10) + explorer | Use preview + explorer |
| Statistics | Metadata chips only | Dashboard-style stat cards | Add `NodeStatisticsCards` section |
| Full child lists | Scroll within tab | `NodeExplorerPage` with pagination | Dedicated route |
| Page entrance | 250 ms fade | 400 ms fade + upward motion | Use 400 ms per plan input |
| Feature modules | Single storage presentation layer | `node_details`, `space`, `container`, `item` | Delegate modules over existing `storage` data layer |

**Rationale**: Plan input explicitly defines scalable module boundaries, explorer
pagination, and dashboard visual parity. Spec requirements for carousel,
fullscreen preview, skeletons, and empty states remain valid.

**Alternatives considered**:
- Keep tab model from spec — rejected because plan input defines explorer flow.
- Full feature split including repository duplication — rejected; keep `storage` as data boundary.

---

## R-002: Feature Module Boundaries

**Decision**: Introduce four presentation-focused feature modules backed by the
existing `storage` repository. Do not fork API or repository implementations.

```text
storage/          → data + domain (unchanged owner)
node_details/     → shared page, explorer, shared widgets, blocs
space/            → SpaceDetailsDelegate + space-specific actions
container/        → ContainerDetailsDelegate + container-specific actions
item/             → ItemDetailsDelegate + item-specific actions
```

**Rationale**: Isolates node-type behavior without duplicating network/data code.
Delegates are injectable and independently testable.

**Alternatives considered**:
- Everything in `storage/presentation` — rejected; future Item attachments/notes
  would pollute shared UI.
- Four fully independent features with own repositories — rejected; violates DRY
  and existing architecture.

---

## R-003: Data Loading Strategy

**Decision**: Phase 1 uses existing tree/item endpoints and derives direct
children client-side. Phase 2 adds paginated repository methods when backend
supports `limit`/`offset` or cursor params.

| Node Type | Existing API | Direct Children Derivation |
| --------- | ------------ | -------------------------- |
| Space | `getSpaceTree(id)` | `children.where(container)` and `children.where(item)` at depth 1 |
| Container | `getContainerTree(id)` | Same as space tree children |
| Item | `getItem(id)` | No children; stats from node metadata only |

**Rationale**: No backend pagination exists today (`/spaces/:id/tree` returns full
tree). Client-side pagination in explorer is sufficient for MVP.

**Alternatives considered**:
- Block feature on new API — rejected; delays UX redesign unnecessarily.
- Always load full tree for explorer — accepted for MVP with 20-item pages sliced
  in memory.

---

## R-004: State Management

**Decision**: Use `Cubit` for page-level state (`NodeDetailsCubit`,
`NodeExplorerCubit`) with `Equatable` view models and `BlocSelector` for
section-level rebuild isolation.

**Rationale**: Matches existing storage cubits (`SpaceTreeCubit`,
`ContainerDetailCubit`, `ItemDetailCubit`) and dashboard BLoC patterns. Cubits
are lighter for single-page async load/refresh/pagination.

**Alternatives considered**:
- Single `NodeDetailsBloc` with event union — viable but inconsistent with
  existing storage cubits.
- `Riverpod` — rejected; project standard is `flutter_bloc`.

---

## R-005: Scroll Architecture

**Decision**: One `CustomScrollView` with slivers for the details page. No nested
vertical `ListView` for previews; render up to 10 cards as `SliverList` children
or `SliverToBoxAdapter` column slices.

Explorer page uses `CustomScrollView` + `SliverList` + footer
`SliverToBoxAdapter` for pagination control.

**Rationale**: Prevents nested-scroll conflicts required by FR-012 and plan
performance rules.

**Alternatives considered**:
- `NestedScrollView` with inner tab scroll — rejected; plan removes tabs from
  details page.
- `ListView` inside `ListView` — rejected.

---

## R-006: Image Loading and Caching

**Decision**: Add `cached_network_image` for carousel, thumbnails, and explorer
rows. Placeholder fallback uses type-specific local assets (same pattern as
dashboard `space_placeholder.jpg`).

**Rationale**: Network images without caching cause jank and redundant downloads.
Constitution requires controlled image usage.

**Alternatives considered**:
- Raw `Image.network` — rejected for performance.
- Local-only images — rejected; `StorageNode.images` already has URLs.

---

## R-007: Animation Stack

**Decision**: Use `flutter_animate` (already in project) for staggered section
entrance, card delays, and skeleton cross-fades. Use `Hero` + dedicated fullscreen
route for image preview. Use `AnimatedSwitcher` with fade-through for explorer
filter results. FAB reuses `DashboardCreateFab` interaction pattern.

**Rationale**: Aligns with dashboard implementation and plan premium-motion goals
without custom animation controllers everywhere.

**Alternatives considered**:
- `animations` package only — viable but project already uses `flutter_animate`.
- Manual `AnimationController` per card — rejected; harder to maintain.

---

## R-008: Pagination Pattern

**Decision**: Explicit "Show More" button pagination (not infinite auto-scroll).

- Page size: 20 items
- Initial explorer load: first 20 filtered results
- Footer states: loading morph, "Show More", "Showing all N results"
- In-memory page cache per `(parentId, explorerType, searchQuery)` session

**Rationale**: Matches plan input and avoids accidental duplicate fetch loops.

**Alternatives considered**:
- Auto infinite scroll — rejected per plan.
- Server pagination only — deferred to Phase 2.

---

## R-009: Search Strategy

**Decision**: Phase 1 local filter on loaded child collection (name, description
preview, tags). Debounce 250 ms. Search bar expands on focus with 200 ms width
animation. Phase 2 swaps filter function for repository search when API exists.

**Rationale**: Explorer loads parent children into memory for MVP; local filter is
instant and testable.

**Alternatives considered**:
- Server search only — blocked on API.
- No search in MVP — rejected; explicit plan requirement.

---

## R-010: Migration from Legacy Detail Pages

**Decision**: Strangler migration — implement unified pages, route all three
legacy paths to `NodeDetailsPage`, deprecate old widgets in place, remove after
parity tests pass.

| Legacy Route | Unified Target |
| ------------ | -------------- |
| `/spaces/:id` | `NodeDetailsPage(nodeId, nodeType: space)` |
| `/containers/:id` | `NodeDetailsPage(nodeId, nodeType: container)` |
| `/items/:id` | `NodeDetailsPage(nodeId, nodeType: item)` |

**Rationale**: Zero broken deep links; dashboard and storage list navigation keep
working.

**Alternatives considered**:
- Big-bang delete — rejected; breaks tests and routes mid-sprint.

---

## R-011: Dependencies to Add

**Decision**:
- `cached_network_image` — image caching (required)
- `smooth_page_indicator` or custom worm indicator — carousel indicator (evaluate
  during implementation; custom preferred to minimize deps)

**Rationale**: Caching is non-negotiable for media-heavy UI. Indicator can be
custom-painted if package weight is a concern.

**Alternatives considered**:
- `photo_view` for fullscreen zoom — recommended for pinch-to-zoom; add during
  implementation tasks.
