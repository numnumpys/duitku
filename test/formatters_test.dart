import 'package:duitku/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatRupiah memakai titik sebagai pemisah ribuan', () {
    // Sebagian versi intl memakai spasi non-breaking; samakan dulu.
    String norm(String s) => s.replaceAll(' ', ' ');

    expect(norm(formatRupiah(15000)), 'Rp 15.000');
    expect(norm(formatRupiah(1500000)), 'Rp 1.500.000');
    expect(norm(formatRupiah(0)), 'Rp 0');
  });

  test('firstDayOfMonth mengembalikan tanggal 1 jam 00:00', () {
    expect(firstDayOfMonth(DateTime(2026, 11, 21, 15, 45)), DateTime(2026, 11));
  });
}
