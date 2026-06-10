import 'package:keeply/features/node_details/domain/entities/node_details_view_data.dart';
import 'package:keeply/features/node_details/domain/entities/node_explorer_page_data.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

abstract class NodeDetailsRepository {
  Future<NodeDetailsViewData> getNodeDetails({
    required String nodeId,
    required NodeType nodeType,
  });

  Future<List<ExplorerRowData>> getExplorerChildren({
    required String parentNodeId,
    required NodeType parentNodeType,
    required NodeExplorerType explorerType,
  });
}
