import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/features/container/presentation/container_details_delegate.dart';
import 'package:keeply/features/item/presentation/item_details_delegate.dart';
import 'package:keeply/features/node_details/domain/delegates/node_details_delegate.dart';
import 'package:keeply/features/space/presentation/space_details_delegate.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

NodeDetailsDelegate nodeDetailsDelegateFor(NodeType type) => switch (type) {
  NodeType.space => sl<SpaceDetailsDelegate>(),
  NodeType.container => sl<ContainerDetailsDelegate>(),
  NodeType.item => sl<ItemDetailsDelegate>(),
};
