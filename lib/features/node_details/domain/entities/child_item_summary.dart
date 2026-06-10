import 'package:equatable/equatable.dart';

class ChildItemSummary extends Equatable {
  const ChildItemSummary({
    required this.id,
    required this.name,
    this.descriptionPreview,
    this.tags = const [],
    this.thumbnailUrl,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String? descriptionPreview;
  final List<String> tags;
  final String? thumbnailUrl;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    name,
    descriptionPreview,
    tags,
    thumbnailUrl,
    updatedAt,
  ];
}
