import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/theme/app_theme.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.onSearchTap,
  });

  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    final spacing = AppTheme.tokens.spacing;

    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          Semantics(
            label: 'Keeply logo',
            image: true,
            child: Image.asset(
              'assets/images/logo-compact.png',
              height: 40,
            ),
          ),
          const Spacer(),
          Semantics(
            button: true,
            label: 'Search stored items',
            child: IconButton.filledTonal(
              onPressed: onSearchTap,
              icon: const Icon(Icons.search),
            ),
          ),
          SizedBox(width: spacing.sm),
          Semantics(
            button: true,
            label: 'Open profile and settings',
            child: IconButton.filledTonal(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
    );
  }
}
