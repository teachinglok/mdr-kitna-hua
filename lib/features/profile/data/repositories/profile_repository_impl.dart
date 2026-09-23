import '../../domain/entities/merchant_profile.dart';
import '../datasources/profile_local_data_source.dart';

class ProfileRepositoryImpl {
  final ProfileLocalDataSource _localDataSource;

  ProfileRepositoryImpl({
    required ProfileLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  Future<MerchantProfile?> getProfile() async {
    return _localDataSource.getProfile();
  }

  Future<void> saveProfile(MerchantProfile profile) async {
    await _localDataSource.saveProfile(profile);
  }

  Future<void> clearProfile() async {
    await _localDataSource.clearProfile();
  }
}