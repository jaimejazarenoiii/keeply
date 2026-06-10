import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_recent_row.dart';
import 'package:keeply/shared/widgets/app_card_shadow.dart';

class DashboardPreviewThumbnailCard extends StatelessWidget {
  const DashboardPreviewThumbnailCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.semanticsLabel,
    this.imageUrl,
    this.imageAsset = kDashboardNodePlaceholder,
    this.width = defaultCardWidth,
  });

  static const defaultCardWidth = 200.0;
  static const imageHeight = 128.0;
  static const fullWidthImageHeight = 160.0;
  static const shadowPadding = 8.0;
  static const listHeight = 236.0;
  static const fullWidthListHeight = 244.0;

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String semanticsLabel;
  final String? imageUrl;
  final String imageAsset;
  final double? width;

  bool get _isFullWidth => width == double.infinity;

  double get _imageHeight =>
      _isFullWidth ? fullWidthImageHeight : imageHeight;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    final spacing = AppTheme.tokens.spacing;
    final radius = AppTheme.tokens.radius.md;

    final card = Material(
      color: colors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: _isFullWidth
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CardImage(
                    imageUrl: imageUrl,
                    imageAsset: imageAsset,
                    height: _imageHeight,
                    fullWidth: true,
                  ),
                  _CardDetails(
                    title: title,
                    subtitle: subtitle,
                  ),
                ],
              )
            : SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardImage(
                      imageUrl: imageUrl,
                      imageAsset: imageAsset,
                      width: width!,
                      height: _imageHeight,
                      fullWidth: false,
                    ),
                    _CardDetails(
                      title: title,
                      subtitle: subtitle,
                    ),
                  ],
                ),
              ),
      ),
    );

    return Semantics(
      button: true,
      label: semanticsLabel,
      child: Padding(
        padding: const EdgeInsets.only(bottom: shadowPadding),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: appThumbnailCardShadow(),
          ),
          child: card,
        ),
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final colors = AppTheme.tokens.colors;

    return Padding(
      padding: EdgeInsets.all(spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: spacing.xs),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({
    required this.imageUrl,
    required this.imageAsset,
    required this.height,
    required this.fullWidth,
    this.width,
  });

  final String? imageUrl;
  final String imageAsset;
  final double? width;
  final double height;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final image = _buildImage();

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: image,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: image,
    );
  }

  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: fullWidth ? double.infinity : width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Image.asset(
          imageAsset,
          width: fullWidth ? double.infinity : width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      imageAsset,
      width: fullWidth ? double.infinity : width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}

