import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_spaces_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows spaces empty state', (tester) async {
    await pumpDashboardWidget(
      tester,
      DashboardSpacesSection(
        spaces: const [],
        onOpenSpace: (_) {},
        onShowAll: () {},
        onCreateSpace: () {},
      ),
    );

    expect(find.textContaining('No Spaces yet'), findsOneWidget);
  });
}
