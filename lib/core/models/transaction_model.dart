enum TransactionStatus { success, refunded, pending, failed }

enum PaymentMethod { creditCard, debitCard, bankTransfer, directDebit }

class TransactionModel {
  final String id;
  final String merchantName;
  final String merchantImage;
  final double amount;
  final DateTime date;
  final TransactionStatus status;
  final String description;
  final String subtitle;
  final PaymentMethod paymentMethod;
  final String icon;

  TransactionModel({
    required this.id,
    required this.merchantName,
    required this.merchantImage,
    required this.amount,
    required this.date,
    required this.status,
    required this.description,
    required this.subtitle,
    required this.paymentMethod,
    required this.icon,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      merchantName: json['merchantName'],
      merchantImage: json['merchantImage'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      status: _parseStatus(json['status']),
      description: json['description'],
      subtitle: json['subtitle'],
      paymentMethod: _parsePaymentMethod(json['paymentMethod']),
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantName': merchantName,
      'merchantImage': merchantImage,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'description': description,
      'subtitle': subtitle,
      'paymentMethod': _paymentMethodToString(paymentMethod),
      'icon': icon,
    };
  }

  static TransactionStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return TransactionStatus.success;
      case 'refunded':
        return TransactionStatus.refunded;
      case 'pending':
        return TransactionStatus.pending;
      case 'failed':
        return TransactionStatus.failed;
      default:
        return TransactionStatus.pending;
    }
  }

  static PaymentMethod _parsePaymentMethod(String method) {
    switch (method.toLowerCase().replaceAll(' ', '')) {
      case 'creditcard':
        return PaymentMethod.creditCard;
      case 'debitcard':
        return PaymentMethod.debitCard;
      case 'banktransfer':
        return PaymentMethod.bankTransfer;
      case 'directdebit':
        return PaymentMethod.directDebit;
      default:
        return PaymentMethod.creditCard;
    }
  }

  static String _paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.directDebit:
        return 'Direct Debit';
    }
  }
}
