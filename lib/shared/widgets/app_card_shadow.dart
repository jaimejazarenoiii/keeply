import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

List<BoxShadow> appThumbnailCardShadow() {
  final colors = AppTheme.tokens.colors;
  return [
    BoxShadow(
      color: colors.secondary.withValues(alpha: 0.10),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}

List<BoxShadow> appHeroThumbnailShadow() {
  final colors = AppTheme.tokens.colors;
  return [
    BoxShadow(
      color: colors.secondary.withValues(alpha: 0.14),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}
