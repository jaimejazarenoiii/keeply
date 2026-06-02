import 'package:flutter/material.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/shared/widgets/app_loading_indicator.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'keeply',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppTheme.tokens.colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const AppLoadingIndicator(message: 'Preparing your storage...'),
        ],
      ),
    ),
  );
}
