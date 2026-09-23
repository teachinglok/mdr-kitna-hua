import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  void _showComingSoon(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
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
          'Help & Support',
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
            20,
            20,
            32,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _buildSupportBanner(),
              const SizedBox(height: 24),
              const Text(
                'GET HELP',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              _buildActionTile(
                context,
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Chat with Support',
                subtitle:
                'Get help with your account or app.',
                onTap: () => _showComingSoon(
                  context,
                  'Support chat will be available soon.',
                ),
              ),
              _buildActionTile(
                context,
                icon: Icons.confirmation_number_outlined,
                title: 'My Support Tickets',
                subtitle:
                'View and track your support requests.',
                onTap: () => _showComingSoon(
                  context,
                  'Support tickets will be available soon.',
                ),
              ),
              _buildActionTile(
                context,
                icon: Icons.bug_report_outlined,
                title: 'Report an Issue',
                subtitle:
                'Tell us about a problem in the app.',
                onTap: () => _showComingSoon(
                  context,
                  'Issue reporting will be available soon.',
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              _buildFaqTile(
                question:
                'What is MDR Kitna Hua?',
                answer:
                'MDR Kitna Hua helps merchants calculate the amount a customer should pay when applicable merchant charges need to be considered.',
              ),
              _buildFaqTile(
                question:
                'Does the app process payments?',
                answer:
                'No. The app calculates the customer payable amount and can help prepare a UPI payment QR. It does not itself process, hold or settle payments.',
              ),
              _buildFaqTile(
                question:
                'Can I change my UPI ID?',
                answer:
                'Yes. Open Profile, go to UPI Settings, and update your saved UPI ID.',
              ),
              _buildFaqTile(
                question:
                'What is my Shop ID?',
                answer:
                'Shop ID is your merchant identifier inside MDR Kitna Hua. It is separate from your UPI ID.',
              ),
              _buildFaqTile(
                question:
                'Where can I see my wallet balance?',
                answer:
                'Open Profile and select Wallet. The wallet is intended for MDR Kitna Hua rewards and internal ledger activity.',
              ),
              const SizedBox(height: 22),
              const Text(
                'TROUBLESHOOTING',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              _buildTroubleshootingCard(
                icon: Icons.calculate_outlined,
                title: 'Calculator not working',
                description:
                'Check the entered expression and make sure the calculation is valid before pressing CALCULATE.',
              ),
              _buildTroubleshootingCard(
                icon: Icons.qr_code_2_outlined,
                title: 'QR scanner problem',
                description:
                'Make sure camera permission is enabled and the QR code is clearly visible.',
              ),
              _buildTroubleshootingCard(
                icon: Icons.account_circle_outlined,
                title: 'Profile information',
                description:
                'Profile, UPI and merchant information can be managed from the Profile section.',
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Need more help? Contact support from the app when support services are enabled.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A6C),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
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
              Icons.support_agent_rounded,
              color: Color(0xFFD4AF37),
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'How can we help?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Find answers or contact our support team when support services are enabled.',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2A6C)
                        .withValues(alpha: 0.08),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF1A2A6C),
                    size: 21,
                  ),
                ),
                const SizedBox(width: 13),
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
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF94A3B8),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTile({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 2,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          15,
          0,
          15,
          15,
        ),
        iconColor: const Color(0xFF1A2A6C),
        collapsedIconColor:
        const Color(0xFF64748B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: Text(
          question,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
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
          Icon(
            icon,
            color: const Color(0xFF1A2A6C),
            size: 22,
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
                    fontSize: 13,
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