import 'package:intl/intl.dart';

/// Format angka rupiah, contoh: 15000 -> "Rp 15.000".
String formatRupiah(int amount) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}

/// Format tanggal pendek, contoh: "21 Nov 2026".
String formatDate(DateTime date) {
  return DateFormat('d MMM yyyy', 'id_ID').format(date);
}

/// Mengembalikan tanggal 1 pada bulan yang sama (jam 00:00).
DateTime firstDayOfMonth(DateTime date) => DateTime(date.year, date.month);
