import 'package:flutter/material.dart';

class UpiStatusBadge extends StatelessWidget {
  final bool verified;
  final bool active;

  const UpiStatusBadge({
    super.key,
    required this.verified,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    if (!verified) {
      return _buildBadge(
        label: 'Not Verified',
        icon: Icons.info_outline_rounded,
      );
    }

    if (!active) {
      return _buildBadge(
        label: 'Inactive',
        icon: Icons.pause_circle_outline_rounded,
      );
    }

    return _buildBadge(
      label: 'Verified',
      icon: Icons.verified_rounded,
    );
  }

  Widget _buildBadge({
    required String label,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: _foregroundColor,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: _foregroundColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Color get _backgroundColor {
    if (!verified) {
      return const Color(0xFFFFF8E7);
    }

    if (!active) {
      return const Color(0xFFF1F5F9);
    }

    return const Color(0xFFECFDF5);
  }

  Color get _foregroundColor {
    if (!verified) {
      return const Color(0xFF8A6D00);
    }

    if (!active) {
      return const Color(0xFF64748B);
    }

    return const Color(0xFF047857);
  }
}