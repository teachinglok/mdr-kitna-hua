import 'package:flutter_test/flutter_test.dart';

import 'package:merchant_calculator/features/calculator/domain/services/mdr_calculator_service.dart';

void main() {
  const MdrCalculatorService mdrService = MdrCalculatorService();

  group('MdrCalculatorService', () {
    test('₹2,000 has no MDR', () {
      final result = mdrService.calculate(2000);

      expect(result.enteredAmount, 2000);
      expect(result.customerPayable, 2000);
      expect(result.mdrAmount, 0);
    });

    test('₹5,000 gives whole-rupee payable without shortfall', () {
      final result = mdrService.calculate(5000);

      expect(result.enteredAmount, 5000);
      expect(result.customerPayable, 5021);

      final settlement =
          result.customerPayable - result.mdrAmount;

      expect(settlement >= 5000, true);
    });

    test('₹75,000 stays in 0.4% slab', () {
      final result = mdrService.calculate(75000);

      expect(result.enteredAmount, 75000);
      expect(result.customerPayable >= 75000, true);

      final settlement =
          result.customerPayable - result.mdrAmount;

      expect(settlement >= 75000, true);
    });

    test('₹75,001 uses flat ₹300 MDR', () {
      final result = mdrService.calculate(75001);

      expect(result.enteredAmount, 75001);
      expect(result.customerPayable, 75301);
      expect(result.mdrAmount, 300);
    });

    test('₹2,001 does not produce a settlement shortfall', () {
      final result = mdrService.calculate(2001);

      final settlement =
          result.customerPayable - result.mdrAmount;

      expect(result.customerPayable % 1, 0);
      expect(settlement >= 2001, true);
    });

    test('₹200,000 uses flat ₹300 MDR', () {
      final result = mdrService.calculate(200000);

      expect(result.enteredAmount, 200000);
      expect(result.customerPayable, 200300);
      expect(result.mdrAmount, 300);
    });

    test('decimal target is rounded upward to whole rupee', () {
      final result = mdrService.calculate(5000.50);

      expect(result.customerPayable % 1, 0);

      final settlement =
          result.customerPayable - result.mdrAmount;

      expect(settlement >= 5000.50, true);
    });
  });
}