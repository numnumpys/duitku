import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/transaction_tile.dart';
import '../../categories/presentation/category_providers.dart';
import '../../reports/domain/monthly_summary.dart';
import '../../transactions/presentation/transaction_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(monthlySummaryProvider);
    final transactions = ref.watch(transactionsProvider);
    final categories = ref.watch(categoryByIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Duitku')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          summary.when(
            data: (s) => _SummaryCard(summary: s),
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text('Gagal memuat ringkasan: $e'),
          ),
          const SizedBox(height: 24),
          Text(
            'Transaksi terbaru',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          transactions.when(
            data: (list) {
              if (list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: Text('Belum ada transaksi.')),
                );
              }
              return Column(
                children: [
                  for (final tx in list.take(5))
                    TransactionTile(tx: tx, category: categories[tx.categoryId]),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Gagal memuat transaksi: $e'),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});

  final MonthlySummary summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo bulan ini', style: textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(
              formatRupiah(summary.balance),
              style: textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _Flow(
                    label: 'Pemasukan',
                    amount: summary.income,
                    color: AppColors.income,
                    icon: Icons.south_west,
                  ),
                ),
                Expanded(
                  child: _Flow(
                    label: 'Pengeluaran',
                    amount: summary.expense,
                    color: AppColors.expense,
                    icon: Icons.north_east,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Flow extends StatelessWidget {
  const _Flow({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  final String label;
  final int amount;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color.withAlpha(38),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              Text(
                formatRupiah(amount),
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
