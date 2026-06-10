import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/node_details/domain/node_route_params.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';
import 'package:keeply/features/storage/domain/entities/storage_node.dart';

class NodeLocationBreadcrumb extends StatelessWidget {
  const NodeLocationBreadcrumb({
    super.key,
    required this.segments,
  });

  final List<PathSegment> segments;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) return const SizedBox.shrink();

    final colors = AppTheme.tokens.colors;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: colors.textSecondary,
    );
    final linkStyle = textStyle?.copyWith(
      color: colors.primaryDark,
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      label: 'Location: ${segments.map((s) => s.name).join(', ')}',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < segments.length; i++) ...[
              if (i > 0)
                Text(
                  ' > ',
                  style: textStyle,
                ),
              _BreadcrumbLink(
                segment: segments[i],
                style: linkStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BreadcrumbLink extends StatelessWidget {
  const _BreadcrumbLink({
    required this.segment,
    required this.style,
  });

  final PathSegment segment;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${_typeLabel(segment.type)} ${segment.name}',
      child: InkWell(
        onTap: () => context.push(nodeDetailsPath(segment.type, segment.id)),
        child: Text(
          segment.name,
          style: style,
        ),
      ),
    );
  }
}

String _typeLabel(NodeType type) => switch (type) {
  NodeType.space => 'space',
  NodeType.container => 'container',
  NodeType.item => 'item',
};
