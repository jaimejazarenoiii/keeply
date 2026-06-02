import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keeply/features/auth/presentation/bloc/register_cubit.dart';
import 'package:keeply/shared/widgets/app_button.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/app_text_field.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Create account',
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.user != null) {
            context.read<AuthBloc>().add(AuthSessionChanged(state.user!));
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          return ListView(
            children: [
              if (state.errorMessage != null)
                ErrorBanner(message: state.errorMessage!),
              AppTextField(label: 'Name', onChanged: cubit.nameChanged),
              SizedBox(height: AppTheme.tokens.spacing.md),
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
              SizedBox(height: AppTheme.tokens.spacing.md),
              AppTextField(
                label: 'Profile image URL (optional)',
                onChanged: cubit.profileImageUrlChanged,
              ),
              SizedBox(height: AppTheme.tokens.spacing.lg),
              AppButton(
                label: 'Register',
                isLoading: state.isSubmitting,
                onPressed: state.canSubmit ? cubit.submit : null,
              ),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Already have an account? Login'),
              ),
            ],
          );
        },
      ),
    );
  }
}
