# UI Contract: Authenticated User Dashboard

## Page Contract

`DashboardPage` consumes existing `DashboardBloc` and renders one of:

- `DashboardSkeleton` for loading.
- Dashboard content for loaded.
- `DashboardErrorView` for error.

The page must not create new repositories, services, API clients, or state
management architecture.

## Widget Contract

### DashboardHeader

- Left: `assets/images/logo.png`.
- Right: one profile avatar/icon button.
- No app name text.
- No settings icon.
- No notifications icon.
- Profile tap navigates to Profile & Settings.
- Entrance animation: fade + slight top slide, 300ms.
- Semantic label: "Open profile and settings".

### DashboardSearchBar

- Full width.
- Rounded elevated surface.
- Search icon on the left.
- Placeholder: "Search spaces, containers, or items".
- Entrance animation: fade + slide up, 350ms, 100ms delay.
- Emits query changes for real-time local filtering or existing search route.

### DashboardOverviewCards

- Three equal-width cards in one row.
- Cards: Spaces, Containers, Items.
- Each card shows icon, count, and label.
- Card tap navigates to matching full page.
- Entrance animation: 100ms stagger.
- Tap feedback: scale to 0.97 and return over 150ms.

### DashboardSpacesSection

- Header row: "Spaces" + "Show All".
- Shows at most 5 latest Spaces.
- Empty message: "Create your first Space".
- Card tap opens Space details.
- Show All opens Spaces page.

### DashboardContainersSection

- Header row: "Containers" + "Show All".
- Shows at most 5 latest Containers.
- Empty message: "Create your first Container".
- Card tap opens Container details.
- Show All opens Containers page.

### DashboardItemsSection

- Header row: "Items" + "Show All".
- Shows at most 10 latest Items.
- Empty message: "Create your first Item".
- Card tap opens Item details.
- Show All opens Items page.

## Skeleton Contract

`DashboardSkeleton` includes:

- Header skeleton with logo placeholder and circular avatar placeholder.
- Search skeleton.
- Three overview skeleton cards.
- Five Space skeleton cards.
- Five Container skeleton cards.
- Ten Item skeleton cards.

Skeletons must:

- Match final layout dimensions.
- Use shimmer left-to-right.
- Run between 1200ms and 1800ms.
- Support light and dark mode.
- Avoid layout shift when content appears.

## Error Contract

`DashboardErrorView` includes:

- Friendly icon or illustration.
- User-friendly message.
- Retry button.
- Fade-in animation.

## Responsive Contract

- Mobile: vertical layout, standard spacing.
- Tablet: increased spacing and comfortable card widths.
- Desktop/web: centered content constrained to 1200px.
- Overview cards remain one row.

## Accessibility Contract

- Profile button, search field, overview cards, section cards, Show All buttons,
  and retry buttons have semantic labels.
- Tap targets are at least 48x48.
- Text supports system text scaling.
- Motion remains short and non-disruptive.
