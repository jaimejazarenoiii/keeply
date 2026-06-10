import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_header.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders logo, search, and profile entry points', (tester) async {
    var searchTapped = false;

    await pumpDashboardWidget(
      tester,
      DashboardHeader(onSearchTap: () => searchTapped = true),
    );

    expect(find.bySemanticsLabel('Keeply logo'), findsOneWidget);
    expect(find.bySemanticsLabel('Search stored items'), findsOneWidget);
    expect(find.bySemanticsLabel('Open profile and settings'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    expect(searchTapped, isTrue);
  });
}
