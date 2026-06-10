# Implementation Plan: Unified Node Details Page

**Branch**: `003-unified-node-details` | **Date**: 2026-06-05 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/003-unified-node-details/spec.md` and
`/speckit.plan` architecture brief.

## Summary

Redesign Space, Container, and Item detail experiences into one premium,
dashboard-aligned `NodeDetailsPage` with isolated type-specific delegates, preview
sections for direct children (max 10), and a paginated `NodeExplorerPage` for
full lists. Reuse the existing `storage` data layer; add a `NodeDetailsRepository`
facade for derived view models and client-side pagination. Replace three legacy
detail pages via route migration while preserving deep links.

## Technical Context

**Language/Version**: Dart 3.12.1 with Flutter stable.

**Primary Dependencies**: `flutter_bloc`, `go_router`, `get_it`, `equatable`,
`flutter_animate`, existing `StorageRepository`, `cached_network_image` (new),
optional `photo_view` for fullscreen zoom.

**Storage**: Existing REST API via `StorageApi` / `StorageRepository`. Phase 1
derives children from tree endpoints; Phase 2 adds paginated API methods.

**Testing**: `flutter test` — cubit unit tests, widget tests per node type and
state, navigation tests, accessibility semantics tests, golden tests for skeleton
and cards. `flutter analyze` + `dart format`.

**Target Platform**: Flutter mobile first (Android/iOS), responsive tablet, web
secondary.

**Project Type**: Flutter app feature redesign with new presentation modules.

**Performance Goals**: 60 FPS scroll, initial skeleton < 300 ms, loaded content <
 2 s on typical mobile network, no nested scroll conflicts, `BlocSelector` section
isolation, cached images, explicit pagination (no runaway fetches).

**Constraints**: Follow Keeply constitution, design tokens, dashboard visual
parity, delegate-isolated type logic, lifecycle-safe async/animation callbacks.

**Scale/Scope**: 2 pages, 14+ shared widgets, 3 delegates, 2 cubits, 1 repository
facade, route migration, ~40 tests, deprecate 3 legacy pages + 3 legacy cubits.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
| --------- | ------ | ----- |
| Flutter Style | PASS | Widgets split by section; files < 200 lines target |
| Testable Design | PASS | Delegates + repository facade injectable; cubits unit-testable |
| Testing Standards | PASS | Unit + widget + navigation + a11y tests defined |
| UX Consistency | PASS | Design tokens + dashboard card patterns + empty/error/skeleton |
| Performance/Lifecycle | PASS | Sliver scroll, BlocSelector, emit guards, image cache, dispose |

**Post-design re-check**: PASS — no constitution exceptions required.

## Project Structure

### Documentation (this feature)

```text
specs/003-unified-node-details/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── ui-contract.md
│   ├── navigation-contract.md
│   └── state-contract.md
└── tasks.md                    # Phase 2 — /speckit-tasks
```

### Source Code (repository root)

```text
lib/features/
├── storage/                          # EXISTING — data/domain only (no new pages)
│   ├── data/
│   ├── domain/
│   └── presentation/                 # legacy pages deprecated after migration
│
├── node_details/                     # NEW — unified UI framework
│   ├── data/
│   │   └── node_details_repository_impl.dart
│   ├── domain/
│   │   ├── node_details_repository.dart
│   │   ├── entities/
│   │   │   ├── node_details_view_data.dart
│   │   │   ├── node_statistics.dart
│   │   │   ├── child_container_summary.dart
│   │   │   ├── child_item_summary.dart
│   │   │   └── node_explorer_page_data.dart
│   │   └── delegates/
│   │       └── node_details_delegate.dart
│   └── presentation/
│       ├── cubit/
│       │   ├── node_details_cubit.dart
│       │   └── node_explorer_cubit.dart
│       ├── pages/
│       │   ├── node_details_page.dart
│       │   ├── node_explorer_page.dart
│       │   └── fullscreen_image_preview.dart
│       └── widgets/
│           ├── node_hero_carousel.dart
│           ├── node_metadata_section.dart
│           ├── node_statistics_cards.dart
│           ├── node_container_preview.dart
│           ├── node_item_preview.dart
│           ├── container_child_card.dart
│           ├── item_child_card.dart
│           ├── node_explorer_search_bar.dart
│           ├── node_explorer_list.dart
│           ├── node_explorer_pagination_footer.dart
│           ├── expandable_keeply_fab.dart
│           ├── node_empty_state.dart
│           ├── node_details_error_view.dart
│           └── loading/
│               ├── node_details_skeleton.dart
│               ├── hero_carousel_skeleton.dart
│               ├── metadata_skeleton.dart
│               ├── container_card_skeleton.dart
│               └── item_card_skeleton.dart
│
├── space/                            # NEW — space-specific behavior
│   └── presentation/
│       └── space_details_delegate.dart
│
├── container/                        # NEW — container-specific behavior
│   └── presentation/
│       └── container_details_delegate.dart
│
└── item/                             # NEW — item-specific behavior
    └── presentation/
        └── item_details_delegate.dart

test/features/node_details/
├── cubit/
│   ├── node_details_cubit_test.dart
│   └── node_explorer_cubit_test.dart
├── pages/
│   ├── node_details_page_test.dart
│   ├── node_explorer_page_test.dart
│   └── node_details_navigation_test.dart
└── widgets/
    ├── node_hero_carousel_test.dart
    ├── node_metadata_section_test.dart
    ├── node_statistics_cards_test.dart
    ├── node_container_preview_test.dart
    ├── node_item_preview_test.dart
    └── node_empty_state_test.dart
```

**Structure Decision**: Presentation splits into `node_details` (shared UI) plus
thin `space` / `container` / `item` delegate modules. Data remains centralized in
`storage` with a new `node_details` facade — avoids repository duplication.

## 1. Feature Folder Structure

See Project Structure above. Four presentation boundaries, one shared data
source.

## 2. Bloc Responsibilities

### NodeDetailsCubit

- Owns page load, refresh, error recovery
- Calls `NodeDetailsRepository.getNodeDetails`
- Exposes `NodeDetailsState` for UI
- Does NOT contain type-specific action logic (delegates handle that)

### NodeExplorerCubit

- Owns explorer load, local search filter, explicit pagination
- Calls `NodeDetailsRepository.getExplorerChildren`
- Manages `NodeExplorerLoadingMore` for "Show More"
- Caches filtered results in memory per session

### Delegates (not Blocs)

- `SpaceDetailsDelegate` — create container/item, space metadata chips, move
- `ContainerDetailsDelegate` — nested container rules, create actions, move
- `ItemDetailsDelegate` — future attachment/note entry points, move, delete

## 3. Navigation Flow

```text
Dashboard / Storage List
        ↓ push
NodeDetailsPage(nodeId, nodeType)
        ├─ tap child card → push NodeDetailsPage(child)
        ├─ View All Containers → push NodeExplorerPage(containers)
        ├─ View All Items → push NodeExplorerPage(items)
        ├─ tap carousel image → FullscreenImagePreview
        └─ FAB → create container/item routes

NodeExplorerPage
        ├─ tap row → push NodeDetailsPage(child)
        ├─ Show More → loadMore (in place)
        └─ back → pop to NodeDetailsPage
```

Legacy routes redirect to unified paths (see `contracts/navigation-contract.md`).

## 4. Shared Component Inventory

| Component | Section | Reuse |
| --------- | ------- | ----- |
| `NodeHeroCarousel` | 1 | New |
| `NodeMetadataSection` | 2 | New |
| `NodeStatisticsCards` | 3 | Visual parity with `DashboardStatCard` |
| `NodeContainerPreview` | 4 | Pattern from `DashboardContainersSection` |
| `NodeItemPreview` | 5 | Pattern from `DashboardItemsSection` |
| `ContainerChildCard` | 4, Explorer | New |
| `ItemChildCard` | 5, Explorer | New |
| `NodeExplorerSearchBar` | Explorer | Extends search prompt patterns |
| `NodeExplorerList` | Explorer | Sliver-based |
| `NodeExplorerPaginationFooter` | Explorer | New |
| `NodeEmptyState` | All empty cases | Extends `DashboardEmptyState` patterns |
| `NodeLoadingSkeleton` | Loading | Extends `DashboardSkeleton` / shimmer |
| `ExpandableKeeplyFAB` | FAB | Adapts `DashboardCreateFab` |
| `FullscreenImagePreview` | Media | New overlay route |

## 5. Animation Implementation Plan

| Target | Implementation | Duration |
| ------ | -------------- | -------- |
| Page entrance | `flutter_animate` fade + translateY on scroll body | 400 ms |
| Hero carousel indicator | Custom worm / `SmoothPageIndicator` | continuous |
| Metadata stagger | `flutter_animate` list stagger | 40 ms/item |
| Statistics cards | Spring scale + fade, sequential | 40 ms stagger |
| Container cards | Fade + slide up, 40 ms stagger | per card |
| Item cards | Fade + scale, 40 ms stagger | per card |
| Explorer tab/filter | `AnimatedSwitcher` fade-through | 200 ms |
| FAB expand | Reuse dashboard spring + rotation | 220 ms |
| Pull-to-refresh | Custom `RefreshIndicator` + primary color | system |
| Skeleton cross-fade | `AnimatedSwitcher` 200 ms | on load complete |
| Image Hero | `Hero` tag per `NodeImage.id` | 250 ms |

Use `mounted` / `isClosed` guards on all animation status callbacks.

## 6. Pagination Strategy

**MVP (Phase 1)**:
1. Repository fetches full direct-child list from tree API
2. Explorer cubit stores `allResults` in memory
3. Initial display: first 20 (`visibleResults`)
4. "Show More": append next 20
5. Footer: "Showing all N results" when complete

**Phase 2**:
- Add `GET /nodes/:id/children?type=&limit=&cursor=` API
- Repository switches to server pagination; cubit interface unchanged

## 7. Search Strategy

**Phase 1 — Local**:
- Filter `allResults` by name (all types), description + tags (items)
- Debounce 250 ms in `NodeExplorerCubit`
- Reset pagination to first page on query change
- Empty: "No results found" + clear search

**Phase 2 — Remote**:
- Repository search param; local filter becomes fallback

## 8. Loading State Strategy

| Page | Loading | Refreshing | Error |
| ---- | ------- | ---------- | ----- |
| Details | `NodeDetailsSkeleton` full page | Keep content + refresh indicator | `NodeDetailsErrorView` |
| Explorer | List skeleton + search skeleton | N/A | Inline `ErrorBanner` |

Partial load: header can render while previews skeleton (if split fetch added later).

Skeleton dimensions match `contracts/ui-contract.md` exactly.

## 9. Empty State Strategy

| Context | Title | CTA |
| ------- | ----- | --- |
| Containers preview (space/container) | No containers yet | Add Container |
| Items preview (space/container) | No items yet | Add Item |
| Containers preview (item node) | No containers yet | None — explanatory copy |
| Items preview (item node) | No items yet | None — explanatory copy |
| Explorer search | No results found | Clear search |
| Explorer no children | Same as preview | Contextual create |

## 10. Performance Optimization Checklist

- [ ] Single `CustomScrollView` on details page — no nested vertical lists
- [ ] `BlocSelector` per section (carousel, stats, previews)
- [ ] `Equatable` view models with granular `props`
- [ ] `cached_network_image` with fixed width/height cache keys
- [ ] Preview limited to 10 items — no unbounded lists on details page
- [ ] Explorer pagination explicit — no auto infinite scroll
- [ ] Tree fetch deduplicated per nodeId per session
- [ ] Cancel stale loads via generation counter + `isClosed` guard
- [ ] Fullscreen preview in separate route — no rebuild on pinch
- [ ] Reuse dashboard shimmer primitives
- [ ] `const` constructors where possible
- [ ] Dispose search debounce timer on explorer dispose

## 11. Flutter Implementation Roadmap

### Sprint 1 — Foundation (P1)

1. Create `node_details` domain entities + repository facade
2. Implement `NodeDetailsCubit` with fake repository tests
3. Create three delegates (space, container, item)
4. Build `NodeDetailsPage` scroll shell + skeleton
5. Wire routes with legacy redirects

### Sprint 2 — Core UI (P1)

6. `NodeHeroCarousel` + placeholder + skeleton
7. `NodeMetadataSection` + chips
8. `NodeStatisticsCards`
9. `NodeContainerPreview` + `NodeItemPreview` (max 10)
10. `ExpandableKeeplyFAB` wired to delegates

### Sprint 3 — Explorer + Media (P2)

11. `NodeExplorerCubit` + pagination
12. `NodeExplorerPage` with search + footer
13. `FullscreenImagePreview` with pinch-to-zoom
14. Pull-to-refresh on details page

### Sprint 4 — Polish + Migration (P2/P3)

15. Animations (entrance, stagger, fade-through)
16. Accessibility pass
17. Responsive tablet constraints
18. Replace dashboard/storage navigation targets
19. Delete legacy detail pages + cubits
20. Full test suite + manual QA

## 12. Migration Strategy

### Phase A — Parallel Implementation

- Build unified pages alongside legacy pages
- Feature flag optional: `useUnifiedNodeDetails` in router (default false)

### Phase B — Route Cutover

- Enable redirects: `/spaces/:id` → unified page
- Update dashboard `context.push` targets (already push-based)
- Update storage list navigation

### Phase C — Cleanup

- Remove `SpaceDetailPage`, `ContainerDetailPage`, `ItemDetailPage`
- Remove `SpaceTreeCubit`, `ContainerDetailCubit`, `ItemDetailCubit` from DI
- Remove `ItemBreadcrumbCubit` usage from item details (metadata/breadcrumb
  replaced by unified header; path navigation via parent links if needed)
- Update tests referencing legacy pages

### Rollback Plan

- Revert router redirects to legacy pages
- Unified modules remain behind flag

## Complexity Tracking

| Decision | Why Needed | Simpler Alternative Rejected |
| -------- | ---------- | ---------------------------- |
| 4 feature modules | Isolate type-specific growth (attachments, notes) | Single storage presentation folder would accrete conditionals |
| Repository facade | Derived view models decouple UI from tree shape | Widgets parsing `StorageTreeNode` directly — untestable, duplicated |
| Explorer page | Full lists + search + pagination don't fit details page | In-page tabs — conflicts with preview sections per plan input |
| Client pagination MVP | No paginated API yet | Blocking on backend — delays redesign |

## Phase 0 Output

See [research.md](./research.md) — all technical decisions resolved.

## Phase 1 Output

- [data-model.md](./data-model.md)
- [contracts/ui-contract.md](./contracts/ui-contract.md)
- [contracts/navigation-contract.md](./contracts/navigation-contract.md)
- [contracts/state-contract.md](./contracts/state-contract.md)
- [quickstart.md](./quickstart.md)
