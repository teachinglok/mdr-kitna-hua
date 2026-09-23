import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferEarnPage extends StatelessWidget {
  final String referralCode;

  const ReferEarnPage({
    super.key,
    this.referralCode = 'MKH-SURAJ01',
  });

  Future<void> _copyReferralCode(
      BuildContext context,
      ) async {
    await Clipboard.setData(
      ClipboardData(text: referralCode),
    );

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Referral code copied.'),
        ),
      );
  }

  void _showShareMessage(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Referral sharing will be connected soon.',
          ),
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
          'Refer & Earn',
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
            24,
            20,
            32,
          ),
          child: Column(
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37)
                      .withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard_rounded,
                  color: Color(0xFFD4AF37),
                  size: 42,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Refer friends. Earn rewards.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Invite other merchants to discover MDR Kitna Hua. Eligible rewards will be managed by the referral program.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'YOUR REFERRAL CODE',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      referralCode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1A2A6C),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _copyReferralCode(context),
                        icon: const Icon(
                          Icons.copy_outlined,
                          size: 18,
                        ),
                        label: const Text(
                          'COPY CODE',
                        ),
                        style:
                        OutlinedButton.styleFrom(
                          foregroundColor:
                          const Color(0xFF1A2A6C),
                          side: const BorderSide(
                            color: Color(0xFF1A2A6C),
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(11),
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _showShareMessage(context),
                  icon: const Icon(
                    Icons.share_outlined,
                  ),
                  label: const Text(
                    'SHARE REFERRAL',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF1A2A6C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'HOW IT WORKS',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildStep(
                number: '1',
                icon: Icons.share_outlined,
                title: 'Share your code',
                description:
                'Send your referral code or referral link to another merchant.',
              ),
              _buildStep(
                number: '2',
                icon: Icons.person_add_alt_1_outlined,
                title: 'They register',
                description:
                'The referred merchant creates an eligible MDR Kitna Hua account.',
              ),
              _buildStep(
                number: '3',
                icon: Icons.card_giftcard_outlined,
                title: 'Rewards are credited',
                description:
                'Eligible rewards are calculated and credited according to the referral program rules.',
              ),
              const SizedBox(height: 18),
              const Text(
                'Referral eligibility, rewards and limits may change according to the active program terms.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A6C)
                  .withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Color(0xFF1A2A6C),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1A2A6C),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}