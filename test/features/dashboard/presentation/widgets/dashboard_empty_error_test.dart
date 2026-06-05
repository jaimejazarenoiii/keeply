import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_empty_state.dart';
import 'package:keeply/features/dashboard/presentation/widgets/empty_states/dashboard_error_view.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('empty state exposes message and action', (tester) async {
    var tapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardEmptyState(
        message: 'Create your first Space to start organizing your things.',
        actionLabel: 'Create Space',
        onAction: () => tapped = true,
      ),
    );

    await tester.tap(find.text('Create Space'));
    expect(tapped, isTrue);
  });

  testWidgets('error state exposes retry action', (tester) async {
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
