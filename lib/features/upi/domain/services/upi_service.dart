import '../entities/merchant_upi.dart';

class UpiService {
  /// Maximum number of verified UPI IDs available in the free plan.
  ///
  /// The backend should become the final authority for this limit
  /// when subscriptions are introduced.
  static const int freeUpiLimit = 4;

  /// Returns only UPI IDs that are verified and active.
  List<MerchantUpi> getUsableUpis(
      List<MerchantUpi> upis,
      ) {
    return upis.where((upi) => upi.isUsable).toList();
  }

  /// Returns whether another UPI can be added under the free limit.
  ///
  /// The final subscription/entitlement check will be handled by
  /// the backend in production.
  bool canAddFreeUpi(
      List<MerchantUpi> upis,
      ) {
    return upis.length < freeUpiLimit;
  }

  /// Returns the current default UPI if it is still usable.
  MerchantUpi? getDefaultUpi(
      List<MerchantUpi> upis,
      ) {
    for (final MerchantUpi upi in upis) {
      if (upi.isDefault && upi.isUsable) {
        return upi;
      }
    }

    return null;
  }

  /// Finds a suitable default UPI.
  ///
  /// Priority:
  /// 1. Existing usable default.
  /// 2. First usable UPI.
  /// 3. No default when there are no usable UPIs.
  MerchantUpi? resolveDefaultUpi(
      List<MerchantUpi> upis,
      ) {
    final MerchantUpi? currentDefault = getDefaultUpi(upis);

    if (currentDefault != null) {
      return currentDefault;
    }

    final List<MerchantUpi> usableUpis = getUsableUpis(upis);

    if (usableUpis.isEmpty) {
      return null;
    }

    return usableUpis.first;
  }

  /// Returns a new list where the selected UPI is the only default.
  ///
  /// The selected UPI must be verified and active.
  List<MerchantUpi> selectDefaultUpi(
      List<MerchantUpi> upis,
      String selectedId,
      ) {
    final MerchantUpi? selectedUpi = _findById(
      upis,
      selectedId,
    );

    if (selectedUpi == null) {
      throw ArgumentError('UPI account not found.');
    }

    if (!selectedUpi.isUsable) {
      throw StateError(
        'Only verified and active UPI IDs can be set as default.',
      );
    }

    final DateTime now = DateTime.now();

    return upis.map((upi) {
      return upi.copyWith(
        isDefault: upi.id == selectedId,
        updatedAt: now,
      );
    }).toList();
  }

  /// Automatically fixes the default UPI when the current default
  /// becomes inactive or unverified.
  List<MerchantUpi> ensureDefaultUpi(
      List<MerchantUpi> upis,
      ) {
    final MerchantUpi? defaultUpi = getDefaultUpi(upis);

    if (defaultUpi != null) {
      return upis;
    }

    final MerchantUpi? replacement = resolveDefaultUpi(upis);

    if (replacement == null) {
      return upis
          .map(
            (upi) => upi.copyWith(
          isDefault: false,
          updatedAt: DateTime.now(),
        ),
      )
          .toList();
    }

    final DateTime now = DateTime.now();

    return upis.map((upi) {
      return upi.copyWith(
        isDefault: upi.id == replacement.id,
        updatedAt: now,
      );
    }).toList();
  }

  /// Returns whether a UPI can be used to generate a QR.
  bool canUseForQr(MerchantUpi upi) {
    return upi.isUsable;
  }

  MerchantUpi? _findById(
      List<MerchantUpi> upis,
      String id,
      ) {
    for (final MerchantUpi upi in upis) {
      if (upi.id == id) {
        return upi;
      }
    }

    return null;
  }
}