import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/core/models/transaction_model.dart';

final transactionRepoProvider = Provider((ref) => TransactionRepo());

class TransactionRepo {
  Future<List<TransactionModel>> getTransactions() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/transactions.json');
      log('Loaded JSON: $jsonString'); // For debugging

      // Parse the JSON string
      final List<dynamic> jsonList = json.decode(jsonString);

      // Convert to List of TransactionModel
      return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log('Error loading transactions: $e\n$stackTrace');
      throw Exception('Failed to load transactions: $e');
    }
  }

  Future<void> refundTransaction(String id) async {
    // In a real app, this would make an API call
    // For now, we'll just simulate a delay
    await Future.delayed(const Duration(seconds: 1));
  }
}
