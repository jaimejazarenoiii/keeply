import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/container_card_skeleton.dart'
    as dashboard;

class ContainerCardSkeleton extends StatelessWidget {
  const ContainerCardSkeleton({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return dashboard.ContainerCardSkeleton(width: width);
  }
}
