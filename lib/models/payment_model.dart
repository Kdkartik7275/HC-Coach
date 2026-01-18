
class PaymentModel {
  final String paymentType;     // full_advance / per_session
  final String paymentStatus;   // pending / paid / refunded
  final double totalAmount;
  final double paidAmount;
  final double refundAmount;
  final List<TransactionModel> transactions;

  PaymentModel({
    required this.paymentType,
    required this.paymentStatus,
    required this.totalAmount,
    required this.paidAmount,
    required this.refundAmount,
    required this.transactions,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentType: json["paymentType"],
      paymentStatus: json["paymentStatus"],
      totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
      paidAmount: json["paidAmount"]?.toDouble() ?? 0.0,
      refundAmount: json["refundAmount"]?.toDouble() ?? 0.0,
      transactions: (json["transactions"] as List<dynamic>? ?? [])
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "paymentType": paymentType,
      "paymentStatus": paymentStatus,
      "totalAmount": totalAmount,
      "paidAmount": paidAmount,
      "refundAmount": refundAmount,
      "transactions": transactions.map((e) => e.toJson()).toList(),
    };
  }
}


class TransactionModel {
  final double amount;
  final DateTime date;
  final String type;
  TransactionModel({
    required this.amount,
    required this.date,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json["amount"]?.toDouble() ?? 0.0,
      date: DateTime.parse(json["date"]),
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "date": date.toIso8601String(),
      "type": type,
    };
  }
}