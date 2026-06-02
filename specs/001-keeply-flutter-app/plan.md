# Implementation Plan: Keeply Mobile Storage App

**Branch**: `001-keeply-flutter-app` | **Date**: 2026-06-02 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/001-keeply-flutter-app/spec.md`

**Note**: This template is filled in by the `/speckit-plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Build a Flutter mobile client for Keeply users to authenticate, manage Spaces,
nested Containers, Items, moves, breadcrumbs, empty-only deletes, profile, and
subscription status against the documented Keeply backend API. The plan uses a
beginner-readable BLoC/Cubit architecture with repositories, typed immutable
DTOs/entities, Dio networking, secure token storage, centralized refresh-token
handling, GoRouter navigation, GetIt dependency injection, and a
design-token-driven theme adapter sourced from `.specify/design-token.json`,
with `.specify/assets/design-system-v1.jpeg` as the visual reference for
screen composition, component styling, and interaction patterns.

## Technical Context

**Language/Version**: Dart 3.x with Flutter stable.

**Primary Dependencies**: `flutter_bloc`, `bloc`, `dio`, `go_router`,
`get_it`, `flutter_secure_storage`, `freezed_annotation`, `json_annotation`.
Dev dependencies: `build_runner`, `freezed`, `json_serializable`,
`very_good_analysis`, `bloc_test`, `mocktail`.

**Storage**: Secure local token persistence via `flutter_secure_storage`;
no local database for first release. In-memory Cubit/Bloc state and API
refetching are sufficient for storage hierarchy.

**Testing**: `flutter test`, `bloc_test`, `mocktail`, DTO parsing tests,
repository tests with mocked APIs, Cubit/Bloc tests, and widget tests for
auth gate, login, Spaces list, and item breadcrumbs.

**Target Platform**: Flutter mobile app for Android and iOS. Local backend URL
defaults to `http://localhost:3000`; Android emulator usage documents
`http://10.0.2.2:3000`.

**Project Type**: Mobile app client consuming an external REST API.

**Performance Goals**: Primary screens show loading or feedback within 1
second; long lists use lazy builders; move picker and tree screens avoid
unnecessary rebuilds; token refresh retries only once per failed request.

**Constraints**: Backend source is unavailable; all behavior comes from the
feature spec API contract. Widgets must use design tokens for visual values and
the design system screenshot for visual composition. Use two-space
indentation, strict linting, secure token storage, and no raw API calls in
widgets.

**Scale/Scope**: Auth, Spaces, Containers, Items, hierarchy tree, item
breadcrumbs, move destination picker, empty-only delete handling, profile,
subscription status, tests, and README documentation.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Flutter Style**: Plan identifies linting, `dart format`, two-space
  indentation, and how long or complex widget code will be decomposed. PASS:
  use `very_good_analysis`, `dart format`, extracted shared widgets, and
  feature-specific presentation widgets.
- **Testable Design**: Each user story has an independent verification path,
  with dependencies made injectable or replaceable where needed. PASS:
  repositories, API classes, token storage, and Cubits/Blocs are registered via
  GetIt and mockable in tests.
- **Testing Standards**: Unit, widget, and integration test coverage is
  identified for logic, UI behavior, and cross-screen/platform flows. PASS:
  model parsing, API, repository, Cubit/Bloc, and key widget tests are planned.
- **UX Consistency**: Shared components, design tokens, navigation patterns,
  loading states, empty states, error states, and accessibility needs are
  documented. PASS: token adapter and shared widgets cover app buttons, text
  fields, cards, rows, banners, loading, empty, breadcrumbs, and dialogs. The
  screenshot at `.specify/assets/design-system-v1.jpeg` guides layout and
  component appearance alongside `.specify/design-token.json`.
- **Performance and Lifecycle Safety**: Performance targets, memory risk areas,
  and disposal/cancellation ownership for controllers, subscriptions, timers,
  listeners, animations, and focus nodes are documented. PASS: Cubits/Blocs own
  streams/subscriptions, pages dispose controllers, Dio cancellation is scoped,
  and long lists use builders.

## Project Structure

### Documentation (this feature)

```text
specs/001-keeply-flutter-app/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── api-contract.md
│   └── ui-state-contract.md
└── tasks.md
```

### Source Code (repository root)
```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   │   └── app_config.dart
│   ├── di/
│   │   └── service_locator.dart
│   ├── error/
│   │   ├── api_exception.dart
│   │   └── failure.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── auth_interceptor.dart
│   │   └── token_refresh_interceptor.dart
│   ├── routing/
│   │   └── app_router.dart
│   ├── storage/
│   │   └── token_storage.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── design_tokens.dart
│       └── token_parser.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_api.dart
│   │   │   ├── auth_repository_impl.dart
│   │   │   └── models/
│   │   ├── domain/
│   │   │   ├── auth_repository.dart
│   │   │   └── entities/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── storage/
│   │   ├── data/
│   │   │   ├── storage_api.dart
│   │   │   ├── storage_repository_impl.dart
│   │   │   └── models/
│   │   ├── domain/
│   │   │   ├── storage_repository.dart
│   │   │   └── entities/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   └── subscription/
│       ├── data/
│       │   ├── subscription_api.dart
│       │   ├── subscription_repository_impl.dart
│       │   └── models/
│       ├── domain/
│       │   ├── subscription_repository.dart
│       │   └── entities/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── shared/
    ├── utils/
    └── widgets/

test/
├── core/
├── features/
└── shared/

integration_test/
```

**Structure Decision**: Use a single Flutter app with feature-first folders and
shared core infrastructure. Each feature keeps data/domain/presentation
boundaries, while shared widgets and core services avoid duplication.

## Design System Sources

Use both design sources for every UI-related task and Spec Kit document:

- `.specify/design-token.json`: source of truth for exact colors, typography,
  spacing, radius, elevation, component sizing, navigation sizing, and brand
  text.
- `.specify/assets/design-system-v1.jpeg`: source of truth for visual
  composition, screen examples, component treatment, navigation patterns,
  list-row density, cards, chips, empty/loading treatment, and overall Keeply
  look and feel.

If the screenshot and JSON differ, prefer JSON for exact numeric token values
and use the screenshot for visual intent. Document any discrepancy in the
implementation notes or task comments before choosing a value.

## Architecture and Data Flow

Use BLoC/Cubit as the presentation state boundary. Cubit is the default for
simple request and form state (`LoginCubit`, `SpacesCubit`, `ItemDetailCubit`,
`SubscriptionCubit`). Bloc is reserved for event-driven flows with transitions
that are easier to reason about as events, especially `AuthBloc` for app
session state and token lifecycle.

Data flows one way:

```text
Widget -> Cubit/Bloc -> Repository interface -> Repository implementation
  -> Feature API -> ApiClient/Dio -> Keeply backend
  -> DTO -> Repository mapper -> Domain entity -> Cubit/Bloc state -> Widget
```

Widgets never call Dio, parse raw JSON, or read secure storage directly.
Repositories convert API exceptions into `Failure` objects with friendly
messages and optional diagnostic codes.

## Authenticated Request Flow

`AppConfig` centralizes `baseUrl`, with default `http://localhost:3000`.
`TokenStorage` wraps `flutter_secure_storage` and exposes read, write, and
clear methods for access and refresh tokens. `AuthInterceptor` attaches
`Authorization: Bearer <accessToken>` to protected requests.

`TokenRefreshInterceptor` handles token-related 401 responses:

1. Detect token-related 401 responses from `AUTHENTICATION_REQUIRED`,
   `INVALID_TOKEN`, `TOKEN_EXPIRED`, or `SESSION_REVOKED`.
2. If the request has not already retried, call `POST /auth/refresh` with the
   stored refresh token using a refresh-safe Dio client.
3. Replace both access and refresh tokens because refresh tokens rotate.
4. Retry the original request once with the new access token.
5. If refresh fails, clear tokens and notify `AuthBloc` so navigation returns
   to login.

Logout calls `POST /auth/logout` with the stored refresh token when available,
then clears local session state regardless of server response.

## Navigation Plan

Use GoRouter with auth-aware redirects from `AuthBloc` state.

- `/splash`: splash/auth gate while stored session is checked.
- `/login`: login form.
- `/register`: registration form.
- `/spaces`: Spaces list.
- `/spaces/:spaceId`: Space detail/tree.
- `/containers/:containerId`: Container detail/tree.
- `/items/:itemId`: Item detail with breadcrumbs.
- `/move/:nodeType/:nodeId`: Move destination picker.
- `/subscription`: subscription status.
- `/settings`: profile/settings and logout.

Breadcrumb taps navigate by node type: Space to `/spaces/:spaceId`, Container
to `/containers/:containerId`, and Item to `/items/:itemId`.

## State Model Plan

Use simple immutable states with Freezed unions or Equatable classes:

- `initial`: no work started yet.
- `loading`: initial load in progress.
- `loaded`: data is available.
- `empty`: successful load with no records.
- `error`: load or action failed with friendly message.
- `submitting`: form or destructive action is in progress.
- `success`: action completed and caller can navigate or show feedback.

Screen-specific state holds only UI-ready domain entities, selected ids, form
values, and validation errors. Large derived values, such as disabled move
destinations, are computed in Cubit/repository helpers and tested directly.

## Reusable Components

Create token-driven shared widgets:

- `AppScaffold`
- `AppButton`
- `AppTextField`
- `AppCard`
- `AppListRow`
- `ErrorBanner`
- `AppLoadingIndicator`
- `EmptyState`
- `NodeTreeRow`
- `BreadcrumbBar`
- `ConfirmDialog`

Widgets use `AppTheme`, `DesignTokens`, and semantic labels. Visual constants
from `.specify/design-token.json` are exposed through the token adapter instead
of being hardcoded in feature widgets.

## Model and Entity Strategy

API DTOs mirror backend response shapes exactly and use
`freezed`/`json_serializable` for immutable value types and parsing. Domain
entities are UI-friendly and are mapped from DTOs in repositories. This keeps
backend naming and optional JSON concerns out of widgets while avoiding a heavy
domain layer.

Planned DTOs/entities:

- `ApiErrorDto`, `ApiException`, `Failure`
- `AuthUserDto` / `AuthUser`
- `AuthTokenResponseDto` / `AuthSession`
- `NodeImageDto` / `NodeImage`
- `NodeDto` / `StorageNode`
- `TreeNodeDto` / `StorageTreeNode`
- `PathSegmentDto` / `PathSegment`
- `ItemPathDto` / `ItemPath`
- `SubscriptionStatusDto` / `SubscriptionStatus`
- `SubscriptionEntitlementDto` / `SubscriptionEntitlement`

## Testing Strategy

- Model parsing tests cover success and missing optional fields for auth,
  storage nodes, tree nodes, paths, and subscription status.
- API client tests use mocked Dio responses and errors; no live backend is
  required.
- Repository tests mock feature APIs and verify DTO-to-entity mapping, friendly
  failure mapping, empty-only delete messages, and move rejection handling.
- Cubit/Bloc tests use `bloc_test` for auth gate, login, token refresh failure,
  Spaces list loading/empty/error, tree loading, move destination disabling,
  delete confirmation outcomes, and subscription states.
- Widget tests cover auth gate redirects, login validation/submission,
  Spaces list empty/loaded states, and item breadcrumb rendering/taps.

## Linting and Formatting Strategy

Use `very_good_analysis` with project-specific rules only where needed.
All Dart is formatted with `dart format`, uses two-space indentation, and keeps
widgets small by extracting form sections, list rows, dialogs, and tree nodes.
Raw endpoint strings live only in feature API classes. Raw colors, spacing,
radius, elevation, and typography values live only in `core/theme`.

## Implementation Milestones

1. Project setup and dependencies: Flutter scaffold, packages, linting, build
   runner, generated-code conventions, and base README.
2. Design token/theme adapter: parse `.specify/design-token.json`, create
   `DesignTokens`, `AppTheme`, component styles, and shared widgets.
3. API client and error handling: Dio setup, `AppConfig`, API envelope parsing,
   `ApiException`, `Failure`, auth and refresh interceptors.
4. Auth feature: secure token storage, auth API/repository, `AuthBloc`,
   `LoginCubit`, `RegisterCubit`, auth gate, login, register, logout.
5. Storage hierarchy feature: Spaces list, create/edit Space, Space tree,
   Container detail, create/edit Container, create/edit Item, Item detail.
6. Item path and move picker: breadcrumb API, clickable breadcrumb navigation,
   valid destination tree, disabled invalid targets, move error handling.
7. Subscription status: subscription API/repository, status Cubit, active and
   inactive/free UI states.
8. Tests and docs: model/API/repository/Cubit/widget tests and README covering
   base URL, emulator localhost, iOS simulator localhost, run commands, auth
   flow, design tokens, and testing.

## Complexity Tracking

No constitution violations.
