import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_button.dart';

class DashboardEmptyState extends StatelessWidget {
  const DashboardEmptyState({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onAction,
    this.flat = false,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.all(AppTheme.tokens.spacing.md),
      child: Column(
        children: [
          Icon(
            Icons.add_home_work_outlined,
            size: 40,
            color: AppTheme.tokens.colors.primary,
          ),
          SizedBox(height: AppTheme.tokens.spacing.sm),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.tokens.spacing.md),
          AppButton(label: actionLabel, onPressed: onAction),
        ],
      ),
    );

    return Semantics(
      label: message,
      child: flat ? content : Card(child: content),
    );
  }
}
