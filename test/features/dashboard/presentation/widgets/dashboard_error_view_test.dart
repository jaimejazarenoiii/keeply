import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_error_view.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows retryable dashboard error view', (tester) async {
    var retried = false;
    await pumpDashboardWidget(
      tester,
      DashboardErrorView(
        message: 'Unable to load dashboard.',
        onRetry: () => retried = true,
      ),
    );

    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });
}
