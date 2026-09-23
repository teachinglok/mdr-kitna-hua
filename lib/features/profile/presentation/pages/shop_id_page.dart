import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShopIdPage extends StatelessWidget {
  final String shopName;
  final String shopId;

  const ShopIdPage({
    super.key,
    required this.shopName,
    this.shopId = 'MKH-7F82A91C',
  });

  Future<void> _copyShopId(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(text: shopId),
    );

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Shop ID copied.'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Shop ID',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            28,
            20,
            32,
          ),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2A6C)
                      .withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  color: Color(0xFF1A2A6C),
                  size: 36,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                shopName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Your MDR Kitna Hua merchant identifier',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SHOP ID',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      shopId,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1A2A6C),
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 44,
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _copyShopId(context),
                        icon: const Icon(
                          Icons.copy_outlined,
                          size: 18,
                        ),
                        label: const Text(
                          'COPY SHOP ID',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                          const Color(0xFF1A2A6C),
                          side: const BorderSide(
                            color: Color(0xFF1A2A6C),
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF3B82F6)
                        .withValues(alpha: 0.20),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFF3B82F6),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your Shop ID identifies your merchant account inside MDR Kitna Hua. It is different from your UPI ID and is not used directly to receive UPI payments.',
                        style: TextStyle(
                          color: Color(0xFF1E40AF),
                          fontSize: 11,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}