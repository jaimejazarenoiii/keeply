import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_button.dart';

class DashboardErrorView extends StatelessWidget {
  const DashboardErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.tokens.spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 48,
                color: AppTheme.tokens.colors.error,
              ),
              SizedBox(height: AppTheme.tokens.spacing.md),
              Text(message, textAlign: TextAlign.center),
              SizedBox(height: AppTheme.tokens.spacing.md),
              AppButton(label: 'Retry', onPressed: onRetry),
            ],
          ),
        ),
      ),
    );
  }
}
