import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/container/presentation/container_details_delegate.dart';
import 'package:keeply/features/item/presentation/item_details_delegate.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_details_cubit.dart';
import 'package:keeply/features/node_details/presentation/pages/node_details_page.dart';
import 'package:keeply/features/space/presentation/space_details_delegate.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

import '../node_details_test_helpers.dart';

void main() {
  setUp(() async {
    await sl.reset();
    sl
      ..registerFactory<NodeDetailsCubit>(
        () => NodeDetailsCubit(FakeNodeDetailsRepository()),
      )
      ..registerLazySingleton<SpaceDetailsDelegate>(
        () => SpaceDetailsDelegate(),
      )
      ..registerLazySingleton<ContainerDetailsDelegate>(
        () => ContainerDetailsDelegate(),
      )
      ..registerLazySingleton<ItemDetailsDelegate>(() => ItemDetailsDelegate());
  });

  tearDown(sl.reset);

  testWidgets('shows skeleton then loaded content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const NodeDetailsPage(
          nodeId: 'space-1',
          nodeType: NodeType.space,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Test Node'), findsWidgets);
    expect(find.text('Containers'), findsWidgets);
    expect(find.text('Items'), findsWidgets);
  });
}
