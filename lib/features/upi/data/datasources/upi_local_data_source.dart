import '../models/merchant_upi_model.dart';

class UpiLocalDataSource {
  final List<MerchantUpiModel> _upis = [];

  Future<List<MerchantUpiModel>> getUpiAccounts() async {
    return List<MerchantUpiModel>.from(_upis);
  }

  Future<MerchantUpiModel> addUpi(
      MerchantUpiModel upi,
      ) async {
    _upis.add(upi);
    return upi;
  }

  Future<MerchantUpiModel> updateUpi(
      MerchantUpiModel upi,
      ) async {
    final int index = _upis.indexWhere(
          (item) => item.id == upi.id,
    );

    if (index == -1) {
      throw StateError('UPI account not found.');
    }

    _upis[index] = upi;
    return upi;
  }

  Future<void> deactivateUpi(String id) async {
    final int index = _upis.indexWhere(
          (item) => item.id == id,
    );

    if (index == -1) {
      throw StateError('UPI account not found.');
    }

    final MerchantUpiModel existing = _upis[index];

    _upis[index] = existing.copyWithModel(
      active: false,
      isDefault: false,
      updatedAt: DateTime.now(),
    );
  }

  Future<void> activateUpi(String id) async {
    final int index = _upis.indexWhere(
          (item) => item.id == id,
    );

    if (index == -1) {
      throw StateError('UPI account not found.');
    }

    final MerchantUpiModel existing = _upis[index];

    _upis[index] = existing.copyWithModel(
      active: true,
      updatedAt: DateTime.now(),
    );
  }

  Future<void> setDefaultUpi(String id) async {
    final int index = _upis.indexWhere(
          (item) => item.id == id,
    );

    if (index == -1) {
      throw StateError('UPI account not found.');
    }

    final MerchantUpiModel selected = _upis[index];

    if (!selected.isUsable) {
      throw StateError(
        'Only verified and active UPI IDs can be set as default.',
      );
    }

    final DateTime now = DateTime.now();

    for (int i = 0; i < _upis.length; i++) {
      _upis[i] = _upis[i].copyWithModel(
        isDefault: _upis[i].id == id,
        updatedAt: now,
      );
    }
  }
}