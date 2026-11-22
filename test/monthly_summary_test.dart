import 'package:duitku/features/reports/domain/monthly_summary.dart';
import 'package:duitku/features/transactions/domain/app_transaction.dart';
import 'package:duitku/features/transactions/domain/tx_type.dart';
import 'package:flutter_test/flutter_test.dart';

AppTransaction _tx(
  String id,
  TxType type,
  int amount,
  DateTime date, {
  String category = 'cat-makan',
}) {
  return AppTransaction(
    id: id,
    categoryId: category,
    amount: amount,
    date: date,
    type: type,
  );
}

void main() {
  final nov = DateTime(2026, 11, 15);

  test('menghitung pemasukan, pengeluaran, dan saldo bulan itu', () {
    final list = [
      _tx('1', TxType.income, 1000000, DateTime(2026, 11, 1)),
      _tx('2', TxType.expense, 25000, DateTime(2026, 11, 3)),
      _tx('3', TxType.expense, 75000, DateTime(2026, 11, 20)),
    ];

    final s = MonthlySummary.fromTransactions(list, nov);

    expect(s.income, 1000000);
    expect(s.expense, 100000);
    expect(s.balance, 900000);
  });

  test('mengabaikan transaksi bulan atau tahun lain', () {
    final list = [
      _tx('1', TxType.expense, 50000, DateTime(2026, 10, 30)),
      _tx('2', TxType.expense, 60000, DateTime(2025, 11, 15)),
      _tx('3', TxType.expense, 10000, DateTime(2026, 11, 2)),
    ];

    final s = MonthlySummary.fromTransactions(list, nov);

    expect(s.expense, 10000);
  });

  test('mengelompokkan pengeluaran per kategori', () {
    final list = [
      _tx('1', TxType.expense, 20000, DateTime(2026, 11, 2)),
      _tx('2', TxType.expense, 30000, DateTime(2026, 11, 4)),
      _tx('3', TxType.expense, 15000, DateTime(2026, 11, 5),
          category: 'cat-transport'),
      _tx('4', TxType.income, 500000, DateTime(2026, 11, 1),
          category: 'cat-uang-saku'),
    ];

    final s = MonthlySummary.fromTransactions(list, nov);

    expect(s.expenseByCategory, {
      'cat-makan': 50000,
      'cat-transport': 15000,
    });
  });

  test('daftar kosong menghasilkan nol', () {
    final s = MonthlySummary.fromTransactions([], nov);

    expect(s.income, 0);
    expect(s.expense, 0);
    expect(s.balance, 0);
    expect(s.expenseByCategory, isEmpty);
  });
}
