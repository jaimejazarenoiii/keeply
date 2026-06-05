import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_search_prompt.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows headline and search button', (tester) async {
    var tapped = false;

    await pumpDashboardWidget(
      tester,
      DashboardSearchPrompt(onSearchTap: () => tapped = true),
    );

    expect(
      find.text(DashboardSearchPrompt.headline),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.search), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
