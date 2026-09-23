import '../entities/merchant_upi.dart';

abstract class UpiRepository {
  /// Returns all UPI accounts belonging to the merchant.
  Future<List<MerchantUpi>> getUpiAccounts();

  /// Adds a new UPI account.
  Future<MerchantUpi> addUpi(MerchantUpi upi);

  /// Updates an existing UPI account.
  Future<MerchantUpi> updateUpi(MerchantUpi upi);

  /// Marks a UPI account as inactive.
  ///
  /// We intentionally do not permanently delete the UPI account.
  /// This preserves transaction/history relationships for future backend use.
  Future<void> deactivateUpi(String id);
  Future<void> activateUpi(String id);

  /// Sets one verified and active UPI account as the default.
  Future<void> setDefaultUpi(String id);

  /// Returns the current default UPI, if one exists.
  Future<MerchantUpi?> getDefaultUpi();

  /// Returns only verified and active UPI accounts.
  Future<List<MerchantUpi>> getUsableUpis();
}