# Feature Specification: Unified Node Details Page

**Feature Branch**: `003-unified-node-details`

**Created**: 2026-06-05

**Status**: Draft

**Input**: User description: "Redesign the existing Node Details Page to support all node types in the system (Space, Container, and Item) using a unified, scalable layout."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Any Node in a Unified Details Experience (Priority: P1)

An authenticated user opens a Space, Container, or Item and sees a consistent,
content-focused details page with media at the top, node information in the
middle, and child content organized below.

**Why this priority**: This is the core value of the redesign—one predictable
details experience across all storage node types instead of three divergent
layouts.

**Independent Test**: Open one record of each node type and verify the same page
structure, typography hierarchy, and interaction patterns appear in each case.

**Acceptance Scenarios**:

1. **Given** a Space, Container, or Item exists, **When** the user opens its
   details page, **Then** the page uses the same top-to-bottom structure:
   media carousel, node information, and content tabs.
2. **Given** the node has one or more images, **When** the page loads,
   **Then** the top area shows a swipeable image carousel with page indicators.
3. **Given** the node has no images, **When** the page loads, **Then** the top
   area shows a type-specific placeholder illustration and node-type icon.
4. **Given** node metadata is available, **When** the information section
   renders, **Then** the user sees the node title, type badge, optional
   description, and metadata chips.

---

### User Story 2 - Browse Direct Child Containers and Items (Priority: P1)

An authenticated user reviews only the direct children of the current node
through dedicated Containers and Items tabs.

**Why this priority**: Separating media and metadata from child content is the
main organizational improvement over the current tree-style detail pages.

**Independent Test**: Open a Space or Container with known direct children and
verify each tab lists only immediate children with the correct card content.

**Acceptance Scenarios**:

1. **Given** a Space or Container has direct child containers, **When** the user
   selects the Containers tab, **Then** each card shows container icon, name,
   item count, optional thumbnail, and navigation indicator.
2. **Given** a Space or Container has direct child items, **When** the user
   selects the Items tab, **Then** each card shows thumbnail, name, description
   preview, tags, and last updated date.
3. **Given** the user taps a child card, **When** navigation completes,
   **Then** the unified details page opens for that child node.
4. **Given** an Item node is opened, **When** the tabs section renders,
   **Then** both tabs are available and show contextual empty states because
   Items do not contain child nodes.

---

### User Story 3 - Preview Media in Fullscreen (Priority: P2)

An authenticated user taps a carousel image to inspect it in fullscreen with
zoom support.

**Why this priority**: Media is a primary content type for physical storage
records and needs a focused viewing mode.

**Independent Test**: Open a node with multiple images, tap any image, and
verify fullscreen preview, swipe between images, and pinch-to-zoom behavior.

**Acceptance Scenarios**:

1. **Given** a node has at least one image, **When** the user taps a carousel
   image, **Then** a fullscreen preview opens with a smooth transition from the
   tapped image.
2. **Given** fullscreen preview is open, **When** the user pinches, **Then** the
   image zooms smoothly within usable limits.
3. **Given** multiple images exist, **When** fullscreen preview is open,
   **Then** the user can swipe horizontally between images.
4. **Given** fullscreen preview is open, **When** the user dismisses it,
   **Then** they return to the same scroll position on the details page.

---

### User Story 4 - Recover Gracefully from Loading, Empty, and Error States (Priority: P2)

An authenticated user always receives clear feedback while content loads, when
sections are empty, or when data fails to load.

**Why this priority**: Details pages are high-traffic entry points; unstable
loading behavior undermines trust in the storage system.

**Independent Test**: Simulate initial load, empty child lists, partial data
absence, and failed refresh for each node type.

**Acceptance Scenarios**:

1. **Given** node details are loading, **When** the page first appears,
   **Then** skeleton placeholders appear for the carousel, node information,
   and active tab cards without layout shift.
2. **Given** the Containers tab has no direct children, **When** it is shown,
   **Then** the user sees a friendly illustration, "No containers yet", and a
   contextual create action when permitted.
3. **Given** the Items tab has no direct children, **When** it is shown,
   **Then** the user sees a friendly illustration, "No items yet", and a
   contextual create action when permitted.
4. **Given** existing content is visible, **When** the user pulls to refresh,
   **Then** current content remains visible and a refresh indicator appears
   until updated data is shown or an error is displayed.
5. **Given** node details fail to load, **When** the error state appears,
   **Then** the user sees a friendly message and a retry action.

---

### User Story 5 - Use the Page Comfortably on Any Supported Device (Priority: P3)

An authenticated user can read, navigate, and interact with node details on
small phones, large phones, and tablets with equally strong usability.

**Why this priority**: Storage lookup often happens on mobile devices in varied
screen sizes and orientations.

**Independent Test**: Render the page at phone and tablet breakpoints and verify
readable typography, proportional media, and accessible touch targets.

**Acceptance Scenarios**:

1. **Given** the page is viewed on a small phone, **When** content renders,
   **Then** text remains readable, cards remain tappable, and the carousel
   height scales proportionally without crowding the information section.
2. **Given** the page is viewed on a tablet, **When** content renders,
   **Then** content width is constrained to a comfortable reading width and
   extra horizontal space is used intentionally rather than stretching cards
   awkwardly.
3. **Given** a screen reader is enabled, **When** the user explores the page,
   **Then** all primary actions and content regions have meaningful labels and
   follow a logical focus order.

---

### Edge Cases

- Node exists but all optional fields are missing (no images, description, tags,
  or dates).
- Node has many images (10+) in the carousel.
- Node has many direct children requiring long vertical scrolling in a tab.
- Image fails to load while other images succeed.
- User switches tabs rapidly while child data is still loading.
- User opens details for a deleted or inaccessible node.
- Container has nested descendants but no direct child items.
- Space has direct items but no direct containers.
- Long node title, description, or tag names overflow available space.
- User rotates device while viewing carousel or fullscreen preview.
- Pull-to-refresh is triggered during an in-flight image preview transition.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide one unified details page layout for Space,
  Container, and Item node types.
- **FR-002**: System MUST display a top media area that supports multiple
  images with horizontal swipe and visible page indicators when more than one
  image exists.
- **FR-003**: System MUST open a fullscreen image preview when the user taps a
  carousel image.
- **FR-004**: System MUST support pinch-to-zoom in fullscreen image preview.
- **FR-005**: System MUST show a type-specific placeholder illustration and
  node icon when no images are available.
- **FR-006**: System MUST display node title, node type badge, optional
  description, and metadata chips for created date, updated date, child count,
  and tags when data exists.
- **FR-007**: System MUST provide segmented tab navigation with Containers and
  Items tabs below the node information section.
- **FR-008**: System MUST list only direct child containers in the Containers
  tab and only direct child items in the Items tab.
- **FR-009**: System MUST show container cards with icon, name, item count,
  optional thumbnail, and navigation indicator.
- **FR-010**: System MUST show item cards with thumbnail, name, description
  preview, tags, and last updated date.
- **FR-011**: System MUST provide contextual empty states and create actions for
  both tabs when a node type can contain children.
- **FR-012**: System MUST use a single vertical scroll for the page and MUST
  avoid nested scrolling conflicts between the main page and tab content.
- **FR-013**: System MUST provide skeleton loading states for the carousel, node
  information, and child cards that preserve final layout dimensions.
- **FR-014**: System MUST support pull-to-refresh without hiding already loaded
  content.
- **FR-015**: System MUST preserve the existing ability to navigate into child
  nodes and return without losing expected back-navigation behavior.
- **FR-016**: System MUST retain node-type-specific actions already available in
  current detail flows, including move and create-child actions where applicable.
- **FR-017**: Page architecture MUST allow future tabs such as Activity,
  Attachments, Notes, Relationships, and Audit History without restructuring the
  primary layout regions.

### Quality Requirements

- **QR-001**: Feature MUST define widget, page, and accessibility test coverage
  for loading, loaded, empty, error, and refresh states across all node types.
- **QR-002**: UI MUST follow the Keeply Design System for color, spacing,
  radius, elevation, and typography.
- **QR-003**: All interactive elements MUST meet minimum 48x48 dp touch targets.
- **QR-004**: Text and icon contrast MUST meet WCAG AA for normal text and
  large text in primary content areas.
- **QR-005**: Animations MUST remain subtle, complete within 300 ms for primary
  transitions, and avoid jank during scroll and tab changes.
- **QR-006**: Initial details content MUST become interactively visible within
  2 seconds on a typical mobile network for a node with up to 20 direct children.
- **QR-007**: Lifecycle-owned resources such as image controllers, animation
  controllers, and in-flight data requests MUST be cancelled or guarded on
  navigation away.

### Key Entities *(include if feature involves data)*

- **Storage Node**: A Space, Container, or Item record with identity, name,
  type, optional description, metadata, image collection, timestamps, and parent
  relationship.
- **Node Image**: A media asset attached to a node with display order and
  optional alt text.
- **Node Metadata Chip**: A compact, read-only label derived from node data such
  as created date, updated date, child count, or tags.
- **Child Container Summary**: A direct child container shown in the Containers
  tab with name, item count, and optional thumbnail.
- **Child Item Summary**: A direct child item shown in the Items tab with name,
  description preview, tags, thumbnail, and last updated date.
- **Details Tab State**: The currently selected tab (Containers or Items) and
  its loading, loaded, empty, or error status.

## Page Layout Specification

### Visual Structure

The page is a single vertically scrolling surface with four persistent regions:

```text
┌──────────────────────────────────────┐
│ App Bar (back, title optional, actions)│
├──────────────────────────────────────┤
│ Media Carousel / Placeholder         │
├──────────────────────────────────────┤
│ Node Information Section             │
├──────────────────────────────────────┤
│ Segmented Tabs: [Containers] [Items]   │
├──────────────────────────────────────┤
│ Active Tab Content (cards / empty)     │
└──────────────────────────────────────┘
```

### Component Hierarchy

```text
NodeDetailsPage
├── NodeDetailsAppBar
├── NodeDetailsScrollView
│   ├── NodeMediaCarousel
│   │   ├── CarouselImagePage
│   │   ├── PageIndicator
│   │   └── NodeMediaPlaceholder
│   ├── NodeInformationSection
│   │   ├── NodeTitle
│   │   ├── NodeTypeBadge
│   │   ├── NodeDescription
│   │   └── NodeMetadataChipRow
│   ├── NodeContentTabs
│   │   └── SegmentedTabControl
│   └── NodeTabContent
│       ├── ContainerChildCard (list)
│       ├── ItemChildCard (list)
│       ├── NodeTabEmptyState
│       └── NodeTabErrorState
├── NodeDetailsSkeleton (loading)
├── NodeDetailsErrorView (fatal load failure)
└── FullscreenImagePreview (overlay route)
```

### Spacing and Dimension System

All measurements use Keeply design tokens from `.specify/design-token.json`.

| Element | Rule |
| -------- | ---- |
| Page horizontal padding | `spacing.lg` (24) on phones; `spacing.xl` (32) on tablets |
| Max content width | 720 dp on tablet/desktop-width layouts |
| Carousel height | 40% of viewport width, clamped between 220 dp and 360 dp |
| Carousel corner radius | `radius.lg` (24) where media meets page background |
| Information section top spacing | `spacing.lg` (24) below carousel |
| Title style | `h2` typography token |
| Description style | `bodyLarge` typography token |
| Metadata chip height | `components.chip.height` (32) |
| Metadata chip radius | `components.chip.radius` (pill) |
| Tab section top spacing | `spacing.xl` (32) below information section |
| Segmented control height | 44 dp minimum |
| Card radius | `components.card.radius` (20) |
| Card padding | `components.card.padding` (16) |
| Card vertical gap | `spacing.md` (16) |
| Card elevation | `elevation.card` soft shadow |
| Empty state vertical padding | `spacing.xxl` (48) |
| Touch target minimum | 48 x 48 dp |

### Node Type Presentation

| Node Type | Badge Label | Placeholder Icon | Default Empty-State CTA |
| --------- | ----------- | ---------------- | ----------------------- |
| Space | Space | Home / space icon | Add Container, Add Item |
| Container | Container | Box / container icon | Add Container, Add Item |
| Item | Item | Tag / item icon | None for child tabs |

## Interaction & Animation Specification

| Interaction | Behavior | Duration / Curve |
| ----------- | -------- | ---------------- |
| Page entry | Content fades in from 0 to 100% opacity | 250 ms, ease-out |
| Carousel swipe | Standard horizontal page snapping | System default |
| Image tap | Shared transition into fullscreen preview | 250 ms, ease-in-out |
| Fullscreen dismiss | Reverse shared transition back to carousel | 250 ms, ease-in-out |
| Tab change | Cross-fade active tab content | 200 ms, ease-out |
| Card press | Scale to 0.98 with soft highlight | 120 ms, ease-out |
| Pull-to-refresh | Native refresh indicator at top of scroll view | System default |
| Skeleton to content | Cross-fade loaded content over skeleton | 200 ms, ease-out |

Animations MUST not block scrolling or tab switching. Only one primary motion
should run at a time per user action.

## Loading State Specification

| Region | Skeleton Content | Fixed Size Rule |
| ------ | ---------------- | --------------- |
| Carousel | Rounded rectangle shimmer | Matches final carousel height |
| Node title | 70% width bar | Matches `h2` line height |
| Type badge | 96 dp pill | Matches badge height |
| Description | Two 100% width lines | Two `bodyLarge` lines |
| Metadata chips | Three pill shimmers | Chip height 32 dp |
| Tab cards | 3 card shimmers per tab | Match final card height |

Rules:

- Skeletons MUST appear in the same positions as final content.
- Skeletons MUST not cause vertical layout jump when replaced by loaded content.
- If child data loads after node header data, the header MUST render while tab
  cards continue skeleton loading.
- Fatal page load failure replaces the scroll content with a full-page error
  view and retry action.

## Empty State Specification

### Containers Tab

- Illustration: friendly box/container motif using primary light tones
- Title: "No containers yet"
- Message: "Create a container to organize items inside this [space/container]."
- Primary CTA: "Add Container" when node type is Space or Container
- Secondary CTA: none

### Items Tab

- Illustration: friendly item/tag motif using primary light tones
- Title: "No items yet"
- Message: "Add an item to start tracking what is stored here."
- Primary CTA: "Add Item" when node type is Space or Container
- Secondary CTA: none

### Item Node Tabs

- Both tabs remain visible for layout consistency.
- Each tab uses the same empty-state pattern with Item-specific copy:
  "Items do not contain child containers/items."

## Responsive Behavior Rules

| Breakpoint | Width Range | Behavior |
| ---------- | ----------- | -------- |
| Small phone | < 360 dp | Full-bleed carousel, single-column cards, 24 dp side padding |
| Large phone | 360–599 dp | Same as small phone with slightly taller carousel clamp |
| Tablet | ≥ 600 dp | Centered content column, max width 720 dp, 32 dp side padding |

Additional rules:

- Carousel image uses cover fit and preserves aspect ratio without distortion.
- Metadata chips wrap to multiple lines before truncating chip text.
- Card thumbnails maintain 1:1 ratio at 56 dp on phones and 64 dp on tablets.
- Fullscreen preview uses device-safe areas and supports portrait and landscape.

## Accessibility Considerations

- Media carousel MUST expose "Image X of Y" semantics and support swipe actions
  with screen reader announcements.
- Placeholder media MUST announce node type and "No photos added".
- Type badge MUST be included in the screen reader summary for the node.
- Tabs MUST use tab semantics with selected-state announcements.
- Child cards MUST have combined labels including name, type, and key metadata.
- Empty-state CTAs MUST be reachable in logical order after tab content.
- All text MUST respect system text scaling up to 200% without clipping primary
  title or tab labels.
- Color MUST not be the only indicator of node type; badge includes text label.
- Fullscreen preview MUST provide an accessible close action and zoom feedback.

## Future Expansion

The tab region MUST be implemented as an extensible tab model so future tabs can
be added without moving the media or information sections.

Future tabs planned for later phases:

- Activity
- Attachments
- Notes
- Relationships
- Audit History

Adding a future tab MUST NOT require redesign of the carousel or node
information layout.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of test participants can identify a node's type, name, and
  child location within 5 seconds of opening the details page.
- **SC-002**: Users can open a child node from either tab in no more than 2 taps
  from the details page.
- **SC-003**: Initial page skeleton appears within 300 ms and stable loaded
  content replaces skeletons without visible layout jump in 95% of test runs.
- **SC-004**: Pull-to-refresh completes visual feedback within 1 second on
  cached data and within 3 seconds on typical mobile network conditions.
- **SC-005**: Fullscreen image preview opens and closes without losing the
  user's scroll position in 100% of tested navigation flows.
- **SC-006**: All primary actions pass accessibility audit for labels, contrast,
  and touch target size across phone and tablet breakpoints.
- **SC-007**: Support requests related to "finding items inside a space" decrease
  by 30% within 60 days of release compared to the pre-redesign baseline.

## Assumptions

- Authenticated users already have permission to view the node they open.
- Existing storage APIs provide node identity, type, name, parent relationship,
  direct children, image list, timestamps, and optional metadata needed for
  description and tags.
- Image upload management happens outside this page in existing create/edit
  flows; this page is primarily for viewing and navigation.
- "Child count" metadata chip refers to the total number of direct child
  containers plus direct child items.
- Description and tags are sourced from existing node metadata fields when
  present; when absent, those UI elements are hidden rather than shown empty.
- Move, edit, delete, and create-child actions reuse existing product flows and
  permissions.
- The current separate Space, Container, and Item detail routes will be
  replaced by or mapped to this unified experience during implementation
  planning.
- Keeply Design System tokens in `.specify/design-token.json` and visual
  references in `.specify/assets/design-system-v1.jpeg` are the source of truth
  for styling.

## Dependencies

- Existing authenticated routing and storage repository data for node trees and
  node detail retrieval.
- Existing create, move, and delete flows for Spaces, Containers, and Items.
- Shared Keeply UI primitives for buttons, chips, cards, empty states, and
  error states.
- Image caching and network image loading capability for carousel and card
  thumbnails.

## Engineering Notes *(Planning Input)*

This section captures implementation guidance explicitly requested for the
`/speckit-plan` phase. It does not change user-facing requirements.

### Recommended Flutter Architecture

- Replace the three separate detail page implementations with one
  `NodeDetailsPage` parameterized by node ID and resolved node type.
- Use a dedicated `NodeDetailsCubit` or `NodeDetailsBloc` exposing states:
  `loading`, `loaded`, `refreshing`, `error`.
- Load node header data and direct children in one view model:
  `NodeDetailsViewData`.
- Keep fullscreen preview in a separate route or overlay widget to isolate zoom
  controllers and avoid rebuild churn in the main scroll view.
- Reuse existing storage repository methods where possible; add a focused query
  for direct children and image ordering if the current tree response is too heavy.
- Apply `AutomaticKeepAliveClientMixin` or equivalent tab state preservation so
  switching tabs does not refetch data unnecessarily.
- Guard async emits and animation callbacks with lifecycle checks when leaving
  the page during load.

### Suggested File Organization

```text
lib/features/storage/presentation/
  pages/node_details_page.dart
  cubit/node_details_cubit.dart
  widgets/node_details/
    node_media_carousel.dart
    node_information_section.dart
    node_content_tabs.dart
    container_child_card.dart
    item_child_card.dart
    node_details_skeleton.dart
    node_tab_empty_state.dart
    fullscreen_image_preview.dart
```

### Testing Recommendations

- Widget tests for each node type in loading, loaded, empty, and error states.
- Golden tests for carousel placeholder, information section, and both tab cards.
- Navigation tests for child card taps and fullscreen preview open/close.
- Accessibility tests for tab semantics and carousel announcements.
