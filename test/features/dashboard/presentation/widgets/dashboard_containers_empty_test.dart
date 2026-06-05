import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_containers_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('shows containers empty state', (tester) async {
    await pumpDashboardWidget(
      tester,
      DashboardContainersSection(
        containers: const [],
        onOpenContainer: (_) {},
        onShowAll: () {},
        onCreateSpace: () {},
      ),
    );

    expect(find.textContaining('No Containers yet'), findsOneWidget);
  });
}
