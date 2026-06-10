# Quickstart: Unified Node Details Page

## Prerequisites

- Branch `003-unified-node-details` checked out
- Authenticated app shell running
- Existing `StorageRepository` and API access
- Dashboard redesign complete (visual reference)
- Design sources:
  - `.specify/design-token.json`
  - `.specify/assets/design-system-v1.jpeg`
- Placeholder assets:
  - `assets/images/space_placeholder.jpg` (existing)

## Dependencies

```bash
flutter pub add cached_network_image
flutter pub add photo_view
```

`flutter_animate` is already in the project.

## Service Locator Registrations (expected)

```dart
// node_details
..registerLazySingleton<NodeDetailsRepository>(
  () => NodeDetailsRepositoryImpl(sl<StorageRepository>()),
)
..registerFactory<NodeDetailsCubit>(
  () => NodeDetailsCubit(sl<NodeDetailsRepository>()),
)
..registerFactory<NodeExplorerCubit>(
  () => NodeExplorerCubit(sl<NodeDetailsRepository>()),
)

// delegates
..registerLazySingleton<SpaceDetailsDelegate>(() => SpaceDetailsDelegate())
..registerLazySingleton<ContainerDetailsDelegate>(() => ContainerDetailsDelegate())
..registerLazySingleton<ItemDetailsDelegate>(() => ItemDetailsDelegate())
```

## Router Additions (expected)

```dart
GoRoute(
  path: '/nodes/:nodeType/:nodeId',
  builder: (context, state) => NodeDetailsPage(
    nodeId: state.pathParameters['nodeId']!,
    nodeType: nodeTypeFromPath(state.pathParameters['nodeType']!),
  ),
  routes: [
    GoRoute(
      path: 'explorer/:explorerType',
      builder: (context, state) => NodeExplorerPage(
        parentNodeId: state.pathParameters['nodeId']!,
        parentNodeType: nodeTypeFromPath(state.pathParameters['nodeType']!),
        explorerType: explorerTypeFromPath(state.pathParameters['explorerType']!),
        initialQuery: state.uri.queryParameters['q'],
      ),
    ),
  ],
),
```

## Development Order

1. Domain entities + `NodeDetailsRepository` with unit tests
2. `NodeDetailsCubit` + skeleton page
3. Delegates for space/container/item
4. Section widgets (carousel → metadata → stats → previews)
5. Explorer cubit + page
6. Fullscreen preview
7. Route migration + delete legacy pages

## Manual Validation

### Space

1. Open a Space from dashboard or spaces list.
2. Confirm carousel, metadata, statistics, container preview, item preview.
3. Tap a child container → opens unified details.
4. Tap "View All Items" → explorer with search and Show More.
5. Pull to refresh — content stays visible.
6. FAB → create container or item.

### Container

1. Open a Container with nested children.
2. Confirm only direct children appear in previews (not grandchildren).
3. FAB → create child container or item.
4. Move action available in app bar.

### Item

1. Open an Item.
2. Confirm no FAB create menu (future attachment/note placeholders ok).
3. Preview sections show explanatory empty states.
4. Breadcrumb/path replaced by metadata section parent context.

### Media

1. Node with images → swipe carousel, worm indicator.
2. Tap image → fullscreen, pinch zoom, swipe between images.
3. Node without images → placeholder illustration.

### Accessibility

1. Enable TalkBack/VoiceOver.
2. Verify carousel, tabs, cards, FAB, and search labels.

## Test Commands

```bash
dart format .
flutter analyze
flutter test test/features/node_details
```

## Key Files (expected after implementation)

```text
lib/features/node_details/presentation/pages/node_details_page.dart
lib/features/node_details/presentation/pages/node_explorer_page.dart
lib/features/node_details/presentation/cubit/node_details_cubit.dart
lib/features/space/presentation/space_details_delegate.dart
lib/features/container/presentation/container_details_delegate.dart
lib/features/item/presentation/item_details_delegate.dart
```

## Troubleshooting

| Issue | Check |
| ----- | ----- |
| Nested scroll overflow | Ensure single `CustomScrollView`, no inner `ListView` with shrinkWrap |
| Images flash on rebuild | Use `BlocSelector` on image list only |
| Crash on navigate back | Guard cubit `emit` with `isClosed` + generation counter |
| Explorer shows grandchildren | Verify direct-child filter in repository |
| Layout jump on load | Skeleton heights must match ui-contract dimensions |
