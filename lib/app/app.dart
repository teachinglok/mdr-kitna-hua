import 'package:flutter/material.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import 'theme/app_theme.dart';

class MDRKitnaHuaApp extends StatelessWidget {
  const MDRKitnaHuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MDR Kitna Hua',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingPage(),
    );
  }
}