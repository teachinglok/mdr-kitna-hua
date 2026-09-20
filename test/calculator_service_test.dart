import 'package:flutter_test/flutter_test.dart';

import 'package:merchant_calculator/features/calculator/domain/services/calculator_service.dart';

void main() {
  const CalculatorService calculator = CalculatorService();

  group('CalculatorService', () {
    test('adds two numbers', () {
      expect(calculator.calculate('100+50'), 150);
    });

    test('subtracts two numbers', () {
      expect(calculator.calculate('100-50'), 50);
    });

    test('multiplies two numbers', () {
      expect(calculator.calculate('100×2'), 200);
    });

    test('divides two numbers', () {
      expect(calculator.calculate('100÷2'), 50);
    });

    test('follows BODMAS precedence', () {
      expect(calculator.calculate('100+50×2'), 200);
    });

    test('handles decimal numbers', () {
      expect(calculator.calculate('10.5+2.5'), 13);
    });
  });
}