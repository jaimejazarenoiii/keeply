import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_stat_card.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('scales and triggers callback on tap', (tester) async {
    var tapped = false;
    await pumpDashboardWidget(
      tester,
      DashboardStatCard(
        icon: Icons.home_work_outlined,
        count: 3,
        label: 'Spaces',
        onTap: () => tapped = true,
      ),
    );

    await tester.tap(find.text('Spaces'));
    expect(tapped, isTrue);
  });
}
