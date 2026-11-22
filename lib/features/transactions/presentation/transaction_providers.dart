import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reports/domain/monthly_summary.dart';
import '../data/transaction_repository.dart';
import '../domain/app_transaction.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return InMemoryTransactionRepository(seed: demoTransactions());
});

class TransactionsNotifier extends AsyncNotifier<List<AppTransaction>> {
  TransactionRepository get _repo => ref.read(transactionRepositoryProvider);

  @override
  Future<List<AppTransaction>> build() => _repo.fetchAll();

  Future<void> add(AppTransaction tx) async {
    await _repo.add(tx);
    state = AsyncData(await _repo.fetchAll());
  }

  Future<void> remove(String id) async {
    await _repo.delete(id);
    state = AsyncData(await _repo.fetchAll());
  }
}

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<AppTransaction>>(
  TransactionsNotifier.new,
);

/// Ringkasan bulan berjalan.
final monthlySummaryProvider = Provider<AsyncValue<MonthlySummary>>((ref) {
  final now = DateTime.now();
  return ref
      .watch(transactionsProvider)
      .whenData((list) => MonthlySummary.fromTransactions(list, now));
});
