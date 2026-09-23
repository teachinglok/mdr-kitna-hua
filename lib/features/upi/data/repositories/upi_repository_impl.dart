import '../../domain/entities/merchant_upi.dart';
import '../../domain/repositories/upi_repository.dart';
import '../../domain/services/upi_service.dart';
import '../datasources/upi_local_data_source.dart';
import '../models/merchant_upi_model.dart';

class UpiRepositoryImpl implements UpiRepository {
  final UpiLocalDataSource _localDataSource;
  final UpiService _upiService;

  UpiRepositoryImpl({
    required UpiLocalDataSource localDataSource,
    required UpiService upiService,
  })  : _localDataSource = localDataSource,
        _upiService = upiService;

  @override
  Future<List<MerchantUpi>> getUpiAccounts() async {
    return _localDataSource.getUpiAccounts();
  }

  @override
  Future<MerchantUpi> addUpi(
      MerchantUpi upi,
      ) async {
    final List<MerchantUpi> existingUpis =
    await getUpiAccounts();

    if (!_upiService.canAddFreeUpi(existingUpis)) {
      throw StateError(
        'Free UPI limit reached. Please upgrade to add another UPI ID.',
      );
    }

    final bool alreadyExists = existingUpis.any(
          (existing) =>
      existing.upiId.toLowerCase() ==
          upi.upiId.toLowerCase(),
    );

    if (alreadyExists) {
      throw StateError(
        'This UPI ID has already been added.',
      );
    }

    final MerchantUpiModel model =
    MerchantUpiModel.fromEntity(upi);

    final MerchantUpiModel saved =
    await _localDataSource.addUpi(model);

    final List<MerchantUpi> updatedUpis =
    await getUpiAccounts();

    final List<MerchantUpi> normalizedUpis =
    _upiService.ensureDefaultUpi(updatedUpis);

    await _syncDefaults(normalizedUpis);

    return normalizedUpis.firstWhere(
          (item) => item.id == saved.id,
    );
  }

  @override
  Future<MerchantUpi> updateUpi(
      MerchantUpi upi,
      ) async {
    final MerchantUpiModel model =
    MerchantUpiModel.fromEntity(upi);

    return _localDataSource.updateUpi(model);
  }

  @override
  Future<void> deactivateUpi(
      String id,
      ) async {
    await _localDataSource.deactivateUpi(id);

    final List<MerchantUpi> upis =
    await getUpiAccounts();

    final List<MerchantUpi> normalizedUpis =
    _upiService.ensureDefaultUpi(upis);

    await _syncDefaults(normalizedUpis);
  }

  @override
  Future<void> activateUpi(
      String id,
      ) async {
    await _localDataSource.activateUpi(id);
  }

  @override
  Future<void> setDefaultUpi(
      String id,
      ) async {
    final List<MerchantUpi> upis =
    await getUpiAccounts();

    final List<MerchantUpi> updatedUpis =
    _upiService.selectDefaultUpi(
      upis,
      id,
    );

    await _syncDefaults(updatedUpis);
  }

  @override
  Future<MerchantUpi?> getDefaultUpi() async {
    final List<MerchantUpi> upis =
    await getUpiAccounts();

    return _upiService.resolveDefaultUpi(upis);
  }

  @override
  Future<List<MerchantUpi>> getUsableUpis() async {
    final List<MerchantUpi> upis =
    await getUpiAccounts();

    return _upiService.getUsableUpis(upis);
  }

  Future<void> _syncDefaults(
      List<MerchantUpi> upis,
      ) async {
    for (final MerchantUpi upi in upis) {
      final MerchantUpiModel model =
      MerchantUpiModel.fromEntity(upi);

      await _localDataSource.updateUpi(model);
    }
  }
}