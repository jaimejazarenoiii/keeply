import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_card_shadow.dart';

class NodeDetailsResponsiveContainer extends StatelessWidget {
  const NodeDetailsResponsiveContainer({super.key, required this.child});

  final Widget child;

  static const maxWidth = 720.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

double nodeCarouselHeight(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final target = width * 0.48;
  return target.clamp(260.0, 400.0);
}

double nodeCarouselSectionHeight(
  BuildContext context, {
  int imageCount = 0,
}) {
  final spacing = AppTheme.tokens.spacing;
  final imageHeight = nodeCarouselHeight(context);
  final shadowPadding = spacing.sm;
  if (imageCount <= 1) return imageHeight + shadowPadding;
  return imageHeight + shadowPadding + spacing.sm + 8;
}

BorderRadius nodeCarouselBorderRadius() {
  final radius = AppTheme.tokens.radius.xl;
  return BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );
}

List<BoxShadow> nodeCarouselThumbnailShadow() => appHeroThumbnailShadow();

EdgeInsets nodePagePadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final horizontal = width >= 600 ? 32.0 : 24.0;
  return EdgeInsets.symmetric(horizontal: horizontal);
}
