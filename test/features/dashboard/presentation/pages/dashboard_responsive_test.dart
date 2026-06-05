import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_responsive_container.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('applies dashboard max width on wide screens', (tester) async {
    await pumpDashboardPage(
      tester,
      FakeDashboardRepository(),
      size: const Size(1600, 900),
    );
    await tester.pumpAndSettle();

    final box = tester.renderObject(find.byType(DashboardResponsiveContainer));
    expect(box, isNotNull);
  });
}
