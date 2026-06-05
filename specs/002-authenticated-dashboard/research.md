# Research: Authenticated User Dashboard

## Decision: UI-Only Dashboard Feature

**Decision**: Implement this feature only in the dashboard presentation layer.
Use existing `DashboardBloc`, existing app routing, existing data models, and
existing repositories.

**Rationale**: The user's planning request explicitly forbids new architecture,
repositories, services, API endpoints, and backend work. Keeping the feature
presentation-only reduces risk and preserves the current BLoC architecture.

**Alternatives considered**: Creating a dedicated dashboard repository or API
client was rejected because it violates the requested scope. Reworking storage
repositories was rejected because this feature is about the dashboard UI.

## Decision: Use `flutter_animate` for Short, Staggered Effects

**Decision**: Add `flutter_animate` for fade, move, and scale effects in
dashboard widgets.

**Rationale**: The feature requires multiple polished, staggered animations.
`flutter_animate` keeps these effects readable and avoids custom animation
controller boilerplate.

**Alternatives considered**: Manual `AnimationController` usage was rejected
because it increases lifecycle complexity. Pure implicit animations remain
acceptable for simple transitions where they are clearer.

## Decision: Match Skeleton Layout to Final Layout

**Decision**: Build dedicated skeleton widgets for header, search, overview
cards, and each list card type.

**Rationale**: Dedicated skeleton widgets make it easier to match dimensions and
avoid layout jumps when content loads.

**Alternatives considered**: A generic rectangular skeleton list was rejected
because it would not guarantee matching layout and would feel less premium.

## Decision: Keep Sections Independently Renderable

**Decision**: Dashboard sections should render independently using the existing
dashboard state data, with section-specific empty/error presentation where the
state supports it.

**Rationale**: The spec requires partial loading and section-level errors when
possible. Even if the initial existing `DashboardBloc` exposes a single loaded
state, the UI should be structured so sections can evolve independently without
rewriting the page.

**Alternatives considered**: A single monolithic dashboard widget was rejected
because it would be hard to test and would make partial states difficult.

## Decision: Local Search Over Loaded Dashboard Data

**Decision**: Implement dashboard search as local filtering across loaded
dashboard data unless an existing search flow is already available.

**Rationale**: The planning request forbids new APIs or services. Local
filtering satisfies real-time search for currently loaded dashboard content and
can later delegate to an existing dedicated search route if available.

**Alternatives considered**: Adding a backend search endpoint or service was
rejected because backend/API work is out of scope.

## Decision: Responsive Centered Content with 1200px Max Width

**Decision**: Use a centered dashboard content container with max width 1200px
on desktop and standard full-width layout on mobile.

**Rationale**: This keeps the page premium and readable across Chrome/web,
tablet, and mobile without creating separate layouts.

**Alternatives considered**: Completely separate desktop widgets were rejected
because the feature scope does not require divergent experiences.
