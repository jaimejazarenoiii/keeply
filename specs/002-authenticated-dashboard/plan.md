# Implementation Plan: Authenticated User Dashboard

**Branch**: `002-authenticated-dashboard` | **Date**: 2026-06-03 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/002-authenticated-dashboard/spec.md`

**Note**: This template is filled in by the `/speckit-plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Build a modern authenticated dashboard UI as the post-login landing page. The
implementation is intentionally presentation-focused: use the existing app
architecture, existing authentication, existing API/repository/model layers, and
the expected existing `DashboardBloc` state source. Do not introduce new
repositories, services, API endpoints, backend changes, or a new state
management solution. Add only UI widgets, route integration, animation support,
skeleton/empty/error presentation, and tests needed to validate the dashboard
experience.

## Technical Context

**Language/Version**: Dart 3.12.1 with Flutter stable.

**Primary Dependencies**: Existing Flutter app, Material 3, `flutter_bloc`,
`go_router`, existing dashboard/auth/storage state and models, existing shared
widgets/theme, plus `flutter_animate` for concise fade/move/scale effects.

**Storage**: N/A for this UI feature. No new persistence layer.

**Testing**: `flutter test` widget tests for dashboard loading, loaded, empty,
error, search filtering, navigation taps, responsive constraints, and semantic
labels. Continue using existing `flutter analyze`.

**Target Platform**: Flutter mobile first, responsive tablet/desktop/web.

**Project Type**: Flutter app presentation feature.

**Performance Goals**: 60 FPS animations, no blank dashboard loading state,
250ms skeleton-to-content fade, 300ms header animation, 350ms search animation,
150ms tap scale feedback, and no layout shift between skeleton and content.

**Constraints**: Do not create new architecture, repositories, services, API
endpoints, backend work, or state management solution. Use existing
`DashboardBloc` and existing data source. Use `.specify/design-token.json` for
exact visual values and `.specify/assets/design-system-v1.jpeg` for visual
intent. Header logo path is `assets/images/logo.png`.

**Scale/Scope**: One dashboard page, dashboard presentation widgets,
loading/skeleton widgets, empty/error widgets, route update, optional
`flutter_animate` dependency, and focused widget tests.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Flutter Style**: Plan identifies linting, `dart format`, two-space
  indentation, and how long or complex widget code will be decomposed. PASS:
  widgets are split by dashboard section and skeleton type.
- **Testable Design**: Each user story has an independent verification path,
  with dependencies made injectable or replaceable where needed. PASS:
  dashboard uses existing Bloc state and widget tests can inject mocked states.
- **Testing Standards**: Unit, widget, and integration test coverage is
  identified for logic, UI behavior, and cross-screen/platform flows. PASS:
  plan focuses on widget tests for loading, loaded, empty, error, search, and
  navigation behavior.
- **UX Consistency**: Shared components, design tokens, navigation patterns,
  loading states, empty states, error states, and accessibility needs are
  documented. PASS: both design sources are required and dashboard widgets use
  existing theme/shared patterns.
- **Performance and Lifecycle Safety**: Performance targets, memory risk areas,
  and disposal/cancellation ownership for controllers, subscriptions, timers,
  listeners, animations, and focus nodes are documented. PASS: no custom
  controllers are required beyond optional search text handling; animations use
  package/implicit widgets and avoid long durations.

## Project Structure

### Documentation (this feature)

```text
specs/002-authenticated-dashboard/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── ui-contract.md
└── tasks.md
```

### Source Code (repository root)
```text
lib/features/dashboard/presentation/
├── pages/
│   └── dashboard_page.dart
└── widgets/
    ├── dashboard_header.dart
    ├── dashboard_search_bar.dart
    ├── dashboard_overview_cards.dart
    ├── dashboard_stat_card.dart
    ├── dashboard_spaces_section.dart
    ├── dashboard_space_card.dart
    ├── dashboard_containers_section.dart
    ├── dashboard_container_card.dart
    ├── dashboard_items_section.dart
    ├── dashboard_item_card.dart
    ├── loading/
    │   ├── dashboard_skeleton.dart
    │   ├── stat_card_skeleton.dart
    │   ├── space_card_skeleton.dart
    │   ├── container_card_skeleton.dart
    │   └── item_card_skeleton.dart
    └── empty_states/
        ├── dashboard_empty_state.dart
        └── dashboard_error_view.dart

test/features/dashboard/presentation/
├── pages/
│   └── dashboard_page_test.dart
└── widgets/
    ├── dashboard_header_test.dart
    ├── dashboard_overview_cards_test.dart
    ├── dashboard_search_bar_test.dart
    └── dashboard_skeleton_test.dart
```

**Structure Decision**: Add only a dashboard presentation feature. Existing
DashboardBloc, existing models, existing routing, and existing repositories are
consumed as-is. Any missing backend/dashboard data work is outside this plan and
must not be created here.

## UI Composition Plan

`DashboardPage` renders:

1. `DashboardHeader`
2. `DashboardSearchBar`
3. `DashboardOverviewCards`
4. `DashboardSpacesSection`
5. `DashboardContainersSection`
6. `DashboardItemsSection`

`DashboardPage` listens to existing dashboard states:

- `DashboardLoading` -> `DashboardSkeleton`
- `DashboardLoaded` -> dashboard content
- `DashboardError` -> `DashboardErrorView`

If existing state names differ, adapt only the presentation binding to the
actual existing `DashboardBloc` states; do not introduce a replacement state
manager.

## Animation Plan

- Header: fade in and slight top-to-bottom slide, 300ms.
- Search: fade in and slide upward, 350ms, delayed 100ms after header.
- Overview cards: staggered fade/slide up with 100ms offset.
- Card tap: scale to 0.97 then return to 1.0 over 150ms.
- Section cards: fade/slide from bottom with 50ms stagger for Spaces and
  Containers, 30ms stagger for Items.
- Skeleton to content: fade skeleton out and content in over 250ms.

Use `flutter_animate` where it keeps code concise. Prefer implicit animations
when they are easier to read. Avoid animation controllers unless required.

## Responsive Layout Plan

- Mobile: standard vertical scroll layout.
- Tablet: increased spacing and wider cards.
- Desktop/web: content constrained to 1200px and centered.
- Overview cards remain one row with equal widths.
- All touch targets are at least 48x48.

## Design System Plan

Use both design sources:

- `.specify/design-token.json`: exact colors, typography, spacing, radius,
  shadows, and component sizing.
- `.specify/assets/design-system-v1.jpeg`: visual reference for premium,
  minimalist layout, cards, chips, list density, and spacing feel.

Logo uses `assets/images/logo.png`. If the asset is absent during development,
show an accessible placeholder only in debug/testing; production expects the
asset.

## Testing Plan

Widget tests validate:

- logo-only header and profile button navigation.
- search placeholder and real-time filtering behavior.
- overview cards fit one row and navigate correctly.
- Spaces, Containers, and Items section limits.
- skeleton layout and no blank loading screen.
- loaded/empty/error states.
- semantic labels and 48x48 minimum touch targets.
- desktop max-width constraint.

## Complexity Tracking

No constitution violations.
