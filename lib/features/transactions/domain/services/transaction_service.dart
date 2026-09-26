import '../entities/payment_transaction.dart';

class TransactionService {
  List<PaymentTransaction> sortNewestFirst(
      List<PaymentTransaction> transactions,
      ) {
    final List<PaymentTransaction> sortedTransactions =
    List<PaymentTransaction>.from(transactions);

    sortedTransactions.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return sortedTransactions;
  }

  List<PaymentTransaction> filterByDateRange({
    required List<PaymentTransaction> transactions,
    DateTime? from,
    DateTime? to,
  }) {
    return transactions.where((transaction) {
      final DateTime date = transaction.createdAt;

      if (from != null && date.isBefore(from)) {
        return false;
      }

      if (to != null && date.isAfter(to)) {
        return false;
      }

      return true;
    }).toList();
  }

  List<PaymentTransaction> filterByTimeRange({
    required List<PaymentTransaction> transactions,
    Duration? from,
    Duration? to,
  }) {
    if (from == null && to == null) {
      return List<PaymentTransaction>.from(transactions);
    }

    return transactions.where((transaction) {
      final DateTime date = transaction.createdAt;

      final Duration transactionTime = Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
      );

      if (from != null && transactionTime < from) {
        return false;
      }

      if (to != null && transactionTime > to) {
        return false;
      }

      return true;
    }).toList();
  }

  List<PaymentTransaction> filterByAmountRange({
    required List<PaymentTransaction> transactions,
    double? minimumAmount,
    double? maximumAmount,
  }) {
    return transactions.where((transaction) {
      final double amount = transaction.customerPaidAmount;

      if (minimumAmount != null && amount < minimumAmount) {
        return false;
      }

      if (maximumAmount != null && amount > maximumAmount) {
        return false;
      }

      return true;
    }).toList();
  }

  List<PaymentTransaction> filterByStatus({
    required List<PaymentTransaction> transactions,
    PaymentTransactionStatus? status,
  }) {
    if (status == null) {
      return List<PaymentTransaction>.from(transactions);
    }

    return transactions
        .where((transaction) => transaction.status == status)
        .toList();
  }

  List<PaymentTransaction> filter({
    required List<PaymentTransaction> transactions,
    DateTime? fromDate,
    DateTime? toDate,
    Duration? fromTime,
    Duration? toTime,
    double? minimumAmount,
    double? maximumAmount,
    PaymentTransactionStatus? status,
  }) {
    List<PaymentTransaction> result =
    List<PaymentTransaction>.from(transactions);

    result = filterByDateRange(
      transactions: result,
      from: fromDate,
      to: toDate,
    );

    result = filterByTimeRange(
      transactions: result,
      from: fromTime,
      to: toTime,
    );

    result = filterByAmountRange(
      transactions: result,
      minimumAmount: minimumAmount,
      maximumAmount: maximumAmount,
    );

    result = filterByStatus(
      transactions: result,
      status: status,
    );

    return sortNewestFirst(result);
  }
}