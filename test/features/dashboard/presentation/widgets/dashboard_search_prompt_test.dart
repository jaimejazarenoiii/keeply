import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_search_prompt.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows search headline', (tester) async {
    await pumpDashboardWidget(tester, const DashboardSearchPrompt());

    expect(
      find.text(DashboardSearchPrompt.headline),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.search), findsNothing);
  });
}
