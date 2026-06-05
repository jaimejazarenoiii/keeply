import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

const kDashboardNodePlaceholder = 'assets/images/space_placeholder.jpg';

List<Widget> separatedRecentRows(List<Widget> rows) {
  if (rows.isEmpty) return const [];

  final divider = Divider(
    height: 1,
    color: AppTheme.tokens.colors.divider,
  );

  return [
    for (var i = 0; i < rows.length; i++) ...[
      rows[i],
      if (i < rows.length - 1) divider,
    ],
  ];
}

class DashboardRecentRow extends StatelessWidget {
  const DashboardRecentRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.semanticsLabel,
    this.imageAsset = kDashboardNodePlaceholder,
  });

  static const imageWidth = 80.0;
  static const imageHeight = 64.0;
  static const imageRadius = 14.0;

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String semanticsLabel;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    final spacing = AppTheme.tokens.spacing;

    return Semantics(
      button: true,
      label: semanticsLabel,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: spacing.md),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(imageRadius),
                child: Image.asset(
                  imageAsset,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: spacing.xs),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: colors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
