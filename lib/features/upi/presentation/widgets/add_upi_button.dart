import 'package:flutter/material.dart';

class AddUpiButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddUpiButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add_rounded,
          size: 22,
        ),
        label: const Text(
          'ADD UPI ID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2A6C),
          foregroundColor: Colors.white,
          disabledBackgroundColor:
          const Color(0xFFCBD5E1),
          disabledForegroundColor:
          const Color(0xFF64748B),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}