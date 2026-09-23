class MerchantUpi {
  final String id;
  final String upiId;
  final String displayName;
  final bool verified;
  final bool active;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MerchantUpi({
    required this.id,
    required this.upiId,
    required this.displayName,
    this.verified = false,
    this.active = true,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Returns true when this UPI can be used for receiving payments.
  bool get isUsable {
    return verified && active;
  }

  /// Creates a copy with selected fields changed.
  MerchantUpi copyWith({
    String? id,
    String? upiId,
    String? displayName,
    bool? verified,
    bool? active,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MerchantUpi(
      id: id ?? this.id,
      upiId: upiId ?? this.upiId,
      displayName: displayName ?? this.displayName,
      verified: verified ?? this.verified,
      active: active ?? this.active,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}