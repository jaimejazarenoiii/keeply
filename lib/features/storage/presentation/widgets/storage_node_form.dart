import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/storage/presentation/bloc/storage_form_cubit.dart';
import 'package:keeply/shared/widgets/app_button.dart';
import 'package:keeply/shared/widgets/app_text_field.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class StorageNodeForm extends StatelessWidget {
  const StorageNodeForm({
    super.key,
    required this.submitLabel,
    required this.onSubmit,
  });
  final String submitLabel;
  final VoidCallback onSubmit;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StorageFormCubit, StorageFormState>(
        builder: (context, state) => Column(
          children: [
            if (state.errorMessage != null)
              ErrorBanner(message: state.errorMessage!),
            AppTextField(
              label: 'Name',
              onChanged: context.read<StorageFormCubit>().nameChanged,
            ),
            SizedBox(height: AppTheme.tokens.spacing.lg),
            AppButton(
              label: submitLabel,
              isLoading: state.isSubmitting,
              onPressed: state.canSubmit ? onSubmit : null,
            ),
          ],
        ),
      );
}
