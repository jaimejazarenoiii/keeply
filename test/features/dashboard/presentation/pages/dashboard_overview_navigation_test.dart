import 'package:flutter_test/flutter_test.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('renders overview cards with navigation labels', (tester) async {
    await pumpDashboardPage(tester, FakeDashboardRepository());
    await tester.pumpAndSettle();

    expect(find.text('Spaces'), findsOneWidget);
    expect(find.text('Containers'), findsOneWidget);
    expect(find.text('Items'), findsOneWidget);
  });
}
