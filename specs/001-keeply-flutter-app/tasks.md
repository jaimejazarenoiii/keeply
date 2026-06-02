# Tasks: Keeply Mobile Storage App

**Input**: Design documents from `/specs/001-keeply-flutter-app/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Test tasks are REQUIRED for each feature. Include unit, widget, and
integration tests when applicable, or document why a test type is not relevant.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Flutter app**: `lib/`, `test/`, `integration_test/`
- **Feature docs**: `specs/001-keeply-flutter-app/`
- **Design sources**: `.specify/design-token.json`, `.specify/assets/design-system-v1.jpeg`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Initialize the Flutter project, dependencies, linting, and design source access.

- [X] T001 Create Flutter project scaffold in `pubspec.yaml`, `lib/main.dart`, `lib/app.dart`, `android/`, and `ios/`
- [X] T002 Add runtime dependencies in `pubspec.yaml`: `flutter_bloc`, `bloc`, `dio`, `go_router`, `get_it`, `flutter_secure_storage`, `freezed_annotation`, and `json_annotation`
- [X] T003 Add dev dependencies in `pubspec.yaml`: `build_runner`, `freezed`, `json_serializable`, `very_good_analysis`, `bloc_test`, and `mocktail`
- [X] T004 Configure strict linting and two-space formatting in `analysis_options.yaml`
- [X] T005 [P] Create source folder structure under `lib/core/`, `lib/features/`, and `lib/shared/`
- [X] T006 [P] Create test folder structure under `test/core/`, `test/features/`, `test/shared/`, and `integration_test/`
- [X] T007 [P] Configure asset access for `.specify/design-token.json` and `.specify/assets/design-system-v1.jpeg` in `pubspec.yaml`
- [X] T008 [P] Create app entry wiring in `lib/main.dart` and `lib/app.dart`
- [X] T009 [P] Create initial README sections in `README.md` for setup, base URL, design sources, and test commands

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core architecture and shared infrastructure that MUST be complete before user story work begins.

**CRITICAL**: No user story work can begin until this phase is complete.

- [X] T010 [P] Implement app configuration and API base URL handling in `lib/core/config/app_config.dart`
- [X] T011 [P] Implement API error and failure types in `lib/core/error/api_exception.dart` and `lib/core/error/failure.dart`
- [X] T012 [P] Implement secure token storage abstraction in `lib/core/storage/token_storage.dart`
- [X] T013 [P] Implement design token value classes in `lib/core/theme/design_tokens.dart`
- [X] T014 Implement design token JSON parser in `lib/core/theme/token_parser.dart`
- [X] T015 Implement token-driven Flutter theme in `lib/core/theme/app_theme.dart`
- [X] T016 [P] Implement shared `AppButton` component in `lib/shared/widgets/app_button.dart`
- [X] T017 [P] Implement shared `AppTextField` component in `lib/shared/widgets/app_text_field.dart`
- [X] T018 [P] Implement shared `AppScaffold` component in `lib/shared/widgets/app_scaffold.dart`
- [X] T019 [P] Implement shared `ErrorBanner` component in `lib/shared/widgets/error_banner.dart`
- [X] T020 [P] Implement shared `AppLoadingIndicator` component in `lib/shared/widgets/app_loading_indicator.dart`
- [X] T021 [P] Implement shared `EmptyState` component in `lib/shared/widgets/empty_state.dart`
- [X] T022 [P] Implement shared `ConfirmDialog` component in `lib/shared/widgets/confirm_dialog.dart`
- [X] T023 Implement centralized Dio API client and envelope parsing in `lib/core/network/api_client.dart`
- [X] T024 Implement Bearer token attachment in `lib/core/network/auth_interceptor.dart`
- [X] T025 Implement refresh-once token retry behavior in `lib/core/network/token_refresh_interceptor.dart`
- [X] T026 Implement service locator registrations in `lib/core/di/service_locator.dart`
- [X] T027 Implement initial GoRouter route shell in `lib/core/routing/app_router.dart`
- [X] T028 [P] Create common API model tests in `test/core/error/api_exception_test.dart`
- [X] T029 [P] Create design token parser tests using `.specify/design-token.json` in `test/core/theme/token_parser_test.dart`
- [X] T030 [P] Create API client envelope and 204 response tests in `test/core/network/api_client_test.dart`
- [X] T031 [P] Create token storage mock test helpers in `test/helpers/mock_token_storage.dart`
- [X] T032 [P] Create Dio mock test helpers in `test/helpers/mock_dio.dart`
- [X] T033 Run generated-code setup command and commit generated files in `lib/**/*.freezed.dart` and `lib/**/*.g.dart`

**Checkpoint**: Foundation ready; user story implementation can now begin in parallel.

---

## Phase 3: User Story 1 - Sign In and Keep Session (Priority: P1) MVP

**Goal**: A user can register, sign in, stay signed in across launches, refresh an expired session once, and log out.

**Independent Test**: Register or sign in, reopen the app, confirm the session persists, then log out and confirm protected screens are inaccessible.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [X] T034 [P] [US1] Add auth DTO parsing tests in `test/features/auth/data/models/auth_models_test.dart`
- [X] T035 [P] [US1] Add auth API tests for register, login, refresh, logout, and me in `test/features/auth/data/auth_api_test.dart`
- [X] T036 [P] [US1] Add auth repository tests for token persistence and failure mapping in `test/features/auth/data/auth_repository_impl_test.dart`
- [X] T037 [P] [US1] Add AuthBloc session transition tests in `test/features/auth/presentation/bloc/auth_bloc_test.dart`
- [X] T038 [P] [US1] Add login and register Cubit tests in `test/features/auth/presentation/bloc/login_register_cubit_test.dart`
- [X] T039 [P] [US1] Add auth gate widget test in `test/features/auth/presentation/pages/auth_gate_test.dart`
- [X] T040 [P] [US1] Add login page widget test in `test/features/auth/presentation/pages/login_page_test.dart`

### Implementation for User Story 1

- [X] T041 [P] [US1] Create auth DTOs in `lib/features/auth/data/models/auth_models.dart`
- [X] T042 [P] [US1] Create auth domain entities in `lib/features/auth/domain/entities/auth_user.dart` and `lib/features/auth/domain/entities/auth_session.dart`
- [X] T043 [US1] Create auth API methods for `/auth/register`, `/auth/login`, `/auth/refresh`, `/auth/logout`, and `/auth/me` in `lib/features/auth/data/auth_api.dart`
- [X] T044 [US1] Define auth repository interface in `lib/features/auth/domain/auth_repository.dart`
- [X] T045 [US1] Implement auth repository and DTO-to-entity mapping in `lib/features/auth/data/auth_repository_impl.dart`
- [X] T046 [US1] Implement app-wide `AuthBloc` in `lib/features/auth/presentation/bloc/auth_bloc.dart`
- [X] T047 [P] [US1] Implement `LoginCubit` in `lib/features/auth/presentation/bloc/login_cubit.dart`
- [X] T048 [P] [US1] Implement `RegisterCubit` in `lib/features/auth/presentation/bloc/register_cubit.dart`
- [X] T049 [US1] Implement splash/auth gate page in `lib/features/auth/presentation/pages/auth_gate_page.dart`
- [X] T050 [US1] Implement login page using shared form components in `lib/features/auth/presentation/pages/login_page.dart`
- [X] T051 [US1] Implement register page using shared form components in `lib/features/auth/presentation/pages/register_page.dart`
- [X] T052 [US1] Wire auth redirects and public/protected route guards in `lib/core/routing/app_router.dart`
- [X] T053 [US1] Register auth APIs, repositories, Bloc, and Cubits in `lib/core/di/service_locator.dart`
- [X] T054 [US1] Verify lifecycle cleanup for auth form controllers in `lib/features/auth/presentation/pages/login_page.dart` and `lib/features/auth/presentation/pages/register_page.dart`
- [X] T055 [US1] Document auth flow and secure token behavior in `README.md`

**Checkpoint**: User Story 1 is independently functional and testable.

---

## Phase 4: User Story 2 - Manage Spaces, Containers, and Items (Priority: P1)

**Goal**: A signed-in user can create, view, edit, and delete their storage hierarchy.

**Independent Test**: Create a Space, add nested Containers and Items, edit details, and verify the hierarchy displays correctly.

### Tests for User Story 2

- [X] T056 [P] [US2] Add storage node DTO parsing tests in `test/features/storage/data/models/storage_models_test.dart`
- [X] T057 [P] [US2] Add storage API tests for Spaces, Containers, and Items CRUD in `test/features/storage/data/storage_api_test.dart`
- [X] T058 [P] [US2] Add storage repository mapping tests in `test/features/storage/data/storage_repository_impl_test.dart`
- [X] T059 [P] [US2] Add SpacesCubit tests in `test/features/storage/presentation/bloc/spaces_cubit_test.dart`
- [X] T060 [P] [US2] Add SpaceTreeCubit tests in `test/features/storage/presentation/bloc/space_tree_cubit_test.dart`
- [X] T061 [P] [US2] Add edit form Cubit tests in `test/features/storage/presentation/bloc/storage_form_cubit_test.dart`
- [X] T062 [P] [US2] Add Spaces list widget tests in `test/features/storage/presentation/pages/spaces_list_page_test.dart`

### Implementation for User Story 2

- [X] T063 [P] [US2] Create storage DTOs in `lib/features/storage/data/models/storage_models.dart`
- [X] T064 [P] [US2] Create storage domain entities in `lib/features/storage/domain/entities/storage_node.dart` and `lib/features/storage/domain/entities/storage_tree_node.dart`
- [X] T065 [US2] Create storage API methods for Space, Container, and Item CRUD in `lib/features/storage/data/storage_api.dart`
- [X] T066 [US2] Define storage repository interface in `lib/features/storage/domain/storage_repository.dart`
- [X] T067 [US2] Implement storage repository and mapping in `lib/features/storage/data/storage_repository_impl.dart`
- [X] T068 [US2] Implement Spaces list Cubit in `lib/features/storage/presentation/bloc/spaces_cubit.dart`
- [X] T069 [US2] Implement Space tree Cubit in `lib/features/storage/presentation/bloc/space_tree_cubit.dart`
- [X] T070 [US2] Implement Container detail Cubit in `lib/features/storage/presentation/bloc/container_detail_cubit.dart`
- [X] T071 [US2] Implement Item detail Cubit in `lib/features/storage/presentation/bloc/item_detail_cubit.dart`
- [X] T072 [US2] Implement shared storage form Cubit in `lib/features/storage/presentation/bloc/storage_form_cubit.dart`
- [X] T073 [P] [US2] Implement `NodeTreeRow` shared storage widget in `lib/features/storage/presentation/widgets/node_tree_row.dart`
- [X] T074 [P] [US2] Implement storage node form widget in `lib/features/storage/presentation/widgets/storage_node_form.dart`
- [X] T075 [US2] Implement Spaces list page in `lib/features/storage/presentation/pages/spaces_list_page.dart`
- [X] T076 [US2] Implement create/edit Space page in `lib/features/storage/presentation/pages/space_form_page.dart`
- [X] T077 [US2] Implement Space detail/tree page in `lib/features/storage/presentation/pages/space_detail_page.dart`
- [X] T078 [US2] Implement Container detail/tree page in `lib/features/storage/presentation/pages/container_detail_page.dart`
- [X] T079 [US2] Implement create/edit Container page in `lib/features/storage/presentation/pages/container_form_page.dart`
- [X] T080 [US2] Implement create/edit Item page in `lib/features/storage/presentation/pages/item_form_page.dart`
- [X] T081 [US2] Implement Item detail page base view in `lib/features/storage/presentation/pages/item_detail_page.dart`
- [X] T082 [US2] Wire storage routes in `lib/core/routing/app_router.dart`
- [X] T083 [US2] Register storage APIs, repositories, and Cubits in `lib/core/di/service_locator.dart`

**Checkpoint**: User Stories 1 and 2 both work independently.

---

## Phase 5: User Story 3 - Navigate Location Paths (Priority: P2)

**Goal**: A user can view and tap an Item's full breadcrumb path.

**Independent Test**: Open an Item in nested Containers, confirm the full path, and tap each breadcrumb to navigate to the matching location.

### Tests for User Story 3

- [X] T084 [P] [US3] Add item path DTO parsing tests in `test/features/storage/data/models/item_path_models_test.dart`
- [X] T085 [P] [US3] Add item path API and repository tests in `test/features/storage/data/item_path_repository_test.dart`
- [X] T086 [P] [US3] Add item breadcrumb Cubit tests in `test/features/storage/presentation/bloc/item_breadcrumb_cubit_test.dart`
- [X] T087 [P] [US3] Add breadcrumb widget navigation tests in `test/features/storage/presentation/widgets/breadcrumb_bar_test.dart`

### Implementation for User Story 3

- [X] T088 [P] [US3] Add path segment and item path DTOs in `lib/features/storage/data/models/item_path_models.dart`
- [X] T089 [P] [US3] Add path segment and item path entities in `lib/features/storage/domain/entities/item_path.dart`
- [X] T090 [US3] Add `GET /items/{itemId}/path` method in `lib/features/storage/data/storage_api.dart`
- [X] T091 [US3] Add item path repository method in `lib/features/storage/domain/storage_repository.dart` and `lib/features/storage/data/storage_repository_impl.dart`
- [X] T092 [US3] Implement ItemBreadcrumbCubit in `lib/features/storage/presentation/bloc/item_breadcrumb_cubit.dart`
- [X] T093 [US3] Implement token-driven BreadcrumbBar in `lib/features/storage/presentation/widgets/breadcrumb_bar.dart`
- [X] T094 [US3] Integrate breadcrumbs into item detail page in `lib/features/storage/presentation/pages/item_detail_page.dart`
- [X] T095 [US3] Wire breadcrumb navigation by node type in `lib/core/routing/app_router.dart`
- [X] T096 [US3] Add breadcrumb accessibility labels in `lib/features/storage/presentation/widgets/breadcrumb_bar.dart`

**Checkpoint**: User Story 3 works independently after foundational storage data exists.

---

## Phase 6: User Story 4 - Move Things Safely (Priority: P2)

**Goal**: A user can move Containers and Items to valid Spaces or Containers without invalid hierarchy relationships.

**Independent Test**: Move an Item and Container to valid destinations, then verify invalid destinations are disabled or rejected with a clear message.

### Tests for User Story 4

- [X] T097 [P] [US4] Add move API tests for Item and Container moves in `test/features/storage/data/move_api_test.dart`
- [X] T098 [P] [US4] Add move destination rule tests in `test/features/storage/domain/move_destination_rules_test.dart`
- [X] T099 [P] [US4] Add MoveDestinationCubit tests in `test/features/storage/presentation/bloc/move_destination_cubit_test.dart`
- [X] T100 [P] [US4] Add move picker widget tests in `test/features/storage/presentation/pages/move_destination_page_test.dart`

### Implementation for User Story 4

- [X] T101 [US4] Add move methods for `/containers/{containerId}/move` and `/items/{itemId}/move` in `lib/features/storage/data/storage_api.dart`
- [X] T102 [US4] Add move repository methods in `lib/features/storage/domain/storage_repository.dart` and `lib/features/storage/data/storage_repository_impl.dart`
- [X] T103 [P] [US4] Implement move destination rule helper in `lib/features/storage/domain/entities/move_destination_rules.dart`
- [X] T104 [US4] Implement MoveDestinationCubit in `lib/features/storage/presentation/bloc/move_destination_cubit.dart`
- [X] T105 [US4] Implement move destination picker page in `lib/features/storage/presentation/pages/move_destination_page.dart`
- [X] T106 [US4] Disable Item targets, self targets, and descendant targets in `lib/features/storage/presentation/pages/move_destination_page.dart`
- [X] T107 [US4] Show API move rejection messages in `lib/features/storage/presentation/bloc/move_destination_cubit.dart`
- [X] T108 [US4] Wire move route `/move/:nodeType/:nodeId` in `lib/core/routing/app_router.dart`

**Checkpoint**: User Story 4 works independently for move flows.

---

## Phase 7: User Story 5 - Delete with Safety Rules (Priority: P2)

**Goal**: A user can delete Items directly and delete Spaces/Containers only when empty.

**Independent Test**: Delete an Item, attempt non-empty Space/Container deletes, empty them, then delete successfully.

### Tests for User Story 5

- [X] T109 [P] [US5] Add delete failure mapping tests in `test/features/storage/data/delete_failure_mapping_test.dart`
- [X] T110 [P] [US5] Add delete action Cubit tests in `test/features/storage/presentation/bloc/delete_node_cubit_test.dart`
- [X] T111 [P] [US5] Add delete confirmation dialog widget tests in `test/shared/widgets/confirm_dialog_test.dart`

### Implementation for User Story 5

- [X] T112 [US5] Implement delete failure mapping for non-empty Space and Container responses in `lib/features/storage/data/storage_repository_impl.dart`
- [X] T113 [US5] Implement DeleteNodeCubit in `lib/features/storage/presentation/bloc/delete_node_cubit.dart`
- [X] T114 [US5] Integrate delete confirmation into Space detail page in `lib/features/storage/presentation/pages/space_detail_page.dart`
- [X] T115 [US5] Integrate delete confirmation into Container detail page in `lib/features/storage/presentation/pages/container_detail_page.dart`
- [X] T116 [US5] Integrate delete confirmation into Item detail page in `lib/features/storage/presentation/pages/item_detail_page.dart`

**Checkpoint**: User Story 5 works independently for safe delete flows.

---

## Phase 8: User Story 6 - View Account and Subscription Status (Priority: P3)

**Goal**: A signed-in user can view profile details, sign out, and see subscription status.

**Independent Test**: Open settings, view profile details, view active and inactive subscription states, and log out.

### Tests for User Story 6

- [X] T117 [P] [US6] Add subscription DTO parsing tests in `test/features/subscription/data/models/subscription_models_test.dart`
- [X] T118 [P] [US6] Add subscription API and repository tests in `test/features/subscription/data/subscription_repository_impl_test.dart`
- [X] T119 [P] [US6] Add SubscriptionCubit tests in `test/features/subscription/presentation/bloc/subscription_cubit_test.dart`
- [X] T120 [P] [US6] Add settings page widget tests in `test/features/auth/presentation/pages/settings_page_test.dart`
- [X] T121 [P] [US6] Add subscription status widget tests in `test/features/subscription/presentation/pages/subscription_status_page_test.dart`

### Implementation for User Story 6

- [X] T122 [P] [US6] Create subscription DTOs in `lib/features/subscription/data/models/subscription_models.dart`
- [X] T123 [P] [US6] Create subscription entities in `lib/features/subscription/domain/entities/subscription_status.dart`
- [X] T124 [US6] Implement subscription API method for `/subscription/status` in `lib/features/subscription/data/subscription_api.dart`
- [X] T125 [US6] Define subscription repository interface in `lib/features/subscription/domain/subscription_repository.dart`
- [X] T126 [US6] Implement subscription repository mapping in `lib/features/subscription/data/subscription_repository_impl.dart`
- [X] T127 [US6] Implement SubscriptionCubit in `lib/features/subscription/presentation/bloc/subscription_cubit.dart`
- [X] T128 [US6] Implement subscription status page in `lib/features/subscription/presentation/pages/subscription_status_page.dart`
- [X] T129 [US6] Implement profile/settings page with logout action in `lib/features/auth/presentation/pages/settings_page.dart`
- [X] T130 [US6] Wire settings and subscription routes in `lib/core/routing/app_router.dart`
- [X] T131 [US6] Register subscription API, repository, and Cubit in `lib/core/di/service_locator.dart`

**Checkpoint**: User Story 6 works independently for account and subscription visibility.

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Final quality, documentation, accessibility, and performance work across all stories.

- [X] T132 [P] Add README documentation for Android emulator localhost, iOS simulator localhost, auth flow, tests, and design sources in `README.md`
- [X] T133 [P] Add quickstart validation notes from `specs/001-keeply-flutter-app/quickstart.md` to `README.md`
- [X] T134 [P] Add integration smoke tests for auth-to-spaces flow in `integration_test/auth_storage_flow_test.dart`
- [X] T135 [P] Add accessibility semantics review fixes in `lib/shared/widgets/` and `lib/features/storage/presentation/widgets/`
- [X] T136 [P] Add performance pass for tree/list builders in `lib/features/storage/presentation/pages/`
- [X] T137 [P] Add lifecycle cleanup review fixes for controllers, streams, timers, listeners, and focus nodes in `lib/features/`
- [X] T138 Run generated code and formatting for all Dart files in `lib/` and `test/`
- [X] T139 Run final analyze and test commands documented in `README.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; starts immediately.
- **Foundational (Phase 2)**: Depends on Setup; blocks all user stories.
- **US1 Auth (Phase 3)**: Depends on Foundational; MVP scope.
- **US2 Storage CRUD (Phase 4)**: Depends on Foundational and benefits from US1 for protected navigation.
- **US3 Breadcrumbs (Phase 5)**: Depends on US2 Item detail and storage repository.
- **US4 Move (Phase 6)**: Depends on US2 tree data and storage repository.
- **US5 Delete (Phase 7)**: Depends on US2 detail pages and storage repository.
- **US6 Subscription/Settings (Phase 8)**: Depends on US1 for signed-in profile/logout.
- **Polish (Phase 9)**: Depends on all desired user stories.

### User Story Dependencies

- **US1 (P1)**: No story dependency after foundation; required for authenticated app shell.
- **US2 (P1)**: Can begin after foundation; protected runtime use depends on US1 auth.
- **US3 (P2)**: Depends on US2 Item detail and path repository integration.
- **US4 (P2)**: Depends on US2 tree data and node models.
- **US5 (P2)**: Depends on US2 detail pages and delete API coverage.
- **US6 (P3)**: Depends on US1 auth session state.

### Within Each User Story

- Tests MUST be written and fail before implementation.
- DTOs/entities before APIs/repositories.
- APIs/repositories before Cubits/Blocs.
- Cubits/Blocs before pages/widgets.
- Routes and DI after feature classes exist.
- Story complete before moving to the next priority unless work is parallelized by separate files.

### Parallel Opportunities

- Setup tasks T005-T009 can run in parallel after T001.
- Foundational shared widgets T016-T022 can run in parallel after T013-T015.
- Foundational tests T028-T032 can run in parallel after the related foundation files exist.
- Test tasks within each user story are parallelizable.
- DTO/entity tasks in each story can run in parallel with tests.
- US3, US4, and US5 can proceed in parallel after US2 storage foundations are stable.
- US6 can proceed in parallel with storage stories after US1 auth is stable.

---

## Parallel Example: User Story 1

```bash
Task: "Add auth DTO parsing tests in test/features/auth/data/models/auth_models_test.dart"
Task: "Add auth API tests for register, login, refresh, logout, and me in test/features/auth/data/auth_api_test.dart"
Task: "Add AuthBloc session transition tests in test/features/auth/presentation/bloc/auth_bloc_test.dart"
Task: "Create auth DTOs in lib/features/auth/data/models/auth_models.dart"
Task: "Create auth domain entities in lib/features/auth/domain/entities/auth_user.dart and lib/features/auth/domain/entities/auth_session.dart"
```

## Parallel Example: User Story 2

```bash
Task: "Add storage node DTO parsing tests in test/features/storage/data/models/storage_models_test.dart"
Task: "Add storage API tests for Spaces, Containers, and Items CRUD in test/features/storage/data/storage_api_test.dart"
Task: "Create storage DTOs in lib/features/storage/data/models/storage_models.dart"
Task: "Create storage domain entities in lib/features/storage/domain/entities/storage_node.dart and lib/features/storage/domain/entities/storage_tree_node.dart"
Task: "Implement NodeTreeRow shared storage widget in lib/features/storage/presentation/widgets/node_tree_row.dart"
```

## Parallel Example: User Stories 3-5

```bash
Task: "Implement ItemBreadcrumbCubit in lib/features/storage/presentation/bloc/item_breadcrumb_cubit.dart"
Task: "Implement MoveDestinationCubit in lib/features/storage/presentation/bloc/move_destination_cubit.dart"
Task: "Implement DeleteNodeCubit in lib/features/storage/presentation/bloc/delete_node_cubit.dart"
```

---

## Implementation Strategy

### MVP First

1. Complete Phase 1 and Phase 2.
2. Complete Phase 3 (US1 Auth).
3. Complete Phase 4 (US2 Storage CRUD).
4. Stop and validate register/login, session persistence, Spaces list, create Space, create Container, create Item, and item detail.

### Incremental Delivery

1. Add US1 for secure access and app shell.
2. Add US2 for core storage hierarchy management.
3. Add US3 for breadcrumbs.
4. Add US4 for move flows.
5. Add US5 for safe delete flows.
6. Add US6 for account and subscription visibility.
7. Finish polish, accessibility, performance, lifecycle cleanup, tests, and docs.

### Validation Commands

```bash
dart format .
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
```

---

## Notes

- Use `.specify/design-token.json` for exact visual values.
- Use `.specify/assets/design-system-v1.jpeg` for visual layout and component intent.
- Raw endpoint strings belong only in feature API classes.
- Widgets must not parse raw JSON or call Dio directly.
- Use Cubit for simple screen state and Bloc for app-wide auth/session state.
- Verify lifecycle-owned resources are disposed or canceled.
- Keep generated files from `freezed` and `json_serializable` in sync after model/state changes.
