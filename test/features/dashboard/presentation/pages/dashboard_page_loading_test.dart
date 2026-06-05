import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton.dart';

import 'dashboard_page_test_helpers.dart';

void main() {
  testWidgets('shows skeleton while dashboard loads', (tester) async {
    await pumpDashboardPage(
      tester,
      FakeDashboardRepository(neverComplete: true),
    );

    expect(find.byType(DashboardSkeleton), findsOneWidget);
  });
}
