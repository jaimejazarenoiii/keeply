import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_responsive_container.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('caps dashboard content at desktop max width', (tester) async {
    await pumpDashboardWidget(
      tester,
      const DashboardResponsiveContainer(child: SizedBox.expand()),
      size: const Size(1600, 900),
    );

    final box = tester.renderObject<RenderBox>(find.byType(SizedBox).last);
    expect(box.size.width, 1200);
  });
}
