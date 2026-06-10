import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/features/node_details/domain/entities/child_item_summary.dart';

class ItemChildCard extends StatelessWidget {
  const ItemChildCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final ChildItemSummary item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final updated = item.updatedAt == null
        ? null
        : '${item.updatedAt!.year}-${item.updatedAt!.month.toString().padLeft(2, '0')}-${item.updatedAt!.day.toString().padLeft(2, '0')}';

    final subtitleParts = <String>[];
    if (item.descriptionPreview != null &&
        item.descriptionPreview!.isNotEmpty) {
      subtitleParts.add(item.descriptionPreview!);
    }
    if (item.tags.isNotEmpty) {
      subtitleParts.add(item.tags.join(' · '));
    }
    if (updated != null) {
      subtitleParts.add('Updated $updated');
    }

    return DashboardRecentRow(
      title: item.name,
      subtitle: subtitleParts.join(' · '),
      semanticsLabel: 'Open item ${item.name}',
      imageUrl: item.thumbnailUrl,
      onTap: onTap,
    );
  }
}
