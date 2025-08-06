import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/core/models/transaction_model.dart';
import 'package:kobipay/pods/transaction_repo.dart';

final transactionControllerProvider = Provider((ref) {
  final transactionRepo = ref.watch(transactionRepoProvider);
  return TransactionController(transactionRepo: transactionRepo);
});

class TransactionController {
  final TransactionRepo _transactionRepo;

  TransactionController({required TransactionRepo transactionRepo})
      : _transactionRepo = transactionRepo;

  Future<List<TransactionModel>> getTransactions() async {
    final response = await _transactionRepo.getTransactions();
    return response;
  }
}
