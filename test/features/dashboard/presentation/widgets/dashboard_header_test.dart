import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_header.dart';

import 'dashboard_test_helpers.dart';

void main() {
  testWidgets('renders logo fallback and profile entry point', (tester) async {
    await pumpDashboardWidget(tester, const DashboardHeader());

    expect(find.bySemanticsLabel('Keeply logo'), findsOneWidget);
    expect(find.bySemanticsLabel('Open profile and settings'), findsOneWidget);
  });
}
