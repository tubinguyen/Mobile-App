class PaymentItem {
  final String transactionId;
  final double amount;
  final String currency;
  final String bookId;
  final String status;

  PaymentItem({
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.bookId,
    required this.status,
  });

  factory PaymentItem.fromMap(Map<String, dynamic> map) {
    return PaymentItem(
      transactionId: map['transactionId'] as String,
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] as String,
      bookId: map['productId'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'amount': amount,
      'currency': currency,
      'productId': bookId,
      'status': status,
    };
  }
}

class PaymentHistoryModel {
  final String historyId;
  final String userId;
  final List<PaymentItem> transactions;
  final int totalTransactions;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentHistoryModel({
    required this.historyId,
    required this.userId,
    required this.transactions,
    required this.totalTransactions,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentHistoryModel.fromMap(Map<String, dynamic> map) {
    final transactionList =
        (map['transactions'] as List<dynamic>)
            .map((item) => PaymentItem.fromMap(item as Map<String, dynamic>))
            .toList();

    return PaymentHistoryModel(
      historyId: map['historyId'] as String,
      userId: map['userId'] as String,
      transactions: transactionList,
      totalTransactions:
          map['totalTransactions'] as int? ?? transactionList.length,
      totalAmount:
          (map['totalAmount'] as num?)?.toDouble() ??
          transactionList.fold(0.0, (sum, item) => sum + item.amount),
      createdAt:
          map['createdAt'] is String
              ? DateTime.parse(map['createdAt'] as String)
              : map['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.now(),
      updatedAt:
          map['updatedAt'] is String
              ? DateTime.parse(map['updatedAt'] as String)
              : map['updatedAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'historyId': historyId,
      'userId': userId,
      'transactions': transactions.map((item) => item.toMap()).toList(),
      'totalTransactions': totalTransactions,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  PaymentHistoryModel copyWith({
    String? historyId,
    String? userId,
    List<PaymentItem>? transactions,
    int? totalTransactions,
    double? totalAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentHistoryModel(
      historyId: historyId ?? this.historyId,
      userId: userId ?? this.userId,
      transactions: transactions ?? this.transactions,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
