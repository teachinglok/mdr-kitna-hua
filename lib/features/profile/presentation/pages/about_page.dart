import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          'About',
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
              _buildAppIdentity(),
              const SizedBox(height: 28),
              _buildSection(
                title: 'ABOUT THE APP',
                child: const Text(
                  'MDR Kitna Hua is a merchant-focused calculator designed to help businesses calculate the amount a customer should pay when applicable merchant charges and rounding need to be considered.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'KEY FEATURES',
                child: Column(
                  children: [
                    _buildFeature(
                      icon: Icons.calculate_outlined,
                      title: 'Smart Calculator',
                      description:
                      'Calculate single amounts or multi-item expressions before applying the payment calculation.',
                    ),
                    _buildFeature(
                      icon: Icons.qr_code_2_outlined,
                      title: 'UPI QR Support',
                      description:
                      'Prepare payment QR information using your configured merchant UPI details.',
                    ),
                    _buildFeature(
                      icon: Icons.account_circle_outlined,
                      title: 'Merchant Profile',
                      description:
                      'Manage your shop information, UPI settings and merchant account details.',
                    ),
                    _buildFeature(
                      icon: Icons.history_rounded,
                      title: 'Payment Records',
                      description:
                      'Payment history and transaction management will be expanded as the platform develops.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _buildImportantNotice(),
              const SizedBox(height: 18),
              _buildLinksSection(context),
              const SizedBox(height: 24),
              const Text(
                'MDR Kitna Hua',
                style: TextStyle(
                  color: Color(0xFF1A2A6C),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Smart payment calculation for every merchant.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '© 2026 MDR Kitna Hua. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppIdentity() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2A6C),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1A2A6C)
                    .withValues(alpha: 0.14),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SvgPicture.asset(
            'assets/icons/MDR-Kitna-Hua_logo.svg',
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'MDR Kitna Hua',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Merchant Payment Calculator',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 11),
          child,
        ],
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A6C)
                  .withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1A2A6C),
              size: 21,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
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

  Widget _buildImportantNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4AF37)
              .withValues(alpha: 0.35),
        ),
      ),
      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF8A6D00),
            size: 19,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'MDR Kitna Hua is a calculation and merchant utility app. It does not itself process, hold or settle customer payments. Actual payment processing and applicable charges depend on the payment provider and merchant arrangement.',
              style: TextStyle(
                color: Color(0xFF6B5700),
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          _buildLinkTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => _showComingSoon(
              context,
              'Privacy Policy page will be added before production release.',
            ),
          ),
          const Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: Color(0xFFE2E8F0),
          ),
          _buildLinkTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => _showComingSoon(
              context,
              'Terms of Service page will be added before production release.',
            ),
          ),
          const Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: Color(0xFFE2E8F0),
          ),
          _buildLinkTile(
            icon: Icons.gavel_outlined,
            title: 'Legal Information',
            onTap: () => _showComingSoon(
              context,
              'Legal information will be added before production release.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF1A2A6C),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
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
    );
  }
}