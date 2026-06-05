import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('renders show all actions for dashboard sections', (
    tester,
  ) async {
    await pumpDashboardPage(
      tester,
      FakeDashboardRepository(),
      size: const Size(800, 1400),
    );
    await tester.pumpAndSettle();

    expect(find.text('Show all Spaces'), findsOneWidget);
    expect(find.text('Show all Containers'), findsOneWidget);
    expect(find.text('Show all Items'), findsOneWidget);
  });
}
