import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardCreateFab extends StatefulWidget {
  const DashboardCreateFab({
    super.key,
    required this.onCreateSpace,
    required this.onCreateContainer,
    required this.onCreateItem,
    required this.onOpenChanged,
  });

  final VoidCallback onCreateSpace;
  final VoidCallback onCreateContainer;
  final VoidCallback onCreateItem;
  final ValueChanged<bool> onOpenChanged;

  @override
  State<DashboardCreateFab> createState() => DashboardCreateFabState();
}

class DashboardCreateFabState extends State<DashboardCreateFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  static const _options = [
    _CreateFabOption(
      label: 'Create Space',
      icon: Icons.home_work_outlined,
      semanticsLabel: 'Create space',
    ),
    _CreateFabOption(
      label: 'Create Container',
      icon: Icons.inventory_2_outlined,
      semanticsLabel: 'Create container',
    ),
    _CreateFabOption(
      label: 'Create Item',
      icon: Icons.category_outlined,
      semanticsLabel: 'Create item',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _controller.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimationStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    widget.onOpenChanged(status != AnimationStatus.dismissed);
  }

  void toggle() {
    if (_controller.isCompleted) {
      close();
      return;
    }
    _controller.forward();
  }

  void close() {
    if (_controller.isDismissed) return;
    _controller.reverse();
  }

  void _onOption(VoidCallback action) {
    close();
    action();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final colors = AppTheme.tokens.colors;
    final isOpen = _controller.value > 0;

    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FadeTransition(
            opacity: _expandAnimation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.94, end: 1).animate(_expandAnimation),
              alignment: Alignment.bottomRight,
              child: SizeTransition(
                sizeFactor: _expandAnimation,
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < _options.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: spacing.sm),
                        child: _CreateFabMenuRow(
                          option: _options[i],
                          onTap: () => _onOption(switch (i) {
                            0 => widget.onCreateSpace,
                            1 => widget.onCreateContainer,
                            _ => widget.onCreateItem,
                          }),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Semantics(
            button: true,
            label: isOpen ? 'Close create menu' : 'Create storage',
            child: FloatingActionButton(
              heroTag: 'dashboard-create-fab',
              backgroundColor: colors.primary,
              foregroundColor: colors.surface,
              elevation: 3,
              highlightElevation: 4,
              splashColor: colors.onSecondary.withValues(alpha: 0.2),
              onPressed: toggle,
              child: AnimatedRotation(
                turns: isOpen ? 0.125 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(isOpen ? Icons.close : Icons.layers_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCreateFabOverlay extends StatelessWidget {
  const DashboardCreateFabOverlay({
    super.key,
    required this.visible,
    required this.onDismiss,
  });

  final bool visible;
  final VoidCallback onDismiss;

  static const overlayColor = Color(0xCC000000);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.opaque,
          child: const ColoredBox(color: overlayColor),
        ),
      ),
    );
  }
}

class _CreateFabOption {
  const _CreateFabOption({
    required this.label,
    required this.icon,
    required this.semanticsLabel,
  });

  final String label;
  final IconData icon;
  final String semanticsLabel;
}

class _CreateFabMenuRow extends StatelessWidget {
  const _CreateFabMenuRow({
    required this.option,
    required this.onTap,
  });

  final _CreateFabOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;
    final colors = AppTheme.tokens.colors;

    return Semantics(
      button: true,
      label: option.semanticsLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: colors.onSecondary.withValues(alpha: 0.12),
          highlightColor: colors.onSecondary.withValues(alpha: 0.08),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  option.icon,
                  size: 20,
                  color: colors.onSecondary,
                ),
                SizedBox(width: spacing.sm),
                Text(
                  option.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onSecondary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
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
