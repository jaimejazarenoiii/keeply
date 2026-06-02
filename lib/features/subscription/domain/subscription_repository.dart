import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';

abstract class SubscriptionRepository {
  Future<SubscriptionStatus> status();
}
