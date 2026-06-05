import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_items_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders empty state when section has no content', (
    tester,
  ) async {
    await pumpDashboardWidget(
      tester,
      DashboardItemsSection(
        items: const [],
        onOpenItem: (_) {},
        onShowAll: () {},
        onCreateSpace: () {},
      ),
    );
    expect(find.textContaining('No Items yet'), findsOneWidget);
  });

  testWidgets('limits items and shows all action', (tester) async {
    final items = [
      for (var i = 0; i < 11; i++)
        DashboardItem(
          id: 'item-$i',
          name: 'Item $i',
          containerId: 'container-1',
          containerName: 'Bin',
          spaceId: 'space-1',
          spaceName: 'Garage',
        ),
    ];
    var showAllTapped = false;
    await pumpDashboardWidget(
      tester,
      SingleChildScrollView(
        child: DashboardItemsSection(
          items: items,
          onOpenItem: (_) {},
          onShowAll: () => showAllTapped = true,
          onCreateSpace: () {},
        ),
      ),
    );
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 10'), findsNothing);
    await tester.ensureVisible(find.text('Show all Items'));
    await tester.tap(find.text('Show all Items'));
    expect(showAllTapped, isTrue);
  });
}
