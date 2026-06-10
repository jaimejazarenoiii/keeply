import 'package:equatable/equatable.dart';

class ChildContainerSummary extends Equatable {
  const ChildContainerSummary({
    required this.id,
    required this.name,
    required this.itemCount,
    this.thumbnailUrl,
  });

  final String id;
  final String name;
  final int itemCount;
  final String? thumbnailUrl;

  @override
  List<Object?> get props => [id, name, itemCount, thumbnailUrl];
}
