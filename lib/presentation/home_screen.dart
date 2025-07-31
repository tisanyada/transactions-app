import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kobipay/pods/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipay/core/models/transaction_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends ConsumerState<HomeScreen> {
  void _incrementCounter() {
    ref.read(counterProvider.notifier).state++;
  }

  Color _statusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.successful:
        return Colors.green;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.failed:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterProvider);
    final transactions = ref.watch(filteredTransactionsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40, // Use at least 40 for proper display of ChoiceChips
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: FilterOption.values.length,
                itemBuilder: (context, index) {
                  final option = FilterOption.values[index];
                  final label =
                      option.name[0].toUpperCase() + option.name.substring(1);
                  final isSelected = filter == option;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      selectedColor: Colors.grey.shade300,
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (_) =>
                          ref.read(filterProvider.notifier).state = option,
                    ),
                  );
                },
              ),
            ),

            // Transaction list
            Expanded(
              child: transactions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox,
                              size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'No transactions found',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (_, index) {
                        final tx = transactions[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 50),
                                child: child,
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.monetization_on,
                              color: _statusColor(tx.status),
                            ),
                            title: Text('₦${tx.amount.toStringAsFixed(2)}'),
                            subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                            trailing: Text(tx.status.name.toUpperCase()),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
