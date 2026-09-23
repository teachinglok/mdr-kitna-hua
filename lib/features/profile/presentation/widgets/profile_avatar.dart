import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String shopName;
  final String? avatarUrl;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.shopName,
    this.avatarUrl,
    this.size = 88,
  });

  String get _initial {
    final String name = shopName.trim();

    if (name.isEmpty) {
      return '?';
    }

    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto =
        avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1A2A6C),
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: hasPhoto
            ? Image.network(
          avatarUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return _buildInitial();
          },
        )
            : _buildInitial(),
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Text(
        _initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.42,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}