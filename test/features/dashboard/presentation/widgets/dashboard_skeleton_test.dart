import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/dashboard_skeleton.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets(
    'renders skeleton placeholders without leaking ticker controllers',
    (tester) async {
      await pumpDashboardWidget(tester, const DashboardSkeleton());
      await tester.pump(const Duration(milliseconds: 16));

      expect(find.byType(DashboardSkeleton), findsOneWidget);
    },
  );
}
