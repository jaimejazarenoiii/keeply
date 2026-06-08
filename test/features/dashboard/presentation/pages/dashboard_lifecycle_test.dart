import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/pages/dashboard_page.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('does not throw when dashboard is disposed during load', (
    tester,
  ) async {
    await pumpDashboardPage(
      tester,
      FakeDashboardRepository(neverComplete: true),
    );
    await tester.pump();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('can rebuild dashboard after dispose during load', (
    tester,
  ) async {
    await pumpDashboardPage(
      tester,
      FakeDashboardRepository(neverComplete: true),
    );
    await tester.pump();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    await pumpDashboardPage(tester, FakeDashboardRepository());
    await tester.pumpAndSettle();

    expect(find.text('Garage'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
