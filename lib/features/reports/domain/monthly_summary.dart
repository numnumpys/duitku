import '../../transactions/domain/app_transaction.dart';
import '../../transactions/domain/tx_type.dart';

/// Ringkasan satu bulan. Dihitung dari daftar transaksi, tidak disimpan.
class MonthlySummary {
  const MonthlySummary({
    required this.income,
    required this.expense,
    required this.expenseByCategory,
  });

  final int income;
  final int expense;

  /// categoryId -> total pengeluaran di kategori itu.
  final Map<String, int> expenseByCategory;

  int get balance => income - expense;

  /// Hitung ringkasan untuk bulan yang sama dengan [month].
  factory MonthlySummary.fromTransactions(
    List<AppTransaction> all,
    DateTime month,
  ) {
    var income = 0;
    var expense = 0;
    final byCategory = <String, int>{};

    for (final tx in all) {
      final sameMonth = tx.date.year == month.year && tx.date.month == month.month;
      if (!sameMonth) continue;

      if (tx.type == TxType.income) {
        income += tx.amount;
      } else {
        expense += tx.amount;
        byCategory.update(
          tx.categoryId,
          (v) => v + tx.amount,
          ifAbsent: () => tx.amount,
        );
      }
    }

    return MonthlySummary(
      income: income,
      expense: expense,
      expenseByCategory: byCategory,
    );
  }
}
