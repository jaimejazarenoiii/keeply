import 'package:keeply/features/subscription/data/subscription_api.dart';
import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';
import 'package:keeply/features/subscription/domain/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._api);
  final SubscriptionApi _api;
  @override
  Future<SubscriptionStatus> status() => _api.status();
}
