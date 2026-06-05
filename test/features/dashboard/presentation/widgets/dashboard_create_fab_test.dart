import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_create_fab.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('expands create options and triggers callbacks', (tester) async {
    var createdSpace = false;
    var createdContainer = false;
    var createdItem = false;

    await pumpDashboardWidget(
      tester,
      Align(
        alignment: Alignment.bottomRight,
        child: DashboardCreateFab(
          onOpenChanged: (_) {},
          onCreateSpace: () => createdSpace = true,
          onCreateContainer: () => createdContainer = true,
          onCreateItem: () => createdItem = true,
        ),
      ),
    );

    expect(find.byIcon(Icons.layers_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.layers_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Create Space'), findsOneWidget);
    expect(find.text('Create Container'), findsOneWidget);
    expect(find.text('Create Item'), findsOneWidget);

    await tester.tap(find.text('Create Item'));
    await tester.pumpAndSettle();

    expect(createdItem, isTrue);
    expect(createdSpace, isFalse);
    expect(createdContainer, isFalse);
  });
}
