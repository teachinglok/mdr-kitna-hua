import 'package:flutter/material.dart';

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
      description: 'Enter the amount you want to receive from your customer.',
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

  Future<void> _nextPage() async {
    if (_currentIndex == 0) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (_currentIndex == 1) {
      final bool? registered = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ),
      );

      if (!mounted) {
        return;
      }

      if (registered == true) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }

      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const CalculatorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == _slides.length - 1;

    return Scaffold(
      body: Container(
        color: _slides[_currentIndex].backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _slides[index];
                  },
                ),
              ),

              OnboardingIndicator(
                currentIndex: _currentIndex,
                itemCount: _slides.length,
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    child: Text(
                      isLastPage ? 'GET STARTED' : 'NEXT',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}