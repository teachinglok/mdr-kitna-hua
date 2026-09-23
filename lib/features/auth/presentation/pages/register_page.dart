import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/google_sign_in_button.dart';

class RegisterPage extends StatefulWidget {
  final ValueChanged<String>? onRegistered;

  const RegisterPage({
    super.key,
    this.onRegistered,
  });

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
  bool _isRegistering = false;

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

  Future<void> _register() async {
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

    if (_isRegistering) {
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    await _showRegistrationSuccess();

    if (!mounted) {
      return;
    }

    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    if (!mounted) {
      return;
    }

    widget.onRegistered?.call(
      _businessNameController.text.trim(),
    );
  }

  Future<void> _showRegistrationSuccess() async {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Registration successful',
      barrierColor: Colors.black.withValues(alpha: 0.35),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (
          context,
          animation,
          secondaryAnimation,
          ) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              padding: const EdgeInsets.fromLTRB(
                24,
                26,
                24,
                22,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Registration Successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Your account has been created successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Let’s get started!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1A2A6C),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        final Animation<double> scaleAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );

    await Future<void>.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  void _continueWithGoogle() {
    FocusScope.of(context).unfocus();

    _showMessage(
      'Google authentication will be connected later.',
    );
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A2A6C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SafeArea(
                top: false,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      24,
                      20,
                      32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageTitle(),

                        const SizedBox(height: 28),

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
                              onPressed: _isRegistering
                                  ? null
                                  : _verifyEmail,
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
                          enabled: _otpRequested && !_isRegistering,
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
                            onPressed: _otpVerified && !_isRegistering
                                ? _register
                                : null,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      color: const Color(0xFF1A2A6C),
      padding: EdgeInsets.fromLTRB(
        20,
        statusBarHeight + 8,
        20,
        16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Image.asset(
              'assets/icons/MDR Kitna Hua_icon.png',
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MDR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Kitna Hua',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitle() {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.storefront_rounded,
            size: 46,
            color: Color(0xFF1A2A6C),
          ),
          const SizedBox(height: 10),
          const Text(
            'Create your account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Set up your business profile to get started.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}