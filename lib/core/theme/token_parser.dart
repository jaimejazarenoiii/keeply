import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:keeply/core/theme/design_tokens.dart';

class TokenParser {
  const TokenParser();

  Future<DesignTokens> load() async {
    try {
      final raw = await rootBundle.loadString('.specify/design-token.json');
      return parse(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return DesignTokens.fallback();
    }
  }

  DesignTokens parse(Map<String, dynamic> json) {
    final brand = json['brand'] as Map<String, dynamic>? ?? const {};
    final colors = json['colors'] as Map<String, dynamic>? ?? const {};
    final spacing = json['spacing'] as Map<String, dynamic>? ?? const {};
    final radius = json['radius'] as Map<String, dynamic>? ?? const {};
    final components = json['components'] as Map<String, dynamic>? ?? const {};
    final button = components['button'] as Map<String, dynamic>? ?? const {};
    final textField =
        components['textField'] as Map<String, dynamic>? ?? const {};
    final card = components['card'] as Map<String, dynamic>? ?? const {};
    final bottomSheet =
        components['bottomSheet'] as Map<String, dynamic>? ?? const {};
    final chip = components['chip'] as Map<String, dynamic>? ?? const {};
    return DesignTokens(
      brandName: brand['name'] as String? ?? 'Keeply',
      tagline:
          brand['tagline'] as String? ??
          'Track your items. Know where they are.',
      colors: AppColors(
        primary: _color(colors['primary'], 0xFF22C55E),
        secondary: _color(colors['secondary'], 0xFF0F172A),
        onSecondary: _color(colors['onSecondary'], 0xFFFFFFFF),
        onSecondaryMuted: _color(colors['onSecondaryMuted'], 0xFFCBD5E1),
        primaryDark: _color(colors['primaryDark'], 0xFF16A34A),
        primaryLight: _color(colors['primaryLight'], 0xFFDCFCE7),
        background: _color(colors['background'], 0xFFFAFAFA),
        surface: _color(colors['surface'], 0xFFFFFFFF),
        textPrimary: _color(colors['textPrimary'], 0xFF0F172A),
        textSecondary: _color(colors['textSecondary'], 0xFF64748B),
        textTertiary: _color(colors['textTertiary'], 0xFF94A3B8),
        border: _color(colors['border'], 0xFFE2E8F0),
        divider: _color(colors['divider'], 0xFFF1F5F9),
        success: _color(colors['success'], 0xFF22C55E),
        warning: _color(colors['warning'], 0xFFF59E0B),
        error: _color(colors['error'], 0xFFEF4444),
      ),
      spacing: AppSpacing(
        xs: _number(spacing['xs'], 4),
        sm: _number(spacing['sm'], 8),
        md: _number(spacing['md'], 16),
        lg: _number(spacing['lg'], 24),
        xl: _number(spacing['xl'], 32),
        xxl: _number(spacing['xxl'], 48),
      ),
      radius: AppRadius(
        xs: _number(radius['xs'], 8),
        sm: _number(radius['sm'], 12),
        md: _number(radius['md'], 16),
        lg: _number(radius['lg'], 24),
        xl: _number(radius['xl'], 32),
        pill: _number(radius['pill'], 999),
      ),
      components: AppComponents(
        buttonHeight: _number(button['height'], 56),
        buttonRadius: _number(button['radius'], 18),
        textFieldHeight: _number(textField['height'], 56),
        textFieldRadius: _number(textField['radius'], 16),
        cardRadius: _number(card['radius'], 20),
        cardPadding: _number(card['padding'], 16),
        bottomSheetRadius: _number(bottomSheet['radius'], 28),
        chipHeight: _number(chip['height'], 32),
        chipRadius: _number(chip['radius'], 999),
      ),
    );
  }

  Color _color(Object? value, int fallback) {
    if (value is! String || !value.startsWith('#')) return Color(fallback);
    return Color(int.parse('FF${value.substring(1)}', radix: 16));
  }

  double _number(Object? value, num fallback) =>
      value is num ? value.toDouble() : fallback.toDouble();
}
