import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

enum AppBackgroundPatternVariant { scaffold, cardAccent }

class AppBackgroundPattern extends StatelessWidget {
  const AppBackgroundPattern({
    super.key,
    this.variant = AppBackgroundPatternVariant.scaffold,
  });

  final AppBackgroundPatternVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    final config = switch (variant) {
      AppBackgroundPatternVariant.scaffold => _PatternConfig(
        showDots: true,
        showAccents: false,
        dotSpacing: 28,
        dotRadius: 1,
        dotColor: colors.textPrimary.withValues(alpha: 0.035),
      ),
      AppBackgroundPatternVariant.cardAccent => _PatternConfig(
        showDots: false,
        showAccents: true,
        dotSpacing: 14,
        dotRadius: 1.2,
        dotColor: colors.onSecondary.withValues(alpha: 0.08),
        accentColor: colors.primary.withValues(alpha: 0.14),
      ),
    };

    return CustomPaint(
      painter: _AppBackgroundPatternPainter(config),
      child: const SizedBox.expand(),
    );
  }
}

class _PatternConfig {
  const _PatternConfig({
    required this.showDots,
    required this.showAccents,
    required this.dotSpacing,
    required this.dotRadius,
    required this.dotColor,
    this.accentColor,
  });

  final bool showDots;
  final bool showAccents;
  final double dotSpacing;
  final double dotRadius;
  final Color dotColor;
  final Color? accentColor;
}

class _AppBackgroundPatternPainter extends CustomPainter {
  const _AppBackgroundPatternPainter(this.config);

  final _PatternConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    if (config.showDots) {
      final dotPaint = Paint()..color = config.dotColor;
      for (var x = config.dotSpacing; x < size.width; x += config.dotSpacing) {
        for (
          var y = config.dotSpacing;
          y < size.height;
          y += config.dotSpacing
        ) {
          canvas.drawCircle(Offset(x, y), config.dotRadius, dotPaint);
        }
      }
    }

    if (!config.showAccents || config.accentColor == null) return;

    final accentColor = config.accentColor!;
    final accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;

    canvas.drawCircle(
      Offset(size.width + 8, size.height + 12),
      size.width * 0.42,
      accentPaint,
    );

    final fillAccent = Paint()..color = accentColor.withValues(alpha: 0.35);
    canvas.drawCircle(
      Offset(size.width - 10, -10),
      size.width * 0.22,
      fillAccent,
    );
  }

  @override
  bool shouldRepaint(covariant _AppBackgroundPatternPainter oldDelegate) {
    return oldDelegate.config != config;
  }
}
