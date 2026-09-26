import '../../domain/entities/payment_transaction.dart';

class PaymentTransactionModel extends PaymentTransaction {
  const PaymentTransactionModel({
    required super.id,
    required super.userId,
    super.upiId,
    required super.amount,
    required super.mdrAmount,
    required super.customerPaidAmount,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PaymentTransactionModel.fromEntity(
      PaymentTransaction transaction,
      ) {
    return PaymentTransactionModel(
      id: transaction.id,
      userId: transaction.userId,
      upiId: transaction.upiId,
      amount: transaction.amount,
      mdrAmount: transaction.mdrAmount,
      customerPaidAmount: transaction.customerPaidAmount,
      status: transaction.status,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
    );
  }

  factory PaymentTransactionModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentTransactionModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      upiId: map['upiId'] as String?,
      amount: (map['amount'] as num).toDouble(),
      mdrAmount: (map['mdrAmount'] as num).toDouble(),
      customerPaidAmount:
      (map['customerPaidAmount'] as num).toDouble(),
      status: PaymentTransactionStatus.values.firstWhere(
            (status) => status.name == map['status'],
        orElse: () => PaymentTransactionStatus.failed,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'upiId': upiId,
      'amount': amount,
      'mdrAmount': mdrAmount,
      'customerPaidAmount': customerPaidAmount,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}