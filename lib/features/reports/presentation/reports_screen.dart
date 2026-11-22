import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/category_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../categories/presentation/category_providers.dart';
import '../../transactions/presentation/transaction_providers.dart';

/// Laporan sementara berbentuk daftar.
/// TODO (Hari 8): ganti dengan pie/bar chart (fl_chart).
class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(monthlySummaryProvider);
    final categories = ref.watch(categoryByIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan')),
      body: summary.when(
        data: (s) {
          final rows = s.expenseByCategory.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          if (rows.isEmpty) {
            return const Center(child: Text('Belum ada pengeluaran bulan ini.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Pengeluaran per kategori',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final row in rows)
                ListTile(
                  leading: Icon(
                    iconFromKey(categories[row.key]?.iconKey ?? 'category'),
                  ),
                  title: Text(categories[row.key]?.name ?? 'Tanpa kategori'),
                  trailing: Text(formatRupiah(row.value)),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat laporan: $e')),
      ),
    );
  }
}
