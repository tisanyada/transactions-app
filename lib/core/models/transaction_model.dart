enum TransactionStatus { successful, pending, failed }

class TransactionModel {
  final String id;
  final double amount;
  final DateTime date;
  final TransactionStatus status;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.status,
  });
}
