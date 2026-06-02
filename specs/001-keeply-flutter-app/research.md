# Research: Keeply Mobile Storage App

## Decision: Use BLoC/Cubit for Presentation State

**Decision**: Use `flutter_bloc` and `bloc`. Use Cubit for simple screen states
and Bloc for the app-wide authentication/session state machine.

**Rationale**: The app has predictable request, form, and navigation states
that map well to Cubits. Authentication has event-driven transitions across app
startup, login, refresh failure, and logout, so Bloc keeps those transitions
explicit and testable.

**Alternatives considered**: Riverpod was previously acceptable for the
constitution-level app direction, but this plan explicitly chooses BLoC/Cubit
to match the current planning request. Provider alone was rejected because it
does not give as much structure for state testing.

## Decision: Use Feature Repositories Between State and APIs

**Decision**: Each feature exposes a domain repository interface and a data
repository implementation that calls feature API classes.

**Rationale**: Repositories keep Cubits/Blocs independent from Dio, DTOs, and
backend response shapes. They also provide one place to convert API exceptions
into user-friendly failures and map DTOs into UI-friendly entities.

**Alternatives considered**: Calling API classes directly from Cubits is
simpler initially but spreads error mapping and DTO knowledge across
presentation code. A heavier clean architecture with use-case classes was
rejected for the first release because it would add boilerplate without clear
benefit.

## Decision: Use Dio with Auth and Refresh Interceptors

**Decision**: Use Dio as the HTTP client with a centralized `ApiClient`,
`AuthInterceptor`, and `TokenRefreshInterceptor`.

**Rationale**: Dio supports interceptors, request retry, cancellation, and
structured error handling. Centralizing Bearer attachment and refresh behavior
prevents each repository from implementing authentication details.

**Alternatives considered**: The Dart `http` package is lighter but would
require custom request wrapping for auth, retry, and error handling. Per-API
refresh handling was rejected because it is easy to implement inconsistently.

## Decision: Store Tokens with Flutter Secure Storage

**Decision**: Use `flutter_secure_storage` behind a `TokenStorage` abstraction.

**Rationale**: Access and refresh tokens are sensitive credentials and must not
be stored in plain preferences. A wrapper keeps storage mockable in tests and
keeps platform details away from auth logic.

**Alternatives considered**: `shared_preferences` was rejected for sensitive
token storage. In-memory-only tokens were rejected because users must remain
signed in across app launches.

## Decision: Use Freezed and Json Serializable for Models

**Decision**: Use `freezed`, `freezed_annotation`, `json_serializable`, and
`json_annotation` for immutable DTOs and value objects.

**Rationale**: Backend response shapes are structured and repetitive. Generated
parsing reduces manual JSON errors, supports immutable state classes, and
works well with BLoC tests.

**Alternatives considered**: Manual parsing is beginner-readable for a few
models but becomes error-prone across auth, storage tree, paths, and
subscription types. `equatable` alone is useful for state but does not solve
JSON parsing.

## Decision: Use GetIt for Dependency Injection

**Decision**: Use `get_it` with an explicit `setupServiceLocator()` function.

**Rationale**: GetIt is simple, readable, and enough for a small Flutter app.
It keeps APIs, repositories, token storage, and Cubits/Blocs replaceable in
tests without requiring generated DI setup.

**Alternatives considered**: `injectable` was considered but rejected for the
initial plan because it adds generated configuration. Constructor wiring in
widgets was rejected because it would clutter routing and screen setup.

## Decision: Use GoRouter with Auth-Aware Redirects

**Decision**: Use `go_router` for named and path-based routes, with redirects
based on `AuthBloc` state.

**Rationale**: Keeply needs guarded protected screens, auth screens, and deep
routes for Space, Container, Item, and move picker views. GoRouter keeps this
centralized and testable.

**Alternatives considered**: Navigator 1.0 was rejected because manual guarded
navigation gets noisy. AutoRoute was rejected because it adds code generation
not needed for this scale.

## Decision: Use Design Tokens and Screenshot Together

**Decision**: Create a small token adapter in `lib/core/theme/` that converts
`.specify/design-token.json` values into `DesignTokens`, `AppTheme`, and
component constants. Use `.specify/assets/design-system-v1.jpeg` as the visual
reference for screens, component treatment, density, navigation, chips, cards,
and item/location layouts.

**Rationale**: The token file is the visual source of truth. A dedicated
adapter makes assumptions explicit, avoids hardcoded visual values in widgets,
and lets design token changes flow through the app cleanly. The screenshot
adds product-level visual intent that raw token values cannot capture.

**Alternatives considered**: Hardcoding values in `ThemeData` or widgets was
rejected because it violates the design system requirement. Runtime parsing
only was rejected because tests and widgets benefit from typed constants. Using
only the screenshot was rejected because exact values must come from JSON.

## Decision: Use Very Good Analysis for Strict Linting

**Decision**: Use `very_good_analysis` and `dart format`.

**Rationale**: The constitution requires Google Dart style, strict quality, and
two-space formatting. This lint package gives a strong baseline while staying
common in Flutter projects.

**Alternatives considered**: `flutter_lints` is simpler but less strict.
Custom-only lints were rejected because they are harder to maintain.

## Decision: No Local Database in First Release

**Decision**: Do not add a local database or offline mutation queue in the
first implementation plan.

**Rationale**: The feature scope is an online client for a backend API. Secure
token storage and in-memory screen state satisfy current requirements while
keeping the app beginner-readable.

**Alternatives considered**: Hive, Drift, and SQLite were deferred because
offline-first sync behavior is not specified and would add complexity.
