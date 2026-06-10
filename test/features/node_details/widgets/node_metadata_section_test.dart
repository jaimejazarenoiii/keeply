import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_metadata_section.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

import '../node_details_test_helpers.dart';

void main() {
  testWidgets('renders title, breadcrumb, and type badge', (tester) async {
    await pumpNodeWidget(
      tester,
      NodeMetadataSection(
        node: const StorageNode(
          id: 'item-1',
          type: NodeType.item,
          name: 'Hammer',
          spaceId: 'space-1',
          metadata: {'description': 'Main storage'},
        ),
        typeBadgeLabel: 'Item',
        breadcrumbs: const [
          PathSegment(
            id: 'space-1',
            type: NodeType.space,
            name: 'Garage',
          ),
          PathSegment(
            id: 'container-1',
            type: NodeType.container,
            name: 'Shelf',
          ),
        ],
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Hammer'), findsOneWidget);
    expect(find.text('Garage'), findsOneWidget);
    expect(find.text('Shelf'), findsOneWidget);
    expect(find.text(' > '), findsOneWidget);
    expect(find.text('Item'), findsOneWidget);
    expect(find.text('Main storage'), findsOneWidget);
  });
}
