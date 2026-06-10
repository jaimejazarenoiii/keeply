import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

enum AppBackgroundPatternVariant { scaffold, dashboard, cardAccent }

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
        dotSpacing: 28,
        dotRadius: 1,
        dotColor: colors.textPrimary.withValues(alpha: 0.035),
      ),
      AppBackgroundPatternVariant.dashboard => _PatternConfig(
        circles: [
          _PatternCircle(
            centerX: 1.02,
            centerY: 1.05,
            radius: 0.44,
            color: colors.primaryDark.withValues(alpha: 0.16),
            strokeWidth: 20,
          ),
          _PatternCircle(
            centerX: 0.92,
            centerY: -0.04,
            radius: 0.24,
            color: colors.primary.withValues(alpha: 0.14),
            filled: true,
          ),
          _PatternCircle(
            centerX: -0.06,
            centerY: 0.18,
            radius: 0.2,
            color: colors.primaryDark.withValues(alpha: 0.12),
            filled: true,
          ),
          _PatternCircle(
            centerX: 0.1,
            centerY: 0.52,
            radius: 0.15,
            color: colors.primaryDark.withValues(alpha: 0.14),
            strokeWidth: 18,
          ),
          _PatternCircle(
            centerX: 0.82,
            centerY: 0.3,
            radius: 0.11,
            color: colors.primary.withValues(alpha: 0.1),
            filled: true,
          ),
          _PatternCircle(
            centerX: -0.05,
            centerY: 0.75,
            radius: 0.17,
            color: colors.primaryDark.withValues(alpha: 0.13),
            strokeWidth: 18,
          ),
          _PatternCircle(
            centerX: 0.55,
            centerY: 0.12,
            radius: 0.08,
            color: colors.primary.withValues(alpha: 0.09),
            filled: true,
          ),
        ],
      ),
      AppBackgroundPatternVariant.cardAccent => _PatternConfig(
        circles: [
          _PatternCircle(
            centerX: 1.02,
            centerY: 1.05,
            radius: 0.42,
            color: colors.primary.withValues(alpha: 0.14),
          ),
          _PatternCircle(
            centerX: 0.95,
            centerY: -0.04,
            radius: 0.22,
            color: colors.primary.withValues(alpha: 0.14 * 0.35),
            filled: true,
          ),
        ],
      ),
    };

    return CustomPaint(
      painter: _AppBackgroundPatternPainter(config),
      child: const SizedBox.expand(),
    );
  }
}

class _PatternCircle {
  const _PatternCircle({
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.color,
    this.filled = false,
    this.strokeWidth = 16,
  });

  final double centerX;
  final double centerY;
  final double radius;
  final Color color;
  final bool filled;
  final double strokeWidth;
}

class _PatternConfig {
  const _PatternConfig({
    this.showDots = false,
    this.dotSpacing = 28,
    this.dotRadius = 1,
    this.dotColor = Colors.transparent,
    this.circles = const [],
  });

  final bool showDots;
  final double dotSpacing;
  final double dotRadius;
  final Color dotColor;
  final List<_PatternCircle> circles;
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

    for (final circle in config.circles) {
      final center = Offset(
        circle.centerX * size.width,
        circle.centerY * size.height,
      );
      final radius = circle.radius * size.width;
      final paint = Paint()
        ..color = circle.color
        ..style = circle.filled ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeWidth = circle.strokeWidth;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AppBackgroundPatternPainter oldDelegate) {
    return oldDelegate.config != config;
  }
}
