import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.message = 'Loading...'});
  final String message;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: AppTheme.tokens.colors.primary),
        SizedBox(height: AppTheme.tokens.spacing.md),
        Text(message),
      ],
    ),
  );
}
