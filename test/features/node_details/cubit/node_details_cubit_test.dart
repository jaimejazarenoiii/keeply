import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_details_cubit.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

import '../node_details_test_helpers.dart';

void main() {
  late FakeNodeDetailsRepository repository;

  setUp(() {
    repository = FakeNodeDetailsRepository();
  });

  blocTest<NodeDetailsCubit, NodeDetailsState>(
    'emits loaded after successful load',
    build: () => NodeDetailsCubit(repository),
    act: (cubit) => cubit.load(nodeId: 'space-1', nodeType: NodeType.space),
    expect: () => [
      isA<NodeDetailsLoading>(),
      isA<NodeDetailsLoaded>(),
    ],
  );

  blocTest<NodeDetailsCubit, NodeDetailsState>(
    'emits error when repository throws',
    build: () => NodeDetailsCubit(FakeNodeDetailsRepository(shouldThrow: true)),
    act: (cubit) => cubit.load(nodeId: 'space-1', nodeType: NodeType.space),
    expect: () => [
      isA<NodeDetailsLoading>(),
      isA<NodeDetailsError>(),
    ],
  );
}
