class MerchantProfile {
  final String userId;
  final String shopName;
  final String email;
  final String? avatarUrl;
  final String? shopId;
  final String? upiId;
  final bool upiVerified;
  final double walletBalance;

  const MerchantProfile({
    required this.userId,
    required this.shopName,
    required this.email,
    this.avatarUrl,
    this.shopId,
    this.upiId,
    this.upiVerified = false,
    this.walletBalance = 0.0,
  });

  /// Returns the first character of the shop name.
  ///
  /// Example:
  /// "Suraj General Store" → "S"
  /// "Maa Laxmi Traders" → "M"
  /// "ABC Shop" → "A"
  String get shopInitial {
    final String name = shopName.trim();

    if (name.isEmpty) {
      return '?';
    }

    return name[0].toUpperCase();
  }

  MerchantProfile copyWith({
    String? userId,
    String? shopName,
    String? email,
    String? avatarUrl,
    String? shopId,
    String? upiId,
    bool? upiVerified,
    double? walletBalance,
  }) {
    return MerchantProfile(
      userId: userId ?? this.userId,
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      shopId: shopId ?? this.shopId,
      upiId: upiId ?? this.upiId,
      upiVerified: upiVerified ?? this.upiVerified,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }
}