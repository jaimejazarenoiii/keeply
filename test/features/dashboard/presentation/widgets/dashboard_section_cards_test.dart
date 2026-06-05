import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_container_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_item_card.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_space_card.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders recent dashboard cards with labels', (tester) async {
    await pumpDashboardWidget(
      tester,
      Column(
        children: [
          DashboardSpaceCard(
            space: const DashboardSpace(
              id: 'space-1',
              name: 'Garage',
              containerCount: 1,
              itemCount: 2,
            ),
            onTap: () {},
          ),
          DashboardContainerCard(
            container: const DashboardContainer(
              id: 'container-1',
              name: 'Shelf A',
              spaceId: 'space-1',
              spaceName: 'Garage',
              itemCount: 2,
            ),
            onTap: () {},
          ),
          DashboardItemCard(
            item: const DashboardItem(
              id: 'item-1',
              name: 'Extension Cord',
              containerId: 'container-1',
              containerName: 'Shelf A',
              spaceId: 'space-1',
              spaceName: 'Garage',
            ),
            onTap: () {},
          ),
        ],
      ),
    );

    expect(find.text('Garage'), findsWidgets);
    expect(find.text('Shelf A'), findsWidgets);
    expect(find.text('Extension Cord'), findsOneWidget);
  });
}
