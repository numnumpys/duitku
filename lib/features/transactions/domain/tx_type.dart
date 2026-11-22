/// Jenis transaksi: pemasukan atau pengeluaran.
enum TxType {
  income,
  expense;

  String get label => this == TxType.income ? 'Pemasukan' : 'Pengeluaran';

  static TxType fromName(String name) =>
      TxType.values.firstWhere((t) => t.name == name);
}
