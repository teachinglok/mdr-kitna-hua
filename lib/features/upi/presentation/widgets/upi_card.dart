import 'package:flutter/material.dart';

import '../../domain/entities/merchant_upi.dart';
import 'default_upi_badge.dart';
import 'upi_status_badge.dart';

class UpiCard extends StatelessWidget {
  final MerchantUpi upi;
  final VoidCallback? onSetDefault;
  final VoidCallback? onDeactivate;
  final VoidCallback? onActivate;

  const UpiCard({
    super.key,
    required this.upi,
    this.onSetDefault,
    this.onDeactivate,
    this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    final bool canUse = upi.isUsable;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: upi.isDefault
              ? const Color(0xFFD4AF37)
              : const Color(0xFFE2E8F0),
          width: upi.isDefault ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpiIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      upi.upiId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      upi.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 7,
                      runSpacing: 6,
                      children: [
                        UpiStatusBadge(
                          verified: upi.verified,
                          active: upi.active,
                        ),
                        if (upi.isDefault && canUse)
                          const DefaultUpiBadge(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(
            height: 1,
            color: Color(0xFFE2E8F0),
          ),
          const SizedBox(height: 12),

          // Active UPI actions.
          if (upi.active)
            Row(
              children: [
                if (canUse && !upi.isDefault)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSetDefault,
                      icon: const Icon(
                        Icons.star_outline_rounded,
                        size: 17,
                      ),
                      label: const Text(
                        'Set Default',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                        const Color(0xFF1A2A6C),
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                        ),
                        minimumSize:
                        const Size.fromHeight(42),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                if (canUse && !upi.isDefault)
                  const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onDeactivate,
                    icon: const Icon(
                      Icons.pause_circle_outline_rounded,
                      size: 17,
                    ),
                    label: const Text(
                      'Deactivate',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                      const Color(0xFFB91C1C),
                      side: const BorderSide(
                        color: Color(0xFFFECACA),
                      ),
                      minimumSize:
                      const Size.fromHeight(42),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          // Inactive UPI action.
          if (!upi.active)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onActivate,
                icon: const Icon(
                  Icons.verified_user_outlined,
                  size: 17,
                ),
                label: const Text(
                  'Activate & Verify',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                  const Color(0xFF047857),
                  side: const BorderSide(
                    color: Color(0xFFA7F3D0),
                  ),
                  minimumSize:
                  const Size.fromHeight(42),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUpiIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.account_balance_outlined,
        color: Color(0xFF1A2A6C),
        size: 23,
      ),
    );
  }
}