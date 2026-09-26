import '../../domain/entities/payment_transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _localDataSource;

  TransactionRepositoryImpl({
    required TransactionLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<List<PaymentTransaction>> getTransactions() {
    return _localDataSource.getTransactions();
  }

  @override
  Future<PaymentTransaction> addTransaction(
      PaymentTransaction transaction,
      ) {
    return _localDataSource.addTransaction(transaction);
  }

  @override
  Future<PaymentTransaction?> getTransactionById(
      String id,
      ) {
    return _localDataSource.getTransactionById(id);
  }
}