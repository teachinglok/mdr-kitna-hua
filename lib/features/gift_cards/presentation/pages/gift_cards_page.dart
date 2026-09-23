import 'package:flutter/material.dart';

import '../../domain/entities/gift_card.dart';

class GiftCardsPage extends StatelessWidget {
  const GiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GiftCard> giftCards = _dummyGiftCards();

    final Map<String, List<GiftCard>> categories = {};

    for (final GiftCard giftCard in giftCards) {
      categories
          .putIfAbsent(giftCard.category, () => <GiftCard>[])
          .add(giftCard);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Gift Cards',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20, bottom: 32),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Redeem Your Rewards',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose from popular brands and redeem your eligible rewards.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 24),

            ...categories.entries.map((entry) {
              return _buildCategorySection(context, entry.key, entry.value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String category,
    List<GiftCard> cards,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.swipe, size: 19, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              const Text(
                'Swipe',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: cards.length,
            separatorBuilder: (_, _) {
              return const SizedBox(width: 14);
            },
            itemBuilder: (context, index) {
              return _GiftCardPreview(
                giftCard: cards[index],
                onTap: () {
                  _showGiftCardDetails(context, cards[index]);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  void _showGiftCardDetails(BuildContext context, GiftCard giftCard) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                CircleAvatar(
                  radius: 34,
                  backgroundColor: const Color(0xFFF1F5F9),
                  child: Text(
                    giftCard.brandName.substring(0, 1),
                    style: const TextStyle(
                      color: Color(0xFF1A2A6C),
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  giftCard.brandName,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  giftCard.category,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '₹${giftCard.denomination.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFF1A2A6C),
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  giftCard.expiryText,
                  style: TextStyle(
                    color: giftCard.isExpired
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF64748B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: giftCard.isRedeemable
                        ? () {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${giftCard.brandName} redemption will be connected later.',
                                  ),
                                ),
                              );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A2A6C),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFE2E8F0),
                      disabledForegroundColor: const Color(0xFF94A3B8),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      giftCard.isRedeemable ? 'REDEEM' : 'EXPIRED',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Powered by MDR Kitna Hua',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<GiftCard> _dummyGiftCards() {
    final DateTime now = DateTime.now();

    return [
      GiftCard(
        id: 'swiggy-500',
        brandName: 'Swiggy',
        category: 'Food & Dining',
        logoAsset: '',
        denomination: 500,
        expiresAt: now.add(const Duration(days: 5)),
      ),
      GiftCard(
        id: 'zomato-500',
        brandName: 'Zomato',
        category: 'Food & Dining',
        logoAsset: '',
        denomination: 500,
        expiresAt: now.add(const Duration(days: 12)),
      ),
      GiftCard(
        id: 'dominos-500',
        brandName: "Domino's",
        category: 'Food & Dining',
        logoAsset: '',
        denomination: 500,
        expiresAt: now.add(const Duration(days: 20)),
      ),
      GiftCard(
        id: 'amazon-1000',
        brandName: 'Amazon',
        category: 'Shopping',
        logoAsset: '',
        denomination: 1000,
        expiresAt: now.add(const Duration(days: 30)),
      ),
      GiftCard(
        id: 'flipkart-1000',
        brandName: 'Flipkart',
        category: 'Shopping',
        logoAsset: '',
        denomination: 1000,
        expiresAt: now.add(const Duration(days: 15)),
      ),
      GiftCard(
        id: 'myntra-500',
        brandName: 'Myntra',
        category: 'Shopping',
        logoAsset: '',
        denomination: 500,
        expiresAt: now.add(const Duration(days: 45)),
      ),
      GiftCard(
        id: 'croma-1000',
        brandName: 'Croma',
        category: 'Electronics',
        logoAsset: '',
        denomination: 1000,
        expiresAt: now.add(const Duration(days: 25)),
      ),
      GiftCard(
        id: 'reliance-1000',
        brandName: 'Reliance Digital',
        category: 'Electronics',
        logoAsset: '',
        denomination: 1000,
        expiresAt: now.add(const Duration(days: 40)),
      ),
      GiftCard(
        id: 'mmt-1000',
        brandName: 'MakeMyTrip',
        category: 'Travel',
        logoAsset: '',
        denomination: 1000,
        expiresAt: now.add(const Duration(days: 60)),
      ),
      GiftCard(
        id: 'bookmyshow-500',
        brandName: 'BookMyShow',
        category: 'Entertainment',
        logoAsset: '',
        denomination: 500,
        expiresAt: now.add(const Duration(days: 10)),
      ),
    ];
  }
}

class _GiftCardPreview extends StatelessWidget {
  final GiftCard giftCard;
  final VoidCallback onTap;

  const _GiftCardPreview({required this.giftCard, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 245,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A6C),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x180F172A),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Text(
                          giftCard.brandName.substring(0, 1),
                          style: const TextStyle(
                            color: Color(0xFF1A2A6C),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          giftCard.brandName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'GIFT CARD',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${giftCard.denomination.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    giftCard.expiryText,
                    style: const TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Powered by MDR Kitna Hua',
                    style: TextStyle(
                      color: Color(0xB3FFFFFF),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
