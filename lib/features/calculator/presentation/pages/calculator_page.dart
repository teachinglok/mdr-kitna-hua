import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../qr/presentation/pages/qr_payment_page.dart';
import '../../domain/services/calculator_service.dart';
import '../../domain/services/mdr_calculator_service.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keyboard.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorService _calculatorService =
  const CalculatorService();

  final MdrCalculatorService _mdrCalculatorService =
  const MdrCalculatorService();

  String _expression = '';
  String _displayResult = '₹0';

  double _customerPayableAmount = 0;

  void _handleButtonPressed(String value) {
    setState(() {
      if (value == 'CLEAR') {
        _expression = '';
        _displayResult = '₹0';
        _customerPayableAmount = 0;
        return;
      }

      if (value == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(
            0,
            _expression.length - 1,
          );
        }

        return;
      }

      if (value == '=') {
        _calculateFinalAmount();
        return;
      }

      _expression += value;
    });
  }

  void _calculateFinalAmount() {
    if (_expression.isEmpty) {
      return;
    }

    final double finalAmount =
    _calculatorService.calculate(_expression);

    if (finalAmount <= 0) {
      _displayResult = '₹0';
      _customerPayableAmount = 0;
      return;
    }

    final result =
    _mdrCalculatorService.calculate(finalAmount);

    _customerPayableAmount = result.customerPayable;

    _displayResult =
    '₹${_formatResult(result.customerPayable)}';
  }

  void _openQrPaymentPage() {
    if (_customerPayableAmount <= 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please calculate the amount first.',
            ),
          ),
        );

      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrPaymentPage(
          amount: _customerPayableAmount,
        ),
      ),
    );
  }

  void _openProfile() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Profile coming soon.'),
        ),
      );
  }

  String _formatResult(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A2A6C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF1A2A6C),
            child: SafeArea(
              bottom: false,
              child: _buildHeader(context),
            ),
          ),

          CalculatorDisplay(
            expression: _expression,
            result: _displayResult,
          ),

          Expanded(
            child: CalculatorKeyboard(
              onButtonPressed: _handleButtonPressed,
              onQrPressed: _openQrPaymentPage,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12,
      ),
      child: Row(
        children: [
          _buildAppLogo(),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MDR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
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

          _buildProfileButton(),
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return SizedBox(
      width: 48,
      height: 48,
      child: SvgPicture.asset(
        'assets/icons/MDR-Kitna-Hua_logo.svg',
        width: 48,
        height: 48,
        fit: BoxFit.contain,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openProfile,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.85,
              ),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),
      ),
    );
  }
}