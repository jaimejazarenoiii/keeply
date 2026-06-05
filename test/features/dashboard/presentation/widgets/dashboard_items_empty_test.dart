import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_items_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows items empty state', (tester) async {
    await pumpDashboardWidget(
      tester,
      DashboardItemsSection(
        items: const [],
        onOpenItem: (_) {},
        onShowAll: () {},
        onCreateSpace: () {},
      ),
    );

    expect(find.textContaining('No Items yet'), findsOneWidget);
  });
}
