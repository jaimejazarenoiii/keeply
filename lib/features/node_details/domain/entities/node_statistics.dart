import 'package:equatable/equatable.dart';

class NodeStatistics extends Equatable {
  const NodeStatistics({
    required this.containerCount,
    required this.itemCount,
    required this.photoCount,
    required this.tagCount,
  });

  final int containerCount;
  final int itemCount;
  final int photoCount;
  final int tagCount;

  @override
  List<Object?> get props => [
    containerCount,
    itemCount,
    photoCount,
    tagCount,
  ];
}
