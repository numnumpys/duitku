import '../domain/app_transaction.dart';
import '../domain/tx_type.dart';

/// Kontrak penyimpanan transaksi. Hari 2-5: ganti implementasi ke Supabase
/// tanpa mengubah layar, cukup ganti provider-nya.
abstract class TransactionRepository {
  Future<List<AppTransaction>> fetchAll();
  Future<void> add(AppTransaction tx);
  Future<void> update(AppTransaction tx);
  Future<void> delete(String id);
}

/// Implementasi sementara yang menyimpan data di memori.
class InMemoryTransactionRepository implements TransactionRepository {
  InMemoryTransactionRepository({List<AppTransaction>? seed})
      : _items = [...?seed];

  final List<AppTransaction> _items;

  @override
  Future<List<AppTransaction>> fetchAll() async {
    final copy = [..._items];
    copy.sort((a, b) => b.date.compareTo(a.date)); // terbaru dulu
    return copy;
  }

  @override
  Future<void> add(AppTransaction tx) async {
    _items.add(tx);
  }

  @override
  Future<void> update(AppTransaction tx) async {
    final index = _items.indexWhere((t) => t.id == tx.id);
    if (index == -1) return;
    _items[index] = tx;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((t) => t.id == id);
  }
}

/// Data contoh supaya tampilan tidak kosong saat pertama dijalankan.
/// Hapus saat backend sudah tersambung.
List<AppTransaction> demoTransactions() {
  final now = DateTime.now();
  DateTime daysAgo(int n) => DateTime(now.year, now.month, now.day - n);

  return [
    AppTransaction(
      id: 'demo-1',
      categoryId: 'cat-uang-saku',
      amount: 1500000,
      date: daysAgo(0),
      type: TxType.income,
      note: 'Kiriman bulanan',
    ),
    AppTransaction(
      id: 'demo-2',
      categoryId: 'cat-makan',
      amount: 25000,
      date: daysAgo(0),
      type: TxType.expense,
      note: 'Makan siang',
    ),
    AppTransaction(
      id: 'demo-3',
      categoryId: 'cat-transport',
      amount: 12000,
      date: daysAgo(1),
      type: TxType.expense,
    ),
    AppTransaction(
      id: 'demo-4',
      categoryId: 'cat-kuliah',
      amount: 85000,
      date: daysAgo(2),
      type: TxType.expense,
      note: 'Fotokopi modul',
    ),
  ];
}
