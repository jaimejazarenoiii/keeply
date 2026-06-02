import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.inventory_2_outlined,
          color: AppTheme.tokens.colors.primary,
          size: 48,
        ),
        SizedBox(height: AppTheme.tokens.spacing.md),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.tokens.spacing.sm),
        Text(message, textAlign: TextAlign.center),
        if (actionLabel != null && onAction != null) ...[
          SizedBox(height: AppTheme.tokens.spacing.lg),
          AppButton(label: actionLabel!, onPressed: onAction),
        ],
      ],
    ),
  );
}
