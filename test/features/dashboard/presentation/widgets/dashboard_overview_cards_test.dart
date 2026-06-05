import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_overview_cards.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders three counts in one overview row', (tester) async {
    var spacesTapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardOverviewCards(
        summary: const DashboardSummary(
          totalSpaces: 2,
          totalContainers: 3,
          totalItems: 4,
          latestSpaces: [],
          latestContainers: [],
          latestItems: [],
        ),
        onSpacesTap: () => spacesTapped = true,
        onContainersTap: () {},
        onItemsTap: () {},
      ),
    );

    expect(find.text('2'), findsOneWidget);
    expect(find.text('Spaces'), findsOneWidget);
    await tester.tap(find.text('Spaces'));
    expect(spacesTapped, isTrue);
  });
}
