# Tasks: Authenticated User Dashboard

**Input**: Design documents from `/specs/002-authenticated-dashboard/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Test tasks are REQUIRED for each feature. This feature uses widget
tests focused on dashboard presentation, animation states, responsiveness,
semantics, and navigation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Flutter app**: `lib/`, `test/`, `integration_test/`
- **Dashboard UI**: `lib/features/dashboard/presentation/`
- **Dashboard tests**: `test/features/dashboard/presentation/`
- **Design sources**: `.specify/design-token.json`, `.specify/assets/design-system-v1.jpeg`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Add only the dependency and folders needed for dashboard UI work.

- [x] T001 Add `flutter_animate` dependency in `pubspec.yaml`
- [x] T002 [P] Create dashboard page folder in `lib/features/dashboard/presentation/pages/`
- [x] T003 [P] Create dashboard widget folder in `lib/features/dashboard/presentation/widgets/`
- [x] T004 [P] Create dashboard loading widget folder in `lib/features/dashboard/presentation/widgets/loading/`
- [x] T005 [P] Create dashboard empty state widget folder in `lib/features/dashboard/presentation/widgets/empty_states/`
- [x] T006 [P] Create dashboard page test folder in `test/features/dashboard/presentation/pages/`
- [x] T007 [P] Create dashboard widget test folder in `test/features/dashboard/presentation/widgets/`
- [x] T008 Verify `assets/images/logo.png` is declared through `assets/images/` in `pubspec.yaml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Shared presentation helpers that every dashboard user story depends on.

**CRITICAL**: No user story work can begin until this phase is complete.

- [x] T009 [P] Create dashboard animation constants in `lib/features/dashboard/presentation/widgets/dashboard_animation_specs.dart`
- [x] T010 [P] Create dashboard responsive max-width helper in `lib/features/dashboard/presentation/widgets/dashboard_responsive_container.dart`
- [x] T011 [P] Create reusable shimmer primitive in `lib/features/dashboard/presentation/widgets/loading/dashboard_shimmer.dart`
- [x] T012 [P] Create shared skeleton box primitive in `lib/features/dashboard/presentation/widgets/loading/dashboard_skeleton_box.dart`
- [x] T013 [P] Create dashboard empty state widget in `lib/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart`
- [x] T014 [P] Create dashboard error view widget in `lib/features/dashboard/presentation/widgets/empty_states/dashboard_error_view.dart`
- [x] T015 [P] Add responsive container widget test in `test/features/dashboard/presentation/widgets/dashboard_responsive_container_test.dart`
- [x] T016 [P] Add shimmer skeleton primitive widget test in `test/features/dashboard/presentation/widgets/dashboard_skeleton_test.dart`
- [x] T017 [P] Add empty/error widget test in `test/features/dashboard/presentation/widgets/dashboard_empty_error_test.dart`

**Checkpoint**: Foundation ready; dashboard sections can now be implemented.

---

## Phase 3: User Story 1 - Land on a Polished Dashboard (Priority: P1) MVP

**Goal**: Authenticated users land on a polished dashboard with logo header, profile entry point, skeleton loading, and smooth content transition.

**Independent Test**: Render loading and loaded dashboard states and verify header, skeleton, profile navigation, and content transition behavior.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T018 [P] [US1] Add header logo/profile widget test in `test/features/dashboard/presentation/widgets/dashboard_header_test.dart`
- [x] T019 [P] [US1] Add dashboard loading skeleton page test in `test/features/dashboard/presentation/pages/dashboard_page_loading_test.dart`
- [x] T020 [P] [US1] Add dashboard loaded content transition test in `test/features/dashboard/presentation/pages/dashboard_page_loaded_test.dart`
- [x] T021 [P] [US1] Add dashboard profile navigation test in `test/features/dashboard/presentation/pages/dashboard_profile_navigation_test.dart`

### Implementation for User Story 1

- [x] T022 [P] [US1] Implement dashboard header in `lib/features/dashboard/presentation/widgets/dashboard_header.dart`
- [x] T023 [P] [US1] Implement dashboard skeleton wrapper in `lib/features/dashboard/presentation/widgets/loading/dashboard_skeleton.dart`
- [x] T024 [P] [US1] Implement stat card skeleton in `lib/features/dashboard/presentation/widgets/loading/stat_card_skeleton.dart`
- [x] T025 [P] [US1] Implement space card skeleton in `lib/features/dashboard/presentation/widgets/loading/space_card_skeleton.dart`
- [x] T026 [P] [US1] Implement container card skeleton in `lib/features/dashboard/presentation/widgets/loading/container_card_skeleton.dart`
- [x] T027 [P] [US1] Implement item card skeleton in `lib/features/dashboard/presentation/widgets/loading/item_card_skeleton.dart`
- [x] T028 [US1] Implement dashboard page state binding to existing `DashboardBloc` in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T029 [US1] Add skeleton-to-content fade transition in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T030 [US1] Wire profile avatar tap to Profile & Settings route in `lib/features/dashboard/presentation/widgets/dashboard_header.dart`
- [x] T031 [US1] Route authenticated landing to dashboard in `lib/core/routing/app_router.dart`

**Checkpoint**: User Story 1 is independently functional with loading and loaded shell behavior.

---

## Phase 4: User Story 2 - Search Across Storage (Priority: P1)

**Goal**: Users can search Spaces, Containers, and Items from the dashboard.

**Independent Test**: Type in the dashboard search field and verify matching dashboard entries filter in real time or trigger existing search navigation.

### Tests for User Story 2

- [x] T032 [P] [US2] Add search bar placeholder and semantics test in `test/features/dashboard/presentation/widgets/dashboard_search_bar_test.dart`
- [x] T033 [P] [US2] Add dashboard local filtering test in `test/features/dashboard/presentation/pages/dashboard_search_filter_test.dart`
- [x] T034 [P] [US2] Add no-results empty state test in `test/features/dashboard/presentation/pages/dashboard_search_empty_test.dart`

### Implementation for User Story 2

- [x] T035 [US2] Implement dashboard search bar in `lib/features/dashboard/presentation/widgets/dashboard_search_bar.dart`
- [x] T036 [US2] Add local query state and filtering in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T037 [US2] Render search no-results state with existing empty styling in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T038 [US2] Add search entrance animation in `lib/features/dashboard/presentation/widgets/dashboard_search_bar.dart`

**Checkpoint**: User Story 2 works independently with loaded dashboard data.

---

## Phase 5: User Story 3 - Review Overview Counts (Priority: P1)

**Goal**: Users can see total Spaces, Containers, and Items in one row and navigate from each overview card.

**Independent Test**: Render known totals and verify three equal-width cards remain in one row and navigate correctly.

### Tests for User Story 3

- [x] T039 [P] [US3] Add overview card layout test in `test/features/dashboard/presentation/widgets/dashboard_overview_cards_test.dart`
- [x] T040 [P] [US3] Add overview navigation test in `test/features/dashboard/presentation/pages/dashboard_overview_navigation_test.dart`
- [x] T041 [P] [US3] Add overview tap scale feedback test in `test/features/dashboard/presentation/widgets/dashboard_stat_card_test.dart`

### Implementation for User Story 3

- [x] T042 [P] [US3] Implement dashboard stat card in `lib/features/dashboard/presentation/widgets/dashboard_stat_card.dart`
- [x] T043 [US3] Implement dashboard overview cards row in `lib/features/dashboard/presentation/widgets/dashboard_overview_cards.dart`
- [x] T044 [US3] Add overview staggered animation in `lib/features/dashboard/presentation/widgets/dashboard_overview_cards.dart`
- [x] T045 [US3] Add overview card navigation callbacks in `lib/features/dashboard/presentation/pages/dashboard_page.dart`

**Checkpoint**: User Story 3 works independently with loaded dashboard totals.

---

## Phase 6: User Story 4 - Browse Recent Spaces, Containers, and Items (Priority: P2)

**Goal**: Users can browse latest Spaces, Containers, and Items and navigate to details or full lists.

**Independent Test**: Render dashboard data and verify section limits, card content, Show All navigation, and detail navigation.

### Tests for User Story 4

- [x] T046 [P] [US4] Add Spaces section limit/card test in `test/features/dashboard/presentation/widgets/dashboard_spaces_section_test.dart`
- [x] T047 [P] [US4] Add Containers section limit/card test in `test/features/dashboard/presentation/widgets/dashboard_containers_section_test.dart`
- [x] T048 [P] [US4] Add Items section limit/card test in `test/features/dashboard/presentation/widgets/dashboard_items_section_test.dart`
- [x] T049 [P] [US4] Add recent card navigation test in `test/features/dashboard/presentation/pages/dashboard_recent_navigation_test.dart`
- [x] T050 [P] [US4] Add Show All navigation test in `test/features/dashboard/presentation/pages/dashboard_show_all_navigation_test.dart`

### Implementation for User Story 4

- [x] T051 [P] [US4] Implement dashboard Space card in `lib/features/dashboard/presentation/widgets/dashboard_space_card.dart`
- [x] T052 [P] [US4] Implement dashboard Container card in `lib/features/dashboard/presentation/widgets/dashboard_container_card.dart`
- [x] T053 [P] [US4] Implement dashboard Item card in `lib/features/dashboard/presentation/widgets/dashboard_item_card.dart`
- [x] T054 [US4] Implement Spaces section in `lib/features/dashboard/presentation/widgets/dashboard_spaces_section.dart`
- [x] T055 [US4] Implement Containers section in `lib/features/dashboard/presentation/widgets/dashboard_containers_section.dart`
- [x] T056 [US4] Implement Items section in `lib/features/dashboard/presentation/widgets/dashboard_items_section.dart`
- [x] T057 [US4] Add staggered section/card animations in `lib/features/dashboard/presentation/widgets/dashboard_spaces_section.dart`
- [x] T058 [US4] Add staggered section/card animations in `lib/features/dashboard/presentation/widgets/dashboard_containers_section.dart`
- [x] T059 [US4] Add staggered section/card animations in `lib/features/dashboard/presentation/widgets/dashboard_items_section.dart`
- [x] T060 [US4] Wire section Show All and card navigation callbacks in `lib/features/dashboard/presentation/pages/dashboard_page.dart`

**Checkpoint**: User Story 4 works independently with loaded dashboard lists.

---

## Phase 7: User Story 5 - Handle Loading, Empty, Error, and Refresh States (Priority: P2)

**Goal**: Dashboard shows polished loading, empty, error, and refresh behavior without blank screens or layout jumps.

**Independent Test**: Simulate loading, empty, error, and refresh states and verify each section renders the expected UI.

### Tests for User Story 5

- [x] T061 [P] [US5] Add Spaces empty state test in `test/features/dashboard/presentation/widgets/dashboard_spaces_empty_test.dart`
- [x] T062 [P] [US5] Add Containers empty state test in `test/features/dashboard/presentation/widgets/dashboard_containers_empty_test.dart`
- [x] T063 [P] [US5] Add Items empty state test in `test/features/dashboard/presentation/widgets/dashboard_items_empty_test.dart`
- [x] T064 [P] [US5] Add dashboard error view test in `test/features/dashboard/presentation/widgets/dashboard_error_view_test.dart`
- [x] T065 [P] [US5] Add pull-to-refresh content retention test in `test/features/dashboard/presentation/pages/dashboard_refresh_test.dart`
- [x] T066 [P] [US5] Add responsive max-width test in `test/features/dashboard/presentation/pages/dashboard_responsive_test.dart`
- [x] T067 [P] [US5] Add dashboard accessibility semantics test in `test/features/dashboard/presentation/pages/dashboard_accessibility_test.dart`

### Implementation for User Story 5

- [x] T068 [US5] Add Spaces empty state rendering in `lib/features/dashboard/presentation/widgets/dashboard_spaces_section.dart`
- [x] T069 [US5] Add Containers empty state rendering in `lib/features/dashboard/presentation/widgets/dashboard_containers_section.dart`
- [x] T070 [US5] Add Items empty state rendering in `lib/features/dashboard/presentation/widgets/dashboard_items_section.dart`
- [x] T071 [US5] Wire dashboard error view retry action in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T072 [US5] Add pull-to-refresh behavior that preserves loaded content in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T073 [US5] Apply desktop max-width container in `lib/features/dashboard/presentation/pages/dashboard_page.dart`
- [x] T074 [US5] Add semantic labels and 48x48 tap targets across `lib/features/dashboard/presentation/widgets/`
- [x] T075 [US5] Verify dark mode readability for dashboard widgets in `lib/features/dashboard/presentation/widgets/`

**Checkpoint**: User Story 5 completes dashboard resilience, responsiveness, and accessibility.

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Final quality pass, validation, and documentation updates.

- [x] T076 [P] Document dashboard UI behavior and logo asset requirement in `README.md`
- [x] T077 [P] Add dashboard quickstart notes to `README.md`
- [x] T078 Run `dart format .` for all dashboard files
- [x] T079 Run `flutter analyze` and fix dashboard diagnostics
- [x] T080 Run `flutter test` and fix dashboard test failures
- [x] T081 Verify no new repositories, services, API clients, endpoints, or state management packages were added outside `flutter_animate` in `pubspec.yaml`
- [x] T082 Verify `DashboardPage` is the authenticated post-login route in `lib/core/routing/app_router.dart`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; starts immediately.
- **Foundational (Phase 2)**: Depends on Setup; blocks all stories.
- **US1 Dashboard Shell (Phase 3)**: Depends on Foundational.
- **US2 Search (Phase 4)**: Depends on US1 loaded dashboard content shell.
- **US3 Overview (Phase 5)**: Depends on US1 dashboard content shell.
- **US4 Recent Sections (Phase 6)**: Depends on US1 dashboard content shell.
- **US5 States/Responsive/A11y (Phase 7)**: Depends on US1-US4 widgets.
- **Polish (Phase 8)**: Depends on all desired user stories.

### User Story Dependencies

- **US1 (P1)**: MVP; creates dashboard page shell, header, and skeleton.
- **US2 (P1)**: Can start after US1 content shell exists.
- **US3 (P1)**: Can start after US1 content shell exists.
- **US4 (P2)**: Can start after US1 content shell exists.
- **US5 (P2)**: Depends on dashboard sections and skeletons.

### Within Each User Story

- Tests MUST be written and fail before implementation.
- Widgets before page integration.
- Page integration before route changes.
- Animation and accessibility pass after base widgets exist.
- No backend/API/repository work is allowed in this feature.

### Parallel Opportunities

- Phase 1 folder creation tasks T002-T007 can run in parallel.
- Foundational widgets T009-T014 can run in parallel after folders exist.
- Test tasks within each user story can run in parallel.
- US2, US3, and US4 can run in parallel after US1 shell exists.
- Individual section card widgets T051-T053 can run in parallel.
- Empty state tests T061-T064 can run in parallel.

---

## Parallel Example: User Story 4

```bash
Task: "Add Spaces section limit/card test in test/features/dashboard/presentation/widgets/dashboard_spaces_section_test.dart"
Task: "Add Containers section limit/card test in test/features/dashboard/presentation/widgets/dashboard_containers_section_test.dart"
Task: "Add Items section limit/card test in test/features/dashboard/presentation/widgets/dashboard_items_section_test.dart"
Task: "Implement dashboard Space card in lib/features/dashboard/presentation/widgets/dashboard_space_card.dart"
Task: "Implement dashboard Container card in lib/features/dashboard/presentation/widgets/dashboard_container_card.dart"
Task: "Implement dashboard Item card in lib/features/dashboard/presentation/widgets/dashboard_item_card.dart"
```

---

## Implementation Strategy

### MVP First

1. Complete Phase 1 and Phase 2.
2. Complete Phase 3 so authenticated users can land on dashboard shell with
   skeleton and loaded content transition.
3. Complete Phase 5 overview cards for high-value navigation.
4. Validate dashboard route, skeleton, header, and overview.

### Incremental Delivery

1. Dashboard shell and skeleton.
2. Search bar and filtering.
3. Overview cards.
4. Recent Spaces, Containers, and Items sections.
5. Empty/error/refresh/responsive/accessibility polish.

### Validation Commands

```bash
dart format .
flutter analyze
flutter test
```

---

## Notes

- Use existing `DashboardBloc`; do not create a replacement state manager.
- Do not create new repositories, services, API clients, endpoints, or backend work.
- Use `assets/images/logo.png` for the logo.
- Use `.specify/design-token.json` for exact token values.
- Use `.specify/assets/design-system-v1.jpeg` for visual intent.
- Keep animations short and avoid custom controllers unless absolutely required.
