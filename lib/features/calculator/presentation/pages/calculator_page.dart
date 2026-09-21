import 'package:flutter/material.dart';

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

  String _formatResult(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MDR Kitna Hua'),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
      ),
    );
  }
}