import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/pods/transaction_controller.dart';
import 'package:kobipay/core/models/transaction_model.dart';

class TransactionDescriptionScreen extends ConsumerStatefulWidget {
  final TransactionModel transaction;
  const TransactionDescriptionScreen({super.key, required this.transaction});

  @override
  ConsumerState<TransactionDescriptionScreen> createState() =>
      _TransactionDescriptionScreenState();
}

class _TransactionDescriptionScreenState
    extends ConsumerState<TransactionDescriptionScreen> {
  bool _isRefunding = false;

  Future<void> _handleRefund() async {
    if (_isRefunding) return;

    setState(() {
      _isRefunding = true;
    });

    try {
      await ref
          .read(transactionControllerProvider)
          .refundTransaction(widget.transaction.id);

      if (!mounted) return;

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction refunded successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back after successful refund
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to refund: $e'),
          backgroundColor: Colors.red,
        ),
      );

      // Reset refunding state on error
      setState(() {
        _isRefunding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final isRefunded = transaction.status == TransactionStatus.refunded;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transaction Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  // Merchant Image
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(transaction.merchantImage),
                    // onBackgroundImageError: (_, __) {},
                    // child: Text(
                    //   transaction.merchantName[0].toUpperCase(),
                    //   style: const TextStyle(fontSize: 30),
                    // ),
                  ),
                  const SizedBox(height: 16),
                  // Merchant Name
                  Text(
                    transaction.merchantName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Transaction Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount
                  _DetailItem(
                    title: 'Amount',
                    value: '₦${transaction.amount.toStringAsFixed(2)}',
                    valueStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Payment Method
                  _DetailItem(
                    title: 'Payment Method',
                    value: transaction.paymentMethod.name,
                    icon: Icons.payment,
                  ),
                  const SizedBox(height: 20),

                  // Status
                  _DetailItem(
                    title: 'Status',
                    value: transaction.status.name.toUpperCase(),
                    valueColor: _getStatusColor(transaction.status),
                    icon: _getStatusIcon(transaction.status),
                  ),
                  const SizedBox(height: 20),

                  // Date
                  _DetailItem(
                    title: 'Date',
                    value: DateFormat.yMMMd().add_jm().format(transaction.date),
                    icon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 20),

                  // Description
                  _DetailItem(
                    title: 'Description',
                    value: transaction.description,
                    icon: Icons.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: !isRefunded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _isRefunding ? null : _handleRefund,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isRefunding
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Refund Transaction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            )
          : null,
    );
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return Colors.green;
      case TransactionStatus.refunded:
        return Colors.orange;
      case TransactionStatus.pending:
        return Colors.blue;
      case TransactionStatus.failed:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return Icons.check_circle;
      case TransactionStatus.refunded:
        return Icons.replay;
      case TransactionStatus.pending:
        return Icons.pending;
      case TransactionStatus.failed:
        return Icons.error;
    }
  }
}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueStyle;
  final Color? valueColor;
  final IconData? icon;

  const _DetailItem({
    required this.title,
    required this.value,
    this.valueStyle,
    this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: valueStyle ??
                    TextStyle(
                      fontSize: 16,
                      color: valueColor ?? Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
