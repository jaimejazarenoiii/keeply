import 'package:keeply/features/storage/domain/entities/storage_node.dart';

String? nodeDescription(StorageNode node) {
  if (node.description != null && node.description!.trim().isNotEmpty) {
    return node.description!.trim();
  }
  final value = node.metadata['description'];
  if (value is String && value.trim().isNotEmpty) return value.trim();
  return null;
}

List<String> nodeTags(StorageNode node) {
  if (node.tags.isNotEmpty) return node.tags;
  final value = node.metadata['tags'];
  if (value is List) {
    return value.whereType<String>().where((tag) => tag.isNotEmpty).toList();
  }
  return const [];
}

String? firstImageUrl(StorageNode node) {
  if (node.images.isEmpty) return null;
  final sorted = [...node.images]
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  return sorted.first.url;
}

String truncatePreview(String? value, {int maxLength = 80}) {
  if (value == null || value.isEmpty) return '';
  if (value.length <= maxLength) return value;
  return '${value.substring(0, maxLength).trim()}…';
}
