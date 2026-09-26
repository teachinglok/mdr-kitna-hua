enum PaymentTransactionStatus {
  received,
  failed,
}

class PaymentTransaction {
  final String id;
  final String userId;
  final String? upiId;

  /// Original amount of goods/services.
  final double amount;

  /// MDR amount charged/deducted for this transaction.
  final double mdrAmount;

  /// Final amount paid by the customer.
  final double customerPaidAmount;

  final PaymentTransactionStatus status;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PaymentTransaction({
    required this.id,
    required this.userId,
    this.upiId,
    required this.amount,
    required this.mdrAmount,
    required this.customerPaidAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isReceived {
    return status == PaymentTransactionStatus.received;
  }

  bool get isFailed {
    return status == PaymentTransactionStatus.failed;
  }

  /// Whether this transaction belongs to the rolling last 24-hour window.
  bool get isWithinLast24Hours {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(createdAt);

    return difference >= Duration.zero &&
        difference <= const Duration(hours: 24);
  }

  PaymentTransaction copyWith({
    String? id,
    String? userId,
    String? upiId,
    double? amount,
    double? mdrAmount,
    double? customerPaidAmount,
    PaymentTransactionStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentTransaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      upiId: upiId ?? this.upiId,
      amount: amount ?? this.amount,
      mdrAmount: mdrAmount ?? this.mdrAmount,
      customerPaidAmount:
      customerPaidAmount ?? this.customerPaidAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}