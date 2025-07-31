import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/core/models/transaction_model.dart';

final counterProvider = StateProvider((ref) => 0);

enum FilterOption { all, successful, pending, failed }

final filterProvider = StateProvider<FilterOption>((ref) => FilterOption.all);

/// Mock transactions
final transactionListProvider = Provider<List<TransactionModel>>(
  (ref) => [
    TransactionModel(
      id: 'T1',
      amount: 120.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: TransactionStatus.successful,
    ),
    TransactionModel(
      id: 'T2',
      amount: 55.5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: TransactionStatus.pending,
    ),
    TransactionModel(
      id: 'T3',
      amount: 300.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: TransactionStatus.pending,
    ),
    TransactionModel(
      id: 'T4',
      amount: 75.0,
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: TransactionStatus.successful,
    ),
    TransactionModel(
      id: 'T5',
      amount: 99.99,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: TransactionStatus.pending,
    ),
  ],
);

/// Filtered transaction list
final filteredTransactionsProvider = Provider<List<TransactionModel>>((ref) {
  final filter = ref.watch(filterProvider);
  final all = ref.watch(transactionListProvider);

  if (filter == FilterOption.all) return all;

  return all.where((tx) {
    switch (filter) {
      case FilterOption.successful:
        return tx.status == TransactionStatus.successful;
      case FilterOption.pending:
        return tx.status == TransactionStatus.pending;
      case FilterOption.failed:
        return tx.status == TransactionStatus.failed;
      default:
        return true;
    }
  }).toList();
});
