import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLarge;
  final bool isSuccess;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.isLarge = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLarge ? 72 : 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSuccess
              ? const Color(0xFF10B981)
              : isPrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          foregroundColor: (isPrimary || isSuccess)
              ? Colors.white
              : Theme.of(context).colorScheme.onSurface,
          elevation: isPrimary ? 3 : 0,
          side: isPrimary
              ? null
              : BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 26 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}