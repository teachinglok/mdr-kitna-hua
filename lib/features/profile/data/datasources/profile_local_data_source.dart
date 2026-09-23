import '../../domain/entities/merchant_profile.dart';

class ProfileLocalDataSource {
  MerchantProfile? _profile;

  Future<MerchantProfile?> getProfile() async {
    return _profile;
  }

  Future<void> saveProfile(MerchantProfile profile) async {
    _profile = profile;
  }

  Future<void> clearProfile() async {
    _profile = null;
  }
}