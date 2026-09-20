import '../entities/calculation_result.dart';

class MdrCalculatorService {
  const MdrCalculatorService();

  static const double freeThreshold = 2000.0;
  static const double standardThreshold = 75000.0;
  static const double mdrRate = 0.004;
  static const double maximumMdr = 300.0;

  CalculationResult calculate(double targetAmount) {
    if (targetAmount <= 0) {
      return const CalculationResult(
        enteredAmount: 0,
        customerPayable: 0,
        mdrAmount: 0,
      );
    }

    // ₹2,000 or below: no MDR.
    if (targetAmount <= freeThreshold) {
      return CalculationResult(
        enteredAmount: targetAmount,
        customerPayable: targetAmount.ceilToDouble(),
        mdrAmount: 0,
      );
    }

    // Exactly ₹75,000:
    // 0.4% MDR = ₹300.
    // Customer pays exactly ₹75,300.
    if (targetAmount == standardThreshold) {
      return const CalculationResult(
        enteredAmount: 75000,
        customerPayable: 75300,
        mdrAmount: 300,
      );
    }

    // Above ₹75,000: flat ₹300 MDR.
    if (targetAmount > standardThreshold) {
      final double customerPayable =
      (targetAmount + maximumMdr).ceilToDouble();

      return CalculationResult(
        enteredAmount: targetAmount,
        customerPayable: customerPayable,
        mdrAmount: maximumMdr,
      );
    }

    // Above ₹2,000 and below ₹75,000:
    // Find the minimum whole-rupee customer payment
    // that keeps merchant settlement >= target amount.
    double customerPayable =
    (targetAmount / (1 - mdrRate)).ceilToDouble();

    while (true) {
      final double mdr = customerPayable * mdrRate;
      final double expectedSettlement =
          customerPayable - mdr;

      if (expectedSettlement >= targetAmount) {
        return CalculationResult(
          enteredAmount: targetAmount,
          customerPayable: customerPayable,
          mdrAmount: mdr,
        );
      }

      customerPayable += 1;
    }
  }
}