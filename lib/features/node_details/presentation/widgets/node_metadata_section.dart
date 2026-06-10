import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/data/node_metadata_helpers.dart';
import 'package:keeply/features/node_details/presentation/widgets/node_location_breadcrumb.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeMetadataSection extends StatelessWidget {
  const NodeMetadataSection({
    super.key,
    required this.node,
    required this.typeBadgeLabel,
    required this.breadcrumbs,
  });

  final StorageNode node;
  final String typeBadgeLabel;
  final List<PathSegment> breadcrumbs;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final colors = AppTheme.tokens.colors;
    final description = nodeDescription(node);
    final tags = nodeTags(node);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          node.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08, end: 0),
        if (breadcrumbs.isNotEmpty) ...[
          SizedBox(height: spacing.xs),
          NodeLocationBreadcrumb(segments: breadcrumbs)
              .animate(delay: 20.ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.08, end: 0),
        ],
        SizedBox(height: spacing.sm),
        _TypeBadge(label: typeBadgeLabel)
            .animate(delay: 40.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.08, end: 0),
        if (description != null) ...[
          SizedBox(height: spacing.md),
          Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge,
              )
              .animate(delay: 80.ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.08, end: 0),
        ],
        SizedBox(height: spacing.md),
        Wrap(
              spacing: spacing.sm,
              runSpacing: spacing.sm,
              children: [
                if (node.createdAt != null)
                  _MetaChip(label: 'Created ${_formatDate(node.createdAt!)}'),
                if (node.updatedAt != null)
                  _MetaChip(label: 'Updated ${_formatDate(node.updatedAt!)}'),
                for (final tag in tags) _MetaChip(label: tag),
              ],
            )
            .animate(delay: 120.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.08, end: 0),
      ],
    );
  }
}

String _formatDate(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.primaryLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: colors.primaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
