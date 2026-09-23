import 'package:flutter/material.dart';

class DefaultUpiBadge extends StatelessWidget {
  const DefaultUpiBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4AF37)
              .withValues(alpha: 0.45),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: 14,
            color: Color(0xFFD4AF37),
          ),
          SizedBox(width: 5),
          Text(
            'DEFAULT',
            style: TextStyle(
              color: Color(0xFF8A6D00),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}