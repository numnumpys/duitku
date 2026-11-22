import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/transaction_tile.dart';
import '../../categories/presentation/category_providers.dart';
import 'transaction_providers.dart';

/// Daftar semua transaksi. Geser ke kiri untuk menghapus.
/// TODO (Hari 6): kelompok per tanggal, filter, dan pencarian.
class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final categories = ref.watch(categoryByIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: transactions.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('Belum ada transaksi.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 96),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final tx = list[i];
              return Dismissible(
                key: ValueKey(tx.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors.expense,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) =>
                    ref.read(transactionsProvider.notifier).remove(tx.id),
                child: TransactionTile(
                  tx: tx,
                  category: categories[tx.categoryId],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat transaksi: $e')),
      ),
    );
  }
}
