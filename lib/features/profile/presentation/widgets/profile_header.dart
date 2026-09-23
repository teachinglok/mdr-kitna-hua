import 'package:flutter/material.dart';

import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final String shopName;
  final String email;
  final String? avatarUrl;
  final VoidCallback? onEditProfile;

  const ProfileHeader({
    super.key,
    required this.shopName,
    required this.email,
    this.avatarUrl,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        22,
      ),
      child: Column(
        children: [
          ProfileAvatar(
            shopName: shopName,
            avatarUrl: avatarUrl,
            size: 88,
          ),
          const SizedBox(height: 14),
          Text(
            shopName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (onEditProfile != null) ...[
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: onEditProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1A2A6C),
                side: const BorderSide(
                  color: Color(0xFF1A2A6C),
                ),
                minimumSize: const Size(
                  130,
                  38,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('EDIT PROFILE'),
            ),
          ],
        ],
      ),
    );
  }
}