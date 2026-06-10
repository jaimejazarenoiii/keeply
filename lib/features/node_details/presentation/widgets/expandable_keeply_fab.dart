import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class ExpandableKeeplyFab extends StatefulWidget {
  const ExpandableKeeplyFab({
    super.key,
    required this.onCreateContainer,
    required this.onCreateItem,
  });

  final VoidCallback onCreateContainer;
  final VoidCallback onCreateItem;

  @override
  State<ExpandableKeeplyFab> createState() => ExpandableKeeplyFabState();
}

class ExpandableKeeplyFabState extends State<ExpandableKeeplyFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizeTransition(
          sizeFactor: _controller,
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _MenuRow(
                label: 'Create Container',
                icon: Icons.inventory_2_outlined,
                onTap: () => _onOption(widget.onCreateContainer),
              ),
              SizedBox(height: spacing.sm),
              _MenuRow(
                label: 'Create Item',
                icon: Icons.category_outlined,
                onTap: () => _onOption(widget.onCreateItem),
              ),
              SizedBox(height: spacing.sm),
            ],
          ),
        ),
        Semantics(
          button: true,
          label: isOpen ? 'Close create menu' : 'Create storage',
          child: FloatingActionButton(
            heroTag: 'node-details-create-fab',
            backgroundColor: colors.primary,
            foregroundColor: colors.surface,
            onPressed: toggle,
            child: AnimatedRotation(
              turns: isOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(isOpen ? Icons.close : Icons.layers_outlined),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.tokens.colors;
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: colors.onSecondary),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSecondary,
                    fontWeight: FontWeight.w600,
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
