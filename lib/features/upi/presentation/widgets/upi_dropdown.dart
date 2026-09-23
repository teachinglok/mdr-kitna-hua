import 'package:flutter/material.dart';

import '../../domain/entities/merchant_upi.dart';

class UpiDropdown extends StatelessWidget {
  final List<MerchantUpi> upis;
  final MerchantUpi? selectedUpi;
  final ValueChanged<MerchantUpi?>? onChanged;

  const UpiDropdown({
    super.key,
    required this.upis,
    this.selectedUpi,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<MerchantUpi> usableUpis =
    upis.where((upi) => upi.isUsable).toList();

    final MerchantUpi? validSelectedUpi =
    _getValidSelectedUpi(usableUpis);

    return DropdownButtonFormField<String>(
      initialValue: validSelectedUpi?.id,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Receiving UPI',
        prefixIcon: const Icon(
          Icons.account_balance_outlined,
          color: Color(0xFF1A2A6C),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1A2A6C),
            width: 1.5,
          ),
        ),
      ),
      hint: const Text(
        'Select UPI ID',
      ),
      items: usableUpis.map((upi) {
        return DropdownMenuItem<String>(
          value: upi.id,
          child: Row(
            children: [
              const Icon(
                Icons.verified_rounded,
                size: 17,
                color: Color(0xFF047857),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  upi.upiId,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (upi.isDefault)
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    'DEFAULT',
                    style: TextStyle(
                      color: Color(0xFF8A6D00),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
      onChanged: usableUpis.isEmpty
          ? null
          : (String? selectedId) {
        final MerchantUpi? selected =
        _findById(
          usableUpis,
          selectedId,
        );

        onChanged?.call(selected);
      },
    );
  }

  MerchantUpi? _getValidSelectedUpi(
      List<MerchantUpi> usableUpis,
      ) {
    if (selectedUpi == null) {
      return _getDefaultUpi(usableUpis);
    }

    return _findById(
      usableUpis,
      selectedUpi!.id,
    ) ??
        _getDefaultUpi(usableUpis);
  }

  MerchantUpi? _getDefaultUpi(
      List<MerchantUpi> usableUpis,
      ) {
    for (final MerchantUpi upi in usableUpis) {
      if (upi.isDefault) {
        return upi;
      }
    }

    return usableUpis.isNotEmpty
        ? usableUpis.first
        : null;
  }

  MerchantUpi? _findById(
      List<MerchantUpi> upis,
      String? id,
      ) {
    if (id == null) {
      return null;
    }

    for (final MerchantUpi upi in upis) {
      if (upi.id == id) {
        return upi;
      }
    }

    return null;
  }
}