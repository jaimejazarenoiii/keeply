import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keeply/features/auth/presentation/bloc/login_cubit.dart';
import 'package:keeply/shared/widgets/app_button.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/app_text_field.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.user != null) {
            context.read<AuthBloc>().add(AuthSessionChanged(state.user!));
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return ListView(
            children: [
              SizedBox(height: AppTheme.tokens.spacing.xl),
              Text(
                'keeply',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.tokens.colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(AppTheme.tokens.tagline),
              SizedBox(height: AppTheme.tokens.spacing.xl),
              if (state.errorMessage != null)
                ErrorBanner(message: state.errorMessage!),
              AppTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChanged: cubit.emailChanged,
              ),
              SizedBox(height: AppTheme.tokens.spacing.md),
              AppTextField(
                label: 'Password',
                obscureText: true,
                onChanged: cubit.passwordChanged,
              ),
              SizedBox(height: AppTheme.tokens.spacing.lg),
              AppButton(
                label: 'Login',
                isLoading: state.isSubmitting,
                onPressed: state.canSubmit ? cubit.submit : null,
              ),
              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text('Create an account'),
              ),
            ],
          );
        },
      ),
    );
  }
}
