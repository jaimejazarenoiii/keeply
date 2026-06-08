import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';

class DashboardSpaceCard extends StatelessWidget {
  const DashboardSpaceCard({
    super.key,
    required this.space,
    required this.onTap,
    this.imageAsset = kDashboardNodePlaceholder,
  });

  static const cardWidth = 200.0;
  static const imageHeight = 128.0;

  final DashboardSpace space;
  final VoidCallback onTap;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    final spacing = AppTheme.tokens.spacing;
    final radius = AppTheme.tokens.radius.md;

    return Semantics(
      button: true,
      label: 'Open space ${space.name}',
      child: Material(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: colors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imageAsset,
                  width: cardWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        space.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spacing.xs),
                      Text(
                        '${space.containerCount} containers · ${space.itemCount} items',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardAddSpaceCard extends StatelessWidget {
  const DashboardAddSpaceCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    final spacing = AppTheme.tokens.spacing;
    final radius = AppTheme.tokens.radius.md;

    return Semantics(
      button: true,
      label: 'Add new space',
      child: Material(
        color: colors.primaryLight.withValues(alpha: 0.65),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: colors.primary.withValues(alpha: 0.35)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: DashboardSpaceCard.cardWidth,
            height: DashboardSpaceCard.imageHeight + 88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_home_work_outlined,
                  size: 36,
                  color: colors.primary,
                ),
                SizedBox(height: spacing.sm),
                Text(
                  'Add Space',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
