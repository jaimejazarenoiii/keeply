# Data Model: Authenticated User Dashboard

## Scope

This feature consumes existing dashboard state and existing models. The names
below describe the UI-facing data shape expected by the dashboard widgets; they
do not require new repositories, services, or backend endpoints.

## Dashboard View State

### DashboardLoading

Represents initial dashboard loading.

UI behavior:

- Render `DashboardSkeleton`.
- Do not render blank space.
- Keep skeleton dimensions aligned with final dashboard content.

### DashboardLoaded

Represents dashboard content ready for display.

Fields expected by UI:

- `totalSpaces`: total number of Spaces.
- `totalContainers`: total number of Containers.
- `totalItems`: total number of Items.
- `latestSpaces`: maximum 5 dashboard Space entries.
- `latestContainers`: maximum 5 dashboard Container entries.
- `latestItems`: maximum 10 dashboard Item entries.

UI behavior:

- Render header, search, overview, and all sections.
- Render section empty states when a latest list is empty.
- Keep pull-to-refresh content visible during refresh.

### DashboardError

Represents dashboard-level failure.

Fields expected by UI:

- user-facing message.
- retry action from existing `DashboardBloc`.

UI behavior:

- Render friendly icon/illustration.
- Render retry button.
- Fade in error view.

## Dashboard Space Entry

Fields:

- `id`: Space id.
- `name`: Space display name.
- `containerCount`: number of Containers in the Space.
- `itemCount`: number of Items in the Space.

Validation:

- Display at most 5 entries.
- Tapping opens Space details.

## Dashboard Container Entry

Fields:

- `id`: Container id.
- `name`: Container display name.
- `spaceId`: parent Space id.
- `spaceName`: parent Space display name.
- `itemCount`: number of Items in the Container.

Validation:

- Display at most 5 entries.
- Tapping opens Container details.

## Dashboard Item Entry

Fields:

- `id`: Item id.
- `name`: Item display name.
- `containerId`: parent Container id when available.
- `containerName`: parent Container display name when available.
- `spaceId`: parent Space id.
- `spaceName`: parent Space display name.

Validation:

- Display at most 10 entries.
- Tapping opens Item details.

## Search Result

Derived locally from loaded dashboard data.

Fields:

- `id`: matching record id.
- `type`: Space, Container, or Item.
- `title`: display name.
- `subtitle`: parent/location summary.

Validation:

- Search is case-insensitive.
- Results update in real time.
- No-match state is friendly and non-blocking.

## Animation State

Dashboard widgets use entrance animations based on their position:

- Header: index 0, 300ms.
- Search: index 1, 350ms, delayed 100ms.
- Overview cards: indexes 0-2, staggered by 100ms.
- Space/Container cards: staggered by 50ms.
- Item cards: staggered by 30ms.

No widget should own long-lived animation controllers unless required.
