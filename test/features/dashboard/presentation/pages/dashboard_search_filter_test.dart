import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_search_prompt.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('shows search prompt on loaded dashboard', (tester) async {
    await pumpDashboardPage(tester, FakeDashboardRepository());
    await tester.pumpAndSettle();

    expect(
      find.text(DashboardSearchPrompt.headline),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });
}
