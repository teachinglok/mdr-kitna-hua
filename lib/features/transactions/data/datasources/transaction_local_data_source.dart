import '../../domain/entities/payment_transaction.dart';

class TransactionLocalDataSource {
  final List<PaymentTransaction> _transactions = [];

  Future<List<PaymentTransaction>> getTransactions() async {
    return List<PaymentTransaction>.from(_transactions)
      ..sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  Future<PaymentTransaction> addTransaction(
      PaymentTransaction transaction,
      ) async {
    _transactions.add(transaction);

    return transaction;
  }

  Future<PaymentTransaction?> getTransactionById(
      String id,
      ) async {
    for (final PaymentTransaction transaction in _transactions) {
      if (transaction.id == id) {
        return transaction;
      }
    }

    return null;
  }
}