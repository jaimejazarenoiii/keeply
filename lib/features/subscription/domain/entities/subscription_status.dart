import 'package:equatable/equatable.dart';

enum EntitlementStatus { active, inactive, expired, revoked, unknown }

EntitlementStatus entitlementStatusFromApi(String value) => switch (value) {
  'ACTIVE' => EntitlementStatus.active,
  'INACTIVE' => EntitlementStatus.inactive,
  'EXPIRED' => EntitlementStatus.expired,
  'REVOKED' => EntitlementStatus.revoked,
  _ => EntitlementStatus.unknown,
};

class SubscriptionEntitlement extends Equatable {
  const SubscriptionEntitlement({
    required this.entitlementKey,
    required this.status,
    required this.provider,
    this.externalProductId,
    this.currentPeriodEndsAt,
    this.lastEventAt,
  });
  factory SubscriptionEntitlement.fromJson(Map<String, dynamic> json) =>
      SubscriptionEntitlement(
        entitlementKey: json['entitlementKey'] as String? ?? '',
        status: entitlementStatusFromApi(
          json['status'] as String? ?? 'UNKNOWN',
        ),
        provider: json['provider'] as String? ?? '',
        externalProductId: json['externalProductId'] as String?,
        currentPeriodEndsAt: DateTime.tryParse(
          json['currentPeriodEndsAt'] as String? ?? '',
        ),
        lastEventAt: DateTime.tryParse(json['lastEventAt'] as String? ?? ''),
      );
  final String entitlementKey;
  final EntitlementStatus status;
  final String provider;
  final String? externalProductId;
  final DateTime? currentPeriodEndsAt;
  final DateTime? lastEventAt;
  @override
  List<Object?> get props => [
    entitlementKey,
    status,
    provider,
    externalProductId,
    currentPeriodEndsAt,
    lastEventAt,
  ];
}

class SubscriptionStatus extends Equatable {
  const SubscriptionStatus({required this.entitlements});
  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) =>
      SubscriptionStatus(
        entitlements: ((json['entitlements'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(SubscriptionEntitlement.fromJson)
            .toList(),
      );
  final List<SubscriptionEntitlement> entitlements;
  bool get isActive =>
      entitlements.any((item) => item.status == EntitlementStatus.active);
  @override
  List<Object?> get props => [entitlements];
}
