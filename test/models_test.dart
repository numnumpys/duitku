import 'package:duitku/features/budget/domain/budget.dart';
import 'package:duitku/features/categories/domain/category.dart';
import 'package:duitku/features/transactions/domain/app_transaction.dart';
import 'package:duitku/features/transactions/domain/tx_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppTransaction: toJson lalu fromJson menghasilkan data yang sama', () {
    final tx = AppTransaction(
      id: 'a1',
      categoryId: 'cat-makan',
      amount: 25000,
      date: DateTime(2026, 11, 21, 10, 30),
      type: TxType.expense,
      note: 'Makan siang',
    );

    final copy = AppTransaction.fromJson(tx.toJson());

    expect(copy.id, tx.id);
    expect(copy.categoryId, tx.categoryId);
    expect(copy.amount, tx.amount);
    expect(copy.date, tx.date);
    expect(copy.type, tx.type);
    expect(copy.note, tx.note);
  });

  test('AppTransaction: catatan boleh null', () {
    final tx = AppTransaction(
      id: 'a2',
      categoryId: 'cat-gaji',
      amount: 100000,
      date: DateTime(2026, 11, 1),
      type: TxType.income,
    );

    expect(AppTransaction.fromJson(tx.toJson()).note, isNull);
  });

  test('Category: toJson lalu fromJson', () {
    const cat = Category(
      id: 'c1',
      name: 'Kuliah',
      type: TxType.expense,
      iconKey: 'school',
      colorValue: 0xFF7E57C2,
    );

    final copy = Category.fromJson(cat.toJson());

    expect(copy.name, 'Kuliah');
    expect(copy.type, TxType.expense);
    expect(copy.iconKey, 'school');
    expect(copy.colorValue, 0xFF7E57C2);
  });

  test('Budget: toJson lalu fromJson dan copyWith', () {
    final budget = Budget(
      id: 'b1',
      categoryId: 'cat-makan',
      month: DateTime(2026, 11),
      limitAmount: 600000,
    );

    final copy = Budget.fromJson(budget.toJson());
    expect(copy.limitAmount, 600000);
    expect(copy.month, DateTime(2026, 11));

    expect(budget.copyWith(limitAmount: 700000).limitAmount, 700000);
    expect(budget.copyWith(limitAmount: 700000).categoryId, 'cat-makan');
  });

  test('TxType.fromName membaca nama enum', () {
    expect(TxType.fromName('income'), TxType.income);
    expect(TxType.fromName('expense'), TxType.expense);
  });
}
