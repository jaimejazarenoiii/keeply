import 'package:keeply/core/network/api_client.dart';
import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';

class SubscriptionApi {
  SubscriptionApi(this._client);
  final ApiClient _client;
  Future<SubscriptionStatus> status() => _client.get(
    '/subscription/status',
    parser: (json) =>
        SubscriptionStatus.fromJson(json! as Map<String, dynamic>),
  );
}
