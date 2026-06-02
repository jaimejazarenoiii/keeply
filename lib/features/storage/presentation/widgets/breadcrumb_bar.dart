import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/storage/domain/entities/item_path.dart';

class BreadcrumbBar extends StatelessWidget {
  const BreadcrumbBar({super.key, required this.segments, required this.onTap});
  final List<PathSegment> segments;
  final ValueChanged<PathSegment> onTap;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var i = 0; i < segments.length; i++) ...[
          ActionChip(
            label: Text(segments[i].name),
            backgroundColor: AppTheme.tokens.colors.primaryLight,
            onPressed: () => onTap(segments[i]),
            tooltip: 'Open ${segments[i].name} ${segments[i].type.name}',
          ),
          if (i < segments.length - 1)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.tokens.spacing.xs,
              ),
              child: const Icon(Icons.chevron_right, size: 18),
            ),
        ],
      ],
    ),
  );
}
