import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
            label: 'Open profile and settings',
            child: IconButton.filledTonal(
              onPressed: () => context.go('/settings'),
              icon: const Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
    );
  }
}
