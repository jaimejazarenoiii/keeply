import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_containers_section.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders empty state when section has no content', (
    tester,
  ) async {
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

  testWidgets('limits containers and shows all action', (tester) async {
    final containers = [
      for (var i = 0; i < 6; i++)
        DashboardContainer(
          id: 'container-$i',
          name: 'Container $i',
          spaceId: 'space-1',
          spaceName: 'Garage',
          itemCount: 0,
        ),
    ];
    var showAllTapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardContainersSection(
        containers: containers,
        onOpenContainer: (_) {},
        onShowAll: () => showAllTapped = true,
        onCreateSpace: () {},
      ),
    );
    expect(find.text('Container 0'), findsOneWidget);
    expect(find.text('Container 5'), findsNothing);
    await tester.tap(find.text('Show all Containers'));
    expect(showAllTapped, isTrue);
  });
}
