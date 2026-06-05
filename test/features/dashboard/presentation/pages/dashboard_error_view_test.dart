import 'package:flutter_test/flutter_test.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('shows retryable error when loading fails', (tester) async {
    await pumpDashboardPage(tester, FakeDashboardRepository(shouldThrow: true));
    await tester.pumpAndSettle();

    expect(
      find.text('Unable to load dashboard. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });
}
