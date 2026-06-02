import 'package:flutter_test/flutter_test.dart';
import 'package:keeply/features/subscription/domain/entities/subscription_status.dart';

void main() {
  test('empty entitlements are inactive and active entitlement is active', () {
    expect(const SubscriptionStatus(entitlements: []).isActive, isFalse);
    final status = SubscriptionStatus.fromJson({
      'entitlements': [
        {'entitlementKey': 'pro', 'status': 'ACTIVE', 'provider': 'REVENUECAT'},
      ],
    });
    expect(status.isActive, isTrue);
  });
}
