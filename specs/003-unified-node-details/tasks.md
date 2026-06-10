# Tasks: Unified Node Details Page

**Input**: Design documents from `/specs/003-unified-node-details/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Test tasks are REQUIRED. Unit tests for cubits/repository; widget tests
for sections, cards, skeletons, and pages; navigation and accessibility tests for
cross-screen flows.

**Organization**: Tasks grouped by user story for independent implementation and
testing. Plan layout uses preview sections + explorer (not in-page tabs).

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (US1–US5)
- Include exact file paths in descriptions

## Path Conventions

- **Flutter app**: `lib/`, `test/`
- **Unified UI**: `lib/features/node_details/`
- **Delegates**: `lib/features/space/`, `lib/features/container/`, `lib/features/item/`
- **Data layer**: existing `lib/features/storage/` + new `node_details` facade
- **Tests**: `test/features/node_details/`
- **Design sources**: `.specify/design-token.json`, `.specify/assets/design-system-v1.jpeg`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Dependencies and folder scaffolding for all node-details work.

- [x] T001 Add `cached_network_image` and `photo_view` dependencies in `pubspec.yaml`
- [x] T002 Create `lib/features/node_details/` root with `data/`, `domain/`, `presentation/` subfolders
- [x] T003 [P] Create `lib/features/space/presentation/` folder for `SpaceDetailsDelegate`
- [x] T004 [P] Create `lib/features/container/presentation/` folder for `ContainerDetailsDelegate`
- [x] T005 [P] Create `lib/features/item/presentation/` folder for `ItemDetailsDelegate`
- [x] T006 [P] Create `test/features/node_details/cubit/` test folder
- [x] T007 [P] Create `test/features/node_details/pages/` test folder
- [x] T008 [P] Create `test/features/node_details/widgets/` test folder
- [x] T009 [P] Create `lib/features/node_details/presentation/widgets/loading/` folder

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Domain models, repository facade, shared primitives, DI, and routes.

**CRITICAL**: No user story work can begin until this phase is complete.

- [x] T010 [P] Create `NodeDetailsDelegate` abstract contract in `lib/features/node_details/domain/delegates/node_details_delegate.dart`
- [x] T011 [P] Create `NodeStatistics` entity in `lib/features/node_details/domain/entities/node_statistics.dart`
- [x] T012 [P] Create `ChildContainerSummary` entity in `lib/features/node_details/domain/entities/child_container_summary.dart`
- [x] T013 [P] Create `ChildItemSummary` entity in `lib/features/node_details/domain/entities/child_item_summary.dart`
- [x] T014 [P] Create `NodeDetailsViewData` entity in `lib/features/node_details/domain/entities/node_details_view_data.dart`
- [x] T015 [P] Create `NodeExplorerPageData` and `NodeExplorerType` in `lib/features/node_details/domain/entities/node_explorer_page_data.dart`
- [x] T016 Create `NodeDetailsRepository` interface in `lib/features/node_details/domain/node_details_repository.dart`
- [x] T017 Implement direct-child derivation and view-model mapping in `lib/features/node_details/data/node_details_repository_impl.dart`
- [x] T018 [P] Create `NodeEmptyState` widget in `lib/features/node_details/presentation/widgets/node_empty_state.dart`
- [x] T019 [P] Create `NodeDetailsErrorView` widget in `lib/features/node_details/presentation/widgets/node_details_error_view.dart`
- [x] T020 [P] Create `HeroCarouselSkeleton` in `lib/features/node_details/presentation/widgets/loading/hero_carousel_skeleton.dart`
- [x] T021 [P] Create `MetadataSkeleton` in `lib/features/node_details/presentation/widgets/loading/metadata_skeleton.dart`
- [x] T022 [P] Create `ContainerCardSkeleton` in `lib/features/node_details/presentation/widgets/loading/container_card_skeleton.dart`
- [x] T023 [P] Create `ItemCardSkeleton` in `lib/features/node_details/presentation/widgets/loading/item_card_skeleton.dart`
- [x] T024 [P] Create `NodeDetailsSkeleton` wrapper in `lib/features/node_details/presentation/widgets/loading/node_details_skeleton.dart`
- [x] T025 Add node type path parsing helpers in `lib/features/node_details/domain/node_route_params.dart`
- [x] T026 Register repository, cubits, and delegates in `lib/core/di/service_locator.dart`
- [x] T027 Add `/nodes/:nodeType/:nodeId` and explorer child routes in `lib/core/routing/app_router.dart`
- [x] T028 [P] Unit test repository mapping and direct-child filter in `test/features/node_details/data/node_details_repository_impl_test.dart`

**Checkpoint**: Foundation ready — unified page and explorer can be built.

---

## Phase 3: User Story 1 - Unified Details Experience (Priority: P1) MVP

**Goal**: One consistent details page for Space, Container, and Item with hero
carousel, metadata, and statistics sections.

**Independent Test**: Open each node type and verify identical top-to-bottom
structure (carousel → metadata → statistics) with correct type badge and placeholder
when no images.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T029 [P] [US1] Unit test `NodeDetailsCubit` load/refresh/error in `test/features/node_details/cubit/node_details_cubit_test.dart`
- [x] T030 [P] [US1] Widget test `NodeHeroCarousel` images and placeholder in `test/features/node_details/widgets/node_hero_carousel_test.dart`
- [x] T031 [P] [US1] Widget test `NodeMetadataSection` title, badge, chips in `test/features/node_details/widgets/node_metadata_section_test.dart`
- [x] T032 [P] [US1] Widget test `NodeStatisticsCards` four-up layout in `test/features/node_details/widgets/node_statistics_cards_test.dart`
- [x] T033 [P] [US1] Page test loading and loaded states in `test/features/node_details/pages/node_details_page_test.dart`

### Implementation for User Story 1

- [x] T034 [US1] Implement `NodeDetailsCubit` and sealed states in `lib/features/node_details/presentation/cubit/node_details_cubit.dart`
- [x] T035 [P] [US1] Implement `SpaceDetailsDelegate` in `lib/features/space/presentation/space_details_delegate.dart`
- [x] T036 [P] [US1] Implement `ContainerDetailsDelegate` in `lib/features/container/presentation/container_details_delegate.dart`
- [x] T037 [P] [US1] Implement `ItemDetailsDelegate` in `lib/features/item/presentation/item_details_delegate.dart`
- [x] T038 [P] [US1] Implement `NodeHeroCarousel` with `PageView`, worm indicator, and cached images in `lib/features/node_details/presentation/widgets/node_hero_carousel.dart`
- [x] T039 [P] [US1] Implement `NodeMetadataSection` with title, badge, description, chips in `lib/features/node_details/presentation/widgets/node_metadata_section.dart`
- [x] T040 [P] [US1] Implement `NodeStatisticsCards` dashboard-style row in `lib/features/node_details/presentation/widgets/node_statistics_cards.dart`
- [x] T041 [US1] Implement `NodeDetailsPage` `CustomScrollView` shell in `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T042 [US1] Wire delegate resolution, app bar actions, and `BlocSelector` section rebuilds in `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T043 [US1] Add 400 ms page entrance fade + upward motion in `lib/features/node_details/presentation/pages/node_details_page.dart`

**Checkpoint**: User Story 1 independently testable for all three node types.

---

## Phase 4: User Story 2 - Browse Direct Children (Priority: P1)

**Goal**: Preview up to 10 direct containers/items on details page; full lists
via explorer with search and explicit pagination.

**Independent Test**: Open Space/Container with children; verify previews show only
direct children; tap "View All" opens explorer; tap child opens unified details.

### Tests for User Story 2

- [x] T044 [P] [US2] Widget test `ContainerChildCard` in `test/features/node_details/widgets/container_child_card_test.dart`
- [x] T045 [P] [US2] Widget test `ItemChildCard` in `test/features/node_details/widgets/item_child_card_test.dart`
- [x] T046 [P] [US2] Widget test `NodeContainerPreview` max-10 and View All in `test/features/node_details/widgets/node_container_preview_test.dart`
- [x] T047 [P] [US2] Widget test `NodeItemPreview` max-10 and View All in `test/features/node_details/widgets/node_item_preview_test.dart`
- [x] T048 [P] [US2] Unit test `NodeExplorerCubit` search and pagination in `test/features/node_details/cubit/node_explorer_cubit_test.dart`
- [x] T049 [P] [US2] Page test explorer load, Show More, and footer copy in `test/features/node_details/pages/node_explorer_page_test.dart`
- [x] T050 [P] [US2] Navigation test child card and explorer flows in `test/features/node_details/pages/node_details_navigation_test.dart`

### Implementation for User Story 2

- [x] T051 [P] [US2] Implement `ContainerChildCard` in `lib/features/node_details/presentation/widgets/container_child_card.dart`
- [x] T052 [P] [US2] Implement `ItemChildCard` in `lib/features/node_details/presentation/widgets/item_child_card.dart`
- [x] T053 [US2] Implement `NodeContainerPreview` section with header and View All in `lib/features/node_details/presentation/widgets/node_container_preview.dart`
- [x] T054 [US2] Implement `NodeItemPreview` section with header and View All in `lib/features/node_details/presentation/widgets/node_item_preview.dart`
- [x] T055 [US2] Implement `ExpandableKeeplyFAB` adapted from dashboard FAB in `lib/features/node_details/presentation/widgets/expandable_keeply_fab.dart`
- [x] T056 [US2] Integrate preview sections and FAB into `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T057 [US2] Implement `NodeExplorerCubit` with 20-item pagination in `lib/features/node_details/presentation/cubit/node_explorer_cubit.dart`
- [x] T058 [P] [US2] Implement `NodeExplorerSearchBar` with focus expand animation in `lib/features/node_details/presentation/widgets/node_explorer_search_bar.dart`
- [x] T059 [P] [US2] Implement `NodeExplorerList` sliver list in `lib/features/node_details/presentation/widgets/node_explorer_list.dart`
- [x] T060 [P] [US2] Implement `NodeExplorerPaginationFooter` Show More / Showing all N in `lib/features/node_details/presentation/widgets/node_explorer_pagination_footer.dart`
- [x] T061 [US2] Implement `NodeExplorerPage` in `lib/features/node_details/presentation/pages/node_explorer_page.dart`
- [x] T062 [US2] Wire View All navigation from previews to explorer route in `lib/features/node_details/presentation/widgets/node_container_preview.dart` and `node_item_preview.dart`

**Checkpoint**: User Stories 1 and 2 complete — details + child browsing work end-to-end.

---

## Phase 5: User Story 3 - Fullscreen Media Preview (Priority: P2)

**Goal**: Tap carousel image → fullscreen preview with pinch-zoom and swipe between images.

**Independent Test**: Node with multiple images; tap, zoom, swipe, dismiss; scroll
position preserved on details page.

### Tests for User Story 3

- [x] T063 [P] [US3] Widget test fullscreen open, zoom, dismiss in `test/features/node_details/pages/fullscreen_image_preview_test.dart`

### Implementation for User Story 3

- [x] T064 [US3] Implement `FullscreenImagePreview` with `photo_view` in `lib/features/node_details/presentation/pages/fullscreen_image_preview.dart`
- [x] T065 [US3] Add `Hero` shared transition from carousel tap in `lib/features/node_details/presentation/widgets/node_hero_carousel.dart`
- [x] T066 [US3] Wire fullscreen route or overlay in `lib/core/routing/app_router.dart`

**Checkpoint**: Media preview independently testable.

---

## Phase 6: User Story 4 - Loading, Empty, and Error States (Priority: P2)

**Goal**: Skeleton loaders, contextual empty states, pull-to-refresh, and retryable errors.

**Independent Test**: Simulate loading, empty previews, failed load, and refresh
for each node type without layout shift.

### Tests for User Story 4

- [x] T067 [P] [US4] Widget test `NodeEmptyState` copy and CTA in `test/features/node_details/widgets/node_empty_state_test.dart`
- [x] T068 [P] [US4] Widget test skeleton dimensions match loaded layout in `test/features/node_details/widgets/node_details_skeleton_test.dart`
- [x] T069 [P] [US4] Page test error retry and refresh content retention in `test/features/node_details/pages/node_details_page_test.dart`

### Implementation for User Story 4

- [x] T070 [US4] Integrate full-page skeleton and skeleton-to-content cross-fade in `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T071 [US4] Wire preview empty states and delegate CTAs in `lib/features/node_details/presentation/widgets/node_container_preview.dart` and `node_item_preview.dart`
- [x] T072 [US4] Add pull-to-refresh with visible content retention in `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T073 [US4] Add fatal error view and retry in `lib/features/node_details/presentation/pages/node_details_page.dart`
- [x] T074 [US4] Add explorer empty and "No results found" states in `lib/features/node_details/presentation/pages/node_explorer_page.dart`
- [x] T075 [US4] Add generation counter and `isClosed` emit guards in `lib/features/node_details/presentation/cubit/node_details_cubit.dart` and `node_explorer_cubit.dart`

**Checkpoint**: All UX states covered across details and explorer.

---

## Phase 7: User Story 5 - Responsive and Accessible (Priority: P3)

**Goal**: Phone and tablet layouts; screen reader and touch-target compliance.

**Independent Test**: Render at 320 dp and 720 dp widths; run semantics tests for
carousel, cards, FAB, search, and pagination footer.

### Tests for User Story 5

- [x] T076 [P] [US5] Responsive layout test at phone and tablet widths in `test/features/node_details/pages/node_details_responsive_test.dart`
- [x] T077 [P] [US5] Accessibility semantics test in `test/features/node_details/pages/node_details_accessibility_test.dart`

### Implementation for User Story 5

- [x] T078 [P] [US5] Create `NodeDetailsResponsiveContainer` max-width 720 dp in `lib/features/node_details/presentation/widgets/node_details_responsive_container.dart`
- [x] T079 [US5] Apply responsive padding and carousel clamp to `lib/features/node_details/presentation/pages/node_details_page.dart` and `node_explorer_page.dart`
- [x] T080 [US5] Add semantic labels to carousel, previews, FAB, and explorer search across `lib/features/node_details/presentation/widgets/`
- [x] T081 [US5] Verify minimum 48 dp touch targets on all node_details interactive widgets

**Checkpoint**: Responsive and accessible on supported breakpoints.

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Animations, route migration, legacy cleanup, and validation.

- [x] T082 [P] Add metadata and statistics stagger animations in `lib/features/node_details/presentation/widgets/node_metadata_section.dart` and `node_statistics_cards.dart`
- [x] T083 [P] Add 40 ms staggered fade+slide/scale on preview cards in `lib/features/node_details/presentation/widgets/node_container_preview.dart` and `node_item_preview.dart`
- [x] T084 [P] Add explorer `AnimatedSwitcher` fade-through on search filter in `lib/features/node_details/presentation/pages/node_explorer_page.dart`
- [x] T085 Update dashboard child navigation to unified routes in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T086 Update spaces list navigation to unified routes in `lib/features/storage/presentation/pages/spaces_list_page.dart`
- [x] T087 Add legacy redirects `/spaces/:id`, `/containers/:id`, `/items/:id` in `lib/core/routing/app_router.dart`
- [x] T088 Remove `lib/features/storage/presentation/pages/space_detail_page.dart`
- [x] T089 Remove `lib/features/storage/presentation/pages/container_detail_page.dart`
- [x] T090 Remove `lib/features/storage/presentation/pages/item_detail_page.dart`
- [x] T091 Remove legacy cubit registrations (`SpaceTreeCubit`, `ContainerDetailCubit`, `ItemDetailCubit`, `ItemBreadcrumbCubit`) from `lib/core/di/service_locator.dart`
- [x] T092 [P] Delete or update legacy storage detail tests under `test/features/storage/`
- [x] T093 Run `dart format .`, `flutter analyze`, and `flutter test test/features/node_details`
- [x] T094 Validate manual scenarios in `specs/003-unified-node-details/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **Foundational (Phase 2)**: Depends on Setup — **blocks all user stories**
- **US1 (Phase 3)**: Depends on Foundational — MVP
- **US2 (Phase 4)**: Depends on US1 page shell (T041)
- **US3 (Phase 5)**: Depends on US1 carousel (T038) — can parallel with US2 after US1
- **US4 (Phase 6)**: Depends on US1 + US2 widgets — can overlap late US2
- **US5 (Phase 7)**: Depends on US1–US4 complete layouts
- **Polish (Phase 8)**: Depends on US1–US5

### User Story Dependencies

| Story | Depends On | Independent Test |
| ----- | ---------- | ---------------- |
| US1 | Phase 2 | Open space/container/item → same layout |
| US2 | US1 shell | Previews + explorer + child navigation |
| US3 | US1 carousel | Fullscreen zoom + Hero |
| US4 | US1, US2 | Skeleton, empty, error, refresh |
| US5 | US1–US4 | Responsive + a11y |

### Parallel Opportunities

- **Phase 1**: T003–T009 all parallel after T002
- **Phase 2**: T010–T015, T018–T024, T028 parallel within phase
- **US1 tests**: T029–T033 parallel; delegates T035–T037 parallel
- **US2 cards**: T051–T052 parallel; explorer widgets T058–T060 parallel
- **US3–US5 tests**: marked [P] can run in parallel
- **Polish**: T082–T084, T092 parallel

---

## Parallel Example: User Story 1

```bash
# Tests first (parallel):
T029  test/features/node_details/cubit/node_details_cubit_test.dart
T030  test/features/node_details/widgets/node_hero_carousel_test.dart
T031  test/features/node_details/widgets/node_metadata_section_test.dart
T032  test/features/node_details/widgets/node_statistics_cards_test.dart
T033  test/features/node_details/pages/node_details_page_test.dart

# Implementation (parallel where marked):
T035  lib/features/space/presentation/space_details_delegate.dart
T036  lib/features/container/presentation/container_details_delegate.dart
T037  lib/features/item/presentation/item_details_delegate.dart
T038  lib/features/node_details/presentation/widgets/node_hero_carousel.dart
T039  lib/features/node_details/presentation/widgets/node_metadata_section.dart
T040  lib/features/node_details/presentation/widgets/node_statistics_cards.dart
```

---

## Parallel Example: User Story 2

```bash
T051  lib/features/node_details/presentation/widgets/container_child_card.dart
T052  lib/features/node_details/presentation/widgets/item_child_card.dart
T058  lib/features/node_details/presentation/widgets/node_explorer_search_bar.dart
T059  lib/features/node_details/presentation/widgets/node_explorer_list.dart
T060  lib/features/node_details/presentation/widgets/node_explorer_pagination_footer.dart
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: All three node types render unified details shell
5. Demo carousel, metadata, and statistics

### Incremental Delivery

1. Setup + Foundational → foundation ready
2. US1 → unified details shell (MVP)
3. US2 → child previews + explorer
4. US3 → fullscreen media
5. US4 → production-grade states
6. US5 → responsive + a11y
7. Polish → migration + legacy removal

### Suggested MVP Scope

**Phases 1–3 only** (T001–T043): Unified `NodeDetailsPage` with carousel,
metadata, and statistics for Space, Container, and Item.

---

## Notes

- Reuse `DashboardShimmer`, `DashboardStatCard`, and `DashboardCreateFab` patterns
- No nested vertical `ListView` on details page — `CustomScrollView` + slivers only
- Explorer uses explicit "Show More" — no auto infinite scroll
- Guard all async cubit emits and FAB animation callbacks on dispose
- Commit after each phase checkpoint
