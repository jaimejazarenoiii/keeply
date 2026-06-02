import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/features/storage/presentation/bloc/storage_form_cubit.dart';
import 'package:keeply/features/storage/presentation/widgets/storage_node_form.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';

class ItemFormPage extends StatelessWidget {
  const ItemFormPage({super.key, required this.parentId});
  final String parentId;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<StorageFormCubit>(),
    child: AppScaffold(
      title: 'Add Item',
      body: BlocListener<StorageFormCubit, StorageFormState>(
        listenWhen: (p, c) => c.saved != null,
        listener: (context, state) => context.pop(),
        child: Builder(
          builder: (context) => StorageNodeForm(
            submitLabel: 'Save Item',
            onSubmit: () =>
                context.read<StorageFormCubit>().createItem(parentId),
          ),
        ),
      ),
    ),
  );
}
