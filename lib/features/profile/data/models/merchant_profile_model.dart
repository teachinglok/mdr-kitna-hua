import '../../domain/entities/merchant_profile.dart';

class MerchantProfileModel extends MerchantProfile {
  const MerchantProfileModel({
    required super.userId,
    required super.shopName,
    required super.email,
    super.avatarUrl,
    super.shopId,
    super.upiId,
    super.upiVerified,
    super.walletBalance,
  });

  factory MerchantProfileModel.fromJson(Map<String, dynamic> json) {
    return MerchantProfileModel(
      userId: json['userId'] as String? ?? '',
      shopName: json['shopName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      shopId: json['shopId'] as String?,
      upiId: json['upiId'] as String?,
      upiVerified: json['upiVerified'] as bool? ?? false,
      walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'shopName': shopName,
      'email': email,
      'avatarUrl': avatarUrl,
      'shopId': shopId,
      'upiId': upiId,
      'upiVerified': upiVerified,
      'walletBalance': walletBalance,
    };
  }
}