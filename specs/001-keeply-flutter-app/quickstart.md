# Quickstart: Keeply Mobile Storage App

## Prerequisites

- Flutter stable with Dart 3.x.
- A running Keeply backend API.
- The design token file at `.specify/design-token.json`.
- The design system screenshot at `.specify/assets/design-system-v1.jpeg`.

## Project Setup

Create or update the Flutter app in this repository, then add the planned
dependencies:

```bash
flutter pub add flutter_bloc bloc dio go_router get_it flutter_secure_storage
flutter pub add freezed_annotation json_annotation
flutter pub add --dev build_runner freezed json_serializable very_good_analysis bloc_test mocktail
```

After adding generated models or states, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## API Base URL

The app should read its API base URL from `AppConfig`.

Default local development:

```text
http://localhost:3000
```

Android emulator host localhost:

```text
http://10.0.2.2:3000
```

iOS simulator usually supports:

```text
http://localhost:3000
```

Document any runtime override used by the implementation, such as
`--dart-define=KEEPLY_API_BASE_URL=http://10.0.2.2:3000`.

## Design System Sources

Use both local design sources together:

- `.specify/design-token.json` provides exact token values.
- `.specify/assets/design-system-v1.jpeg` provides visual reference for
  screens, components, hierarchy, spacing feel, and interaction patterns.

Use `.specify/design-token.json` as the source for:

- brand name and tagline.
- colors.
- typography.
- spacing.
- radius.
- elevation.
- component sizing.
- navigation sizing.

Implementation should expose typed constants through `lib/core/theme/` and use
those constants from widgets. Use the screenshot to validate that screens and
shared widgets match Keeply's intended visual direction.

## Run the App

```bash
flutter pub get
flutter run
```

With an Android emulator pointed at a host backend:

```bash
flutter run --dart-define=KEEPLY_API_BASE_URL=http://10.0.2.2:3000
```

## Run Quality Checks

```bash
dart format .
flutter analyze
flutter test
```

## Auth Flow Overview

1. App starts at the splash/auth gate.
2. `AuthBloc` checks secure token storage.
3. If valid session data exists, route to `/spaces`.
4. If no session exists, route to `/login`.
5. Login/register stores access and refresh tokens securely.
6. Protected requests attach the Bearer access token.
7. Token-related 401 responses refresh once and retry.
8. Refresh failure clears tokens and returns to login.
9. Logout calls the backend logout endpoint when possible, then clears tokens.

## Storage Flow Overview

1. Spaces list loads top-level Spaces.
2. Space detail loads the Space tree.
3. Container detail loads the Container tree.
4. Item detail loads Item data and its breadcrumb path.
5. Move picker shows Spaces and Containers as destinations.
6. Space and Container deletes require confirmation and succeed only when empty.

## Test Focus

- DTO parsing for auth, storage, tree, item path, and subscription responses.
- Dio/API behavior for success envelopes, error envelopes, and 204 responses.
- Token refresh retry behavior and refresh failure logout.
- Repository mapping from DTOs to entities and failures.
- Cubit/Bloc transitions for auth, Spaces list, trees, move picker, delete, and
  subscription status.
- Widget behavior for auth gate, login, Spaces list, and breadcrumbs.
