# Quickstart: Authenticated User Dashboard

## Prerequisites

- Existing authenticated app shell.
- Existing `DashboardBloc`.
- Existing profile/settings route.
- Existing Spaces, Containers, and Items routes.
- `assets/images/logo.png` added by the user.
- Design sources:
  - `.specify/design-token.json`
  - `.specify/assets/design-system-v1.jpeg`

## Dependency

Add animation support:

```bash
flutter pub add flutter_animate
```

Do not add repositories, services, APIs, or a new state management package.

## Expected Files

```text
lib/features/dashboard/presentation/pages/dashboard_page.dart
lib/features/dashboard/presentation/widgets/dashboard_header.dart
lib/features/dashboard/presentation/widgets/dashboard_search_bar.dart
lib/features/dashboard/presentation/widgets/dashboard_overview_cards.dart
lib/features/dashboard/presentation/widgets/dashboard_stat_card.dart
lib/features/dashboard/presentation/widgets/dashboard_spaces_section.dart
lib/features/dashboard/presentation/widgets/dashboard_space_card.dart
lib/features/dashboard/presentation/widgets/dashboard_containers_section.dart
lib/features/dashboard/presentation/widgets/dashboard_container_card.dart
lib/features/dashboard/presentation/widgets/dashboard_items_section.dart
lib/features/dashboard/presentation/widgets/dashboard_item_card.dart
lib/features/dashboard/presentation/widgets/loading/dashboard_skeleton.dart
lib/features/dashboard/presentation/widgets/loading/stat_card_skeleton.dart
lib/features/dashboard/presentation/widgets/loading/space_card_skeleton.dart
lib/features/dashboard/presentation/widgets/loading/container_card_skeleton.dart
lib/features/dashboard/presentation/widgets/loading/item_card_skeleton.dart
lib/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart
lib/features/dashboard/presentation/widgets/empty_states/dashboard_error_view.dart
```

## Manual Validation

1. Sign in.
2. Confirm dashboard is the post-login landing page.
3. Confirm header has logo only on the left and one profile avatar/icon button
   on the right.
4. Confirm no app name, settings icon, or notification icon appears in header.
5. Confirm search appears directly below header.
6. Confirm overview cards remain one row on mobile.
7. Confirm Spaces, Containers, and Items sections cap at 5, 5, and 10 entries.
8. Confirm skeletons appear while loading and content fades in without layout
   shift.
9. Confirm empty states show the required messages and CTAs.
10. Confirm dark mode remains readable.

## Test Commands

```bash
dart format .
flutter analyze
flutter test
```

## Test Focus

- Dashboard loading renders skeleton, not blank screen.
- Loaded state renders header/search/overview/sections.
- Search filters loaded dashboard data.
- Overview cards navigate correctly.
- Section cards navigate correctly.
- Empty and error states render friendly UI.
- Responsive max width is applied on wide screens.
- Semantics labels exist for profile, search, cards, retry, and Show All.
