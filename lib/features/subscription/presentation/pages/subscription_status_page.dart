import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/storage/presentation/bloc/resource_state.dart';
import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';
import 'package:keeply/features/subscription/presentation/bloc/subscription_cubit.dart';
import 'package:keeply/shared/widgets/app_scaffold.dart';
import 'package:keeply/shared/widgets/error_banner.dart';

class SubscriptionStatusPage extends StatelessWidget {
  const SubscriptionStatusPage({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<SubscriptionCubit>()..load(),
    child: AppScaffold(
      title: 'Subscription',
      body: BlocBuilder<SubscriptionCubit, ResourceState<SubscriptionStatus>>(
        builder: (context, state) {
          if (state.status == ResourceStatus.loading)
            return const Center(child: CircularProgressIndicator());
          if (state.status == ResourceStatus.error)
            return ErrorBanner(
              message: state.message ?? 'Unable to load subscription',
            );
          final status = state.data;
          final active = status?.isActive ?? false;
          return Card(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.tokens.components.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    active ? 'Pro active' : 'Free plan',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: AppTheme.tokens.spacing.sm),
                  Text(
                    active
                        ? 'Your Keeply Pro entitlement is active.'
                        : 'No active subscription entitlement was found.',
                  ),
                  if (status != null) ...[
                    SizedBox(height: AppTheme.tokens.spacing.md),
                    for (final entitlement in status.entitlements)
                      Text(
                        '${entitlement.entitlementKey}: ${entitlement.status.name}',
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
