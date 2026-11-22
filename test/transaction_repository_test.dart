import 'package:duitku/features/transactions/data/transaction_repository.dart';
import 'package:duitku/features/transactions/domain/app_transaction.dart';
import 'package:duitku/features/transactions/domain/tx_type.dart';
import 'package:flutter_test/flutter_test.dart';

AppTransaction _tx(String id, DateTime date, {int amount = 10000}) {
  return AppTransaction(
    id: id,
    categoryId: 'cat-makan',
    amount: amount,
    date: date,
    type: TxType.expense,
  );
}

void main() {
  test('add menambah transaksi dan fetchAll mengurutkan terbaru dulu', () async {
    final repo = InMemoryTransactionRepository();

    await repo.add(_tx('lama', DateTime(2026, 11, 1)));
    await repo.add(_tx('baru', DateTime(2026, 11, 20)));

    final list = await repo.fetchAll();
    expect(list.map((t) => t.id).toList(), ['baru', 'lama']);
  });

  test('update mengganti transaksi dengan id yang sama', () async {
    final repo = InMemoryTransactionRepository(
      seed: [_tx('a', DateTime(2026, 11, 1), amount: 10000)],
    );

    await repo.update(_tx('a', DateTime(2026, 11, 1), amount: 99000));

    final list = await repo.fetchAll();
    expect(list.single.amount, 99000);
  });

  test('delete menghapus transaksi', () async {
    final repo = InMemoryTransactionRepository(
      seed: [_tx('a', DateTime(2026, 11, 1)), _tx('b', DateTime(2026, 11, 2))],
    );

    await repo.delete('a');

    final list = await repo.fetchAll();
    expect(list.map((t) => t.id).toList(), ['b']);
  });

  test('seed tidak ikut berubah saat repository dimodifikasi', () async {
    final seed = [_tx('a', DateTime(2026, 11, 1))];
    final repo = InMemoryTransactionRepository(seed: seed);

    await repo.add(_tx('b', DateTime(2026, 11, 2)));

    expect(seed.length, 1);
  });
}
