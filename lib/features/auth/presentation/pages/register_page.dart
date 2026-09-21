import 'package:flutter/material.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/google_sign_in_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _businessNameController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _otpController =
  TextEditingController();

  bool _otpRequested = false;
  bool _otpVerified = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyEmail() {
    FocusScope.of(context).unfocus();

    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Please enter your email address.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage('Please enter a valid email address.');
      return;
    }

    setState(() {
      _otpRequested = true;
      _otpVerified = false;
      _otpController.clear();
    });

    // TODO: TESTING ONLY
    // Real email OTP verification will be connected with backend later.
    _showMessage('Dummy OTP sent. Use 123456 for testing.');
  }

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_otpRequested) {
      _showMessage('Please verify your email first.');
      return;
    }

    if (!_otpVerified) {
      _showMessage('Please enter the correct OTP.');
      return;
    }

    // TODO: TESTING ONLY
    // Later this will be replaced by successful backend registration.
    Navigator.of(context).pop(true);
  }

  void _continueWithGoogle() {
    FocusScope.of(context).unfocus();

    _showMessage('Google authentication will be connected later.');
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);
  }

  void _showMessage(String message) {
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
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.storefront_rounded,
                        size: 54,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Set up your business profile to get started.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                AuthTextField(
                  label: 'Shop / Business Name *',
                  hintText: 'Enter your shop or business name',
                  controller: _businessNameController,
                  maxLines: 2,
                  maxLength: 120,
                  prefixIcon: const Icon(
                    Icons.storefront_outlined,
                  ),
                  validator: (value) {
                    final String text = value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Shop / Business Name is required.';
                    }

                    if (text.length < 2) {
                      return 'Please enter at least 2 characters.';
                    }

                    if (text.length > 120) {
                      return 'Maximum 120 characters allowed.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                AuthTextField(
                  label: 'Email Address *',
                  hintText: 'Enter your email address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 255,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FilledButton(
                      onPressed: _verifyEmail,
                      child: const Text('VERIFY'),
                    ),
                  ),
                  validator: (value) {
                    final String email = value?.trim() ?? '';

                    if (email.isEmpty) {
                      return 'Email address is required.';
                    }

                    if (!_isValidEmail(email)) {
                      return 'Please enter a valid email address.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                AuthTextField(
                  label: 'OTP',
                  hintText: _otpRequested
                      ? 'Enter 6-digit OTP'
                      : 'Verify your email first',
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  enabled: _otpRequested,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // TODO: TESTING ONLY
                      // Dummy OTP is 123456.
                      _otpVerified = value == '123456';
                    });
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: _otpVerified ? _register : null,
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                GoogleSignInButton(
                  onPressed: _continueWithGoogle,
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    'By continuing, you agree to use MDR Kitna Hua '
                        'for legitimate business payment calculations.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}