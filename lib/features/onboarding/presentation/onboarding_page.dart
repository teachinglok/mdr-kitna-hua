import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../auth/presentation/pages/register_page.dart';
import '../../calculator/presentation/pages/calculator_page.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_slide.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = const [
    OnboardingSlide(
      title: 'Know What to Collect',
      description:
      'Enter the amount you want to receive from your customer.',
      icon: Icons.account_balance_wallet_outlined,
      backgroundColor: Color(0xFF1A2A6C),
      iconColor: Color(0xFFD4AF37),
    ),
    OnboardingSlide(
      title: 'Calculate Like a Calculator',
      description:
      'Add, subtract, multiply or divide before calculating the payment amount.',
      icon: Icons.calculate_outlined,
      backgroundColor: Color(0xFF6C63FF),
      iconColor: Colors.white,
    ),
    OnboardingSlide(
      title: 'Avoid Payment Shortfall',
      description:
      'Calculate the customer payment amount with applicable charges and rounding.',
      icon: Icons.verified_outlined,
      backgroundColor: Color(0xFF10B981),
      iconColor: Colors.white,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _slides.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openCalculator() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const CalculatorPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isRegisterPage = _currentIndex == _slides.length;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: isRegisterPage
            ? const Color(0xFF1A2A6C)
            : Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
      ),
      child: Scaffold(
        body: Container(
          color: isRegisterPage
              ? const Color(0xFF1A2A6C)
              : _slides[_currentIndex].backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length + 1,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == _slides.length) {
                      return RegisterPage(
                        onRegistered: _openCalculator,
                      );
                    }

                    return SafeArea(
                      child: _slides[index],
                    );
                  },
                ),
              ),
              if (!isRegisterPage) ...[
                SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      OnboardingIndicator(
                        currentIndex: _currentIndex,
                        itemCount: _slides.length,
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            child: Text(
                              _currentIndex == _slides.length - 1
                                  ? 'CREATE ACCOUNT'
                                  : 'NEXT',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}