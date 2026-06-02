import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.tokens.colors.error.withValues(alpha: 0.08),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.tokens.spacing.md),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: AppTheme.tokens.colors.error),
            SizedBox(width: AppTheme.tokens.spacing.sm),
            Expanded(child: Text(message)),
            if (onRetry != null)
              TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
