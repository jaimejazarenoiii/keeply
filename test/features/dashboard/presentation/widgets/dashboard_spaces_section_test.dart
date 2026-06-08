import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_spaces_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders empty state when section has no content', (
    tester,
  ) async {
    var actionTapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardSpacesSection(
        spaces: const [],
        onOpenSpace: (_) {},
        onShowAll: () {},
        onCreateSpace: () => actionTapped = true,
      ),
    );

    expect(find.textContaining('No Spaces yet'), findsOneWidget);
    await tester.tap(find.text('Create Space'));
    expect(actionTapped, isTrue);
  });

  testWidgets('limits spaces and shows all action', (tester) async {
    final spaces = [
      for (var i = 0; i < 6; i++)
        DashboardSpace(
          id: 'space-$i',
          name: 'Space $i',
          containerCount: 0,
          itemCount: 0,
        ),
    ];
    var showAllTapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardSpacesSection(
        spaces: spaces,
        onOpenSpace: (_) {},
        onShowAll: () => showAllTapped = true,
        onCreateSpace: () {},
      ),
      size: const Size(1600, 800),
    );

    expect(find.text('Space 0'), findsOneWidget);
    expect(find.text('Space 5'), findsNothing);
    expect(find.text('Add Space'), findsOneWidget);
    await tester.tap(find.text('Show all Spaces'));
    expect(showAllTapped, isTrue);
  });
}
