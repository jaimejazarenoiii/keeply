import 'package:flutter_test/flutter_test.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('renders loaded dashboard content', (tester) async {
    await pumpDashboardPage(tester, FakeDashboardRepository());
    await tester.pumpAndSettle();

    expect(find.text('Garage'), findsWidgets);
    expect(find.text('Cable Bin'), findsWidgets);
  });
}
