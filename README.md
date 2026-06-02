# Keeply

Keeply is a Flutter mobile app for managing personal physical storage against the Keeply backend API.

## API Base URL

The default local API base URL is:

```text
http://localhost:3000
```

For Android emulator access to a backend running on the host machine, use:

```bash
flutter run --dart-define=KEEPLY_API_BASE_URL=http://10.0.2.2:3000
```

For iOS simulator, `http://localhost:3000` usually maps to the host machine.

## Design Sources

Use both local design sources together:

- `.specify/design-token.json` for exact colors, typography, spacing, radius, shadows, and component sizing.
- `.specify/assets/design-system-v1.jpeg` for visual layout, component treatment, and screen reference.

## Run

```bash
flutter pub get
flutter run
```

## Test and Quality

```bash
dart format .
flutter analyze
flutter test
```

## Auth Flow

The app starts at an auth gate, checks secure token storage, routes authenticated users to Spaces, and routes unauthenticated users to login. Protected requests attach a Bearer access token. Token-related 401 responses attempt refresh once, replace rotated tokens, and retry the original request. If refresh fails, tokens are cleared and the user returns to login.
