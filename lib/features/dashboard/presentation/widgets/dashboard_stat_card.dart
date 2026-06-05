import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_background_pattern.dart';

class DashboardStatCard extends StatefulWidget {
  const DashboardStatCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final String label;
  final VoidCallback onTap;

  @override
  State<DashboardStatCard> createState() => _DashboardStatCardState();
}

class _DashboardStatCardState extends State<DashboardStatCard> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${widget.label}',
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: _pressed ? 0.97 : 1,
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: AppTheme.secondaryTextTheme(),
              iconTheme: IconThemeData(
                color: AppTheme.tokens.colors.onSecondary,
              ),
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: AppTheme.tokens.colors.secondary,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: AppBackgroundPattern(
                      variant: AppBackgroundPatternVariant.cardAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppTheme.tokens.spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: AppTheme.secondaryTextTheme().labelSmall,
                        ),
                        SizedBox(height: AppTheme.tokens.spacing.xs),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              '${widget.count}',
                              style:
                                  AppTheme.secondaryTextTheme().headlineLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
