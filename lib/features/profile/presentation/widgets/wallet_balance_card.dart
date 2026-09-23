import 'package:flutter/material.dart';

class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback? onTap;

  const WalletBalanceCard({
    super.key,
    this.balance = 0.0,
    this.onTap,
  });

  String get _formattedBalance {
    return '₹${balance.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        12,
        8,
        12,
        8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A6C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFFD4AF37),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _formattedBalance,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Available balance',
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white70,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}