import 'package:flutter/material.dart';

import '../../../gift_cards/presentation/pages/gift_cards_page.dart';
import '../../../upi/data/repositories/upi_repository_impl.dart';
import '../../../upi/presentation/pages/upi_settings_page.dart';
import 'about_page.dart';
import 'edit_profile_page.dart';
import 'help_support_page.dart';
import 'refer_earn_page.dart';
import 'shop_id_page.dart';
import 'wallet_page.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_menu_tile.dart';
import '../widgets/upi_status_card.dart';
import '../widgets/wallet_balance_card.dart';

class ProfilePage extends StatefulWidget {
  final String shopName;
  final String email;
  final String? avatarUrl;
  final String? shopId;
  final double walletBalance;
  final ValueChanged<String>? onShopNameChanged;
  final UpiRepositoryImpl repository;

  const ProfilePage({
    super.key,
    required this.shopName,
    required this.email,
    this.avatarUrl,
    this.shopId,
    this.walletBalance = 0.0,
    this.onShopNameChanged,
    required this.repository,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _shopName;

  @override
  void initState() {
    super.initState();

    _shopName = widget.shopName;
  }

  Future<void> _editProfile() async {
    final String? updatedShopName =
    await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          shopName: _shopName,
          email: widget.email,
          avatarUrl: widget.avatarUrl,
        ),
      ),
    );

    if (!mounted || updatedShopName == null) {
      return;
    }

    setState(() {
      _shopName = updatedShopName;
    });

    widget.onShopNameChanged?.call(updatedShopName);
  }

  Future<void> _openUpiSettings() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UpiSettingsPage(
          repository: widget.repository,
        ),
      ),
    );
  }

  void _openShopId() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ShopIdPage(
          shopName: _shopName,
          shopId: widget.shopId ?? 'MKH-7F82A91C',
        ),
      ),
    );
  }

  void _openWallet() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WalletPage(
          shopName: _shopName,
          balance: widget.walletBalance,
        ),
      ),
    );
  }

  void _openGiftCards() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const GiftCardsPage(),
      ),
    );
  }

  void _openReferEarn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ReferEarnPage(),
      ),
    );
  }

  void _openHelpSupport() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HelpSupportPage(),
      ),
    );
  }

  void _openAbout() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AboutPage(),
      ),
    );
  }

  Future<void> _logout() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Log Out?',
          ),
          content: const Text(
            'You will need to sign in again to access your merchant account.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
              ),
              child: const Text('LOG OUT'),
            ),
          ],
        );
      },
    );

    if (!mounted || shouldLogout != true) {
      return;
    }

    // Authentication/session clearing will be connected
    // when the real backend authentication system is added.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Logout will be connected with authentication.',
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
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: 28,
          ),
          child: Column(
            children: [
              ProfileHeader(
                shopName: _shopName,
                email: widget.email,
                avatarUrl: widget.avatarUrl,
                onEditProfile: _editProfile,
              ),
              const SizedBox(height: 8),

              // Dedicated UPI Settings card.
              // This remains unchanged.
              UpiStatusCard(
                onTap: _openUpiSettings,
              ),

              // Main Wallet banner.
              // This remains unchanged.
              WalletBalanceCard(
                balance: widget.walletBalance,
                onTap: _openWallet,
              ),

              const SizedBox(height: 8),

              ProfileMenuSection(
                title: 'Account',
                children: [
                  ProfileMenuTile(
                    icon: Icons.storefront_outlined,
                    title: 'Shop / Business Name',
                    subtitle: _shopName,
                    onTap: _editProfile,
                  ),

                  // Changed ONLY this duplicate UPI Settings item.
                  ProfileMenuTile(
                    icon: Icons.payments_outlined,
                    title: 'Total Collection',
                    subtitle: 'Last 24 hours',
                    onTap: () {},
                  ),

                  ProfileMenuTile(
                    icon: Icons.badge_outlined,
                    title: 'Shop ID',
                    subtitle: widget.shopId ?? 'MKH-7F82A91C',
                    onTap: _openShopId,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ProfileMenuSection(
                title: 'Rewards',
                children: [
                  // Changed ONLY the secondary Wallet item.
                  ProfileMenuTile(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Gift Cards',
                    subtitle: 'Your available gift cards',
                    onTap: _openGiftCards,
                  ),

                  ProfileMenuTile(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Refer & Earn',
                    subtitle:
                    'Invite others and earn rewards',
                    onTap: _openReferEarn,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ProfileMenuSection(
                title: 'Support',
                children: [
                  ProfileMenuTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    subtitle: 'Get help with your account',
                    onTap: _openHelpSupport,
                  ),
                  ProfileMenuTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About App',
                    subtitle: 'MDR Kitna Hua',
                    onTap: _openAbout,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ProfileMenuSection(
                title: 'Account Actions',
                children: [
                  ProfileMenuTile(
                    icon: Icons.logout_rounded,
                    title: 'Log Out',
                    subtitle: 'Sign out of your merchant account',
                    onTap: _logout,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}