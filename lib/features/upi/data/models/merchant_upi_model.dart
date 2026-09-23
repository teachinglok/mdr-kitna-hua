import '../../domain/entities/merchant_upi.dart';

class MerchantUpiModel extends MerchantUpi {
  const MerchantUpiModel({
    required super.id,
    required super.upiId,
    required super.displayName,
    super.verified,
    super.active,
    super.isDefault,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MerchantUpiModel.fromEntity(
      MerchantUpi entity,
      ) {
    return MerchantUpiModel(
      id: entity.id,
      upiId: entity.upiId,
      displayName: entity.displayName,
      verified: entity.verified,
      active: entity.active,
      isDefault: entity.isDefault,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory MerchantUpiModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MerchantUpiModel(
      id: json['id'] as String? ?? '',
      upiId: json['upiId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: _parseDateTime(
        json['createdAt'],
      ),
      updatedAt: _parseDateTime(
        json['updatedAt'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'upiId': upiId,
      'displayName': displayName,
      'verified': verified,
      'active': active,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MerchantUpiModel copyWithModel({
    String? id,
    String? upiId,
    String? displayName,
    bool? verified,
    bool? active,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MerchantUpiModel(
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

  static DateTime _parseDateTime(
      dynamic value,
      ) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      final DateTime? parsed = DateTime.tryParse(value);

      if (parsed != null) {
        return parsed;
      }
    }

    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}