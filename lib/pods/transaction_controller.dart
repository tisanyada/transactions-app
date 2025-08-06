import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/core/models/transaction_model.dart';
import 'package:kobipay/pods/transaction_repo.dart';

// Define filter options
enum FilterOption { all, thisMonth, lastMonth }

// Provider for the current filter
final filterProvider = StateProvider<FilterOption>((ref) => FilterOption.all);

// Provider for the transaction controller
final transactionControllerProvider = Provider((ref) {
  final repo = ref.watch(transactionRepoProvider);
  return TransactionController(repo);
});

// Provider for filtered transactions
final filteredTransactionsProvider =
    FutureProvider<List<TransactionModel>>((ref) async {
  final controller = ref.watch(transactionControllerProvider);
  final filter = ref.watch(filterProvider);
  final transactions = await controller.getTransactions();

  return controller.filterTransactions(transactions, filter);
});

class TransactionController {
  final TransactionRepo _repo;

  TransactionController(this._repo);

  Future<List<TransactionModel>> getTransactions() async {
    try {
      return await _repo.getTransactions();
    } catch (e) {
      throw Exception('Failed to get transactions: $e');
    }
  }

  Future<void> refundTransaction(String id) async {
    try {
      await _repo.refundTransaction(id);
    } catch (e) {
      throw Exception('Failed to refund transaction: $e');
    }
  }

  List<TransactionModel> filterTransactions(
    List<TransactionModel> transactions,
    FilterOption filter,
  ) {
    final now = DateTime.now();

    switch (filter) {
      case FilterOption.thisMonth:
        return transactions.where((tx) {
          return tx.date.year == now.year && tx.date.month == now.month;
        }).toList();

      case FilterOption.lastMonth:
        final lastMonth = DateTime(now.year, now.month - 1);
        return transactions.where((tx) {
          return tx.date.year == lastMonth.year &&
              tx.date.month == lastMonth.month;
        }).toList();

      case FilterOption.all:
      default:
        return transactions;
    }
  }
}
