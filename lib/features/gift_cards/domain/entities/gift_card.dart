enum GiftCardStatus {
  active,
  expired,
  redeemed,
}

class GiftCard {
  final String id;
  final String brandName;
  final String category;
  final String logoAsset;
  final double denomination;
  final DateTime expiresAt;
  final GiftCardStatus status;

  const GiftCard({
    required this.id,
    required this.brandName,
    required this.category,
    required this.logoAsset,
    required this.denomination,
    required this.expiresAt,
    this.status = GiftCardStatus.active,
  });

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  bool get isRedeemable {
    return status == GiftCardStatus.active && !isExpired;
  }

  int get daysUntilExpiry {
    final DateTime now = DateTime.now();

    if (isExpired) {
      return 0;
    }

    return expiresAt.difference(now).inDays;
  }

  String get expiryText {
    if (isExpired) {
      return 'Expired';
    }

    final int days = daysUntilExpiry;

    if (days == 0) {
      return 'Expires today';
    }

    if (days == 1) {
      return 'Expires tomorrow';
    }

    return 'Expires in $days days';
  }

  GiftCard copyWith({
    String? id,
    String? brandName,
    String? category,
    String? logoAsset,
    double? denomination,
    DateTime? expiresAt,
    GiftCardStatus? status,
  }) {
    return GiftCard(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      category: category ?? this.category,
      logoAsset: logoAsset ?? this.logoAsset,
      denomination: denomination ?? this.denomination,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
    );
  }
}