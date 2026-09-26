import '../entities/payment_transaction.dart';

abstract class TransactionRepository {
  Future<List<PaymentTransaction>> getTransactions();

  Future<PaymentTransaction> addTransaction(
      PaymentTransaction transaction,
      );

  Future<PaymentTransaction?> getTransactionById(
      String id,
      );
}