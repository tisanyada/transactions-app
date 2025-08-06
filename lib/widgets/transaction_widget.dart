import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kobipay/core/models/transaction_model.dart';
import 'package:kobipay/screens/transaction_description_screen.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        onTap: () {
          log('[TRANSACTION WIDGET] onTap: ${transaction.id}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDescriptionScreen(
                transaction: transaction,
              ),
            ),
          );
        },
        leading: SizedBox(
          width: 40,
          child: Icon(
            Icons.monetization_on,
            color: _statusColor(transaction.status),
          ),
        ),
        title: Row(
          children: [
            Text(transaction.merchantName),
            const Spacer(),
            Text(
              '₦${transaction.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(transaction.subtitle),
            Text(
              DateFormat.yMMMd().format(transaction.date),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        trailing: Chip(
          label: Text(
            transaction.status.name.toUpperCase(),
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: _statusColor(transaction.status).withOpacity(0.2),
          labelStyle: TextStyle(
            color: _statusColor(transaction.status),
          ),
        ),
      ),
    );
  }
}

Color _statusColor(TransactionStatus status) {
  switch (status) {
    case TransactionStatus.success:
      return Colors.green;
    case TransactionStatus.refunded:
      return Colors.orange;
    case TransactionStatus.pending:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
