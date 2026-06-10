import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_button.dart';

class NodeDetailsErrorView extends StatelessWidget {
  const NodeDetailsErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.tokens.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppTheme.tokens.colors.error,
            ),
            SizedBox(height: AppTheme.tokens.spacing.md),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.tokens.spacing.lg),
            AppButton(label: 'Try Again', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
