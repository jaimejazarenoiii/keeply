import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/widgets/dashboard_animation_specs.dart';

class DashboardResponsiveContainer extends StatelessWidget {
  const DashboardResponsiveContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: DashboardAnimationSpecs.maxWidth,
        ),
        child: child,
      ),
    );
  }
}
