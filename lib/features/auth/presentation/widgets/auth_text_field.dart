import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final int maxLength;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength = 120,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: maxLines > 1
          ? TextInputType.multiline
          : keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      textInputAction:
      maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}