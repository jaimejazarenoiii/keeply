import 'package:flutter/material.dart';
import 'package:keeply/features/dashboard/presentation/widgets/loading/item_card_skeleton.dart'
    as dashboard;

class ItemCardSkeleton extends StatelessWidget {
  const ItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const dashboard.ItemCardSkeleton();
  }
}
