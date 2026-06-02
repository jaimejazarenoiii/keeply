import 'package:flutter/material.dart';

class DesignTokens {
  const DesignTokens({
    required this.brandName,
    required this.tagline,
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.components,
  });

  factory DesignTokens.fallback() => const DesignTokens(
    brandName: 'Keeply',
    tagline: 'Track your items. Know where they are.',
    colors: AppColors(
      primary: Color(0xFF22C55E),
      primaryDark: Color(0xFF16A34A),
      primaryLight: Color(0xFFDCFCE7),
      background: Color(0xFFFAFAFA),
      surface: Color(0xFFFFFFFF),
      textPrimary: Color(0xFF0F172A),
      textSecondary: Color(0xFF64748B),
      textTertiary: Color(0xFF94A3B8),
      border: Color(0xFFE2E8F0),
      divider: Color(0xFFF1F5F9),
      success: Color(0xFF22C55E),
      warning: Color(0xFFF59E0B),
      error: Color(0xFFEF4444),
    ),
    spacing: AppSpacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48),
    radius: AppRadius(xs: 8, sm: 12, md: 16, lg: 24, xl: 32, pill: 999),
    components: AppComponents(
      buttonHeight: 56,
      buttonRadius: 18,
      textFieldHeight: 56,
      textFieldRadius: 16,
      cardRadius: 20,
      cardPadding: 16,
      bottomSheetRadius: 28,
      chipHeight: 32,
      chipRadius: 999,
    ),
  );

  final String brandName;
  final String tagline;
  final AppColors colors;
  final AppSpacing spacing;
  final AppRadius radius;
  final AppComponents components;
}

class AppColors {
  const AppColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.success,
    required this.warning,
    required this.error,
  });
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color divider;
  final Color success;
  final Color warning;
  final Color error;
}

class AppSpacing {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
}

class AppRadius {
  const AppRadius({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.pill,
  });
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double pill;
}

class AppComponents {
  const AppComponents({
    required this.buttonHeight,
    required this.buttonRadius,
    required this.textFieldHeight,
    required this.textFieldRadius,
    required this.cardRadius,
    required this.cardPadding,
    required this.bottomSheetRadius,
    required this.chipHeight,
    required this.chipRadius,
  });
  final double buttonHeight;
  final double buttonRadius;
  final double textFieldHeight;
  final double textFieldRadius;
  final double cardRadius;
  final double cardPadding;
  final double bottomSheetRadius;
  final double chipHeight;
  final double chipRadius;
}
