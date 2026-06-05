import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('renders profile entry point on dashboard', (tester) async {
    await pumpDashboardPage(tester, FakeDashboardRepository());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });
}
