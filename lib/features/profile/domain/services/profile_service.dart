import '../entities/merchant_profile.dart';

class ProfileService {
  String getShopInitial(String shopName) {
    final String name = shopName.trim();

    if (name.isEmpty) {
      return '?';
    }

    return name[0].toUpperCase();
  }

  bool hasUpi(MerchantProfile profile) {
    return profile.upiId != null && profile.upiId!.trim().isNotEmpty;
  }

  bool isUpiVerified(MerchantProfile profile) {
    return profile.upiVerified;
  }

  bool hasShopId(MerchantProfile profile) {
    return profile.shopId != null && profile.shopId!.trim().isNotEmpty;
  }

  bool hasProfilePhoto(MerchantProfile profile) {
    return profile.avatarUrl != null &&
        profile.avatarUrl!.trim().isNotEmpty;
  }
}