# UI State Contract: Keeply Mobile Client

## Design Sources

All UI states and shared components use both design sources:

- `.specify/design-token.json` for exact colors, typography, spacing, radius,
  elevation, component sizing, and navigation sizing.
- `.specify/assets/design-system-v1.jpeg` for visual layout, screen examples,
  component styling, list density, cards, chips, and navigation treatment.

## Shared Screen States

Every feature screen uses explicit states so widgets remain predictable and
testable.

### Initial

Shown before a load or action starts. Screens should usually transition out of
this state immediately after creation.

### Loading

Shown while initial data is being fetched. Use the shared loading component and
avoid blocking app-wide navigation unless required.

### Loaded

Shown when data exists and the screen can render its primary content.

### Empty

Shown when the request succeeds but the list or section has no records.
Empty states include a short explanation and a primary action when appropriate.

### Error

Shown when a request or action fails. Use friendly copy and preserve diagnostic
codes for logs/support where useful.

### Submitting

Shown while a form, move, delete, or logout action is in progress. Disable the
submitting action to prevent duplicate requests.

### Success

Used for one-shot action completion. The page may navigate, refresh data, or
show a success message.

## Auth UI Contract

### Splash/Auth Gate

- Reads current auth state from `AuthBloc`.
- Authenticated users are routed to `/spaces`.
- Unauthenticated users are routed to `/login`.
- Unknown state shows branded loading.

### Login

- Requires email and password.
- Shows field validation before submission.
- Shows invalid credential errors as friendly copy.
- On success, routes to `/spaces`.

### Register

- Requires email, password, and name.
- Accepts optional profile image URL.
- Shows duplicate email errors as friendly copy.
- On success, routes to `/spaces`.

## Storage UI Contract

### Spaces List

- Loading: shared loading indicator.
- Empty: explain that Spaces are top-level storage locations and offer create
  action.
- Loaded: token-driven list rows with Space name and optional image.
- Error: retryable error banner or full-page error state.

### Space Detail/Tree

- Renders nested Containers and Items.
- Tapping a Space stays on/open its tree.
- Tapping a Container opens Container detail.
- Tapping an Item opens Item detail.
- Create actions know the current Space or Container parent.

### Container Detail

- Renders Container tree.
- Supports edit, delete, create child Container, create Item, and move.
- Delete failure for non-empty Container shows: "Move or delete the contents
  first."

### Item Detail

- Shows Item details and full breadcrumb path.
- Supports edit, delete, and move.
- Breadcrumb order is Space -> zero or more Containers -> Item.

### Move Destination Picker

- Shows Spaces and Containers as selectable destinations.
- Items are visible only if useful for context; they are disabled and never
  selectable.
- When moving a Container, the moving Container and descendants are disabled.
- API rejection messages are shown in an error banner.

## Subscription UI Contract

### Subscription Status

- Active entitlement: show active paid status and period end when available.
- Empty entitlements: show clear free/inactive state.
- Expired, revoked, inactive, or unknown entitlement: show inactive state with
  status detail.
- No RevenueCat webhook or server-side subscription UI is exposed.

## Shared Component Contract

- `AppButton`: primary, secondary, destructive, and loading variants.
- `AppTextField`: validation text, secure text support, and token-driven shape.
- `AppScaffold`: consistent background, safe areas, spacing, and app bar.
- `ErrorBanner`: friendly message with optional retry action.
- `AppLoadingIndicator`: branded progress indicator.
- `EmptyState`: icon/title/body/action pattern.
- `NodeTreeRow`: node icon/image, name, type, indentation, and action affordance.
- `BreadcrumbBar`: horizontal clickable segments with accessible labels.
- `ConfirmDialog`: title, body, cancel action, confirm action, destructive style.

## Accessibility Contract

- Breadcrumbs have labels such as "Open Garage space".
- Delete actions include destructive semantics and confirmation.
- Images use `altText` when provided and fallback labels when missing.
- Text respects system scaling.
- Focus order follows visual order in forms and dialogs.
