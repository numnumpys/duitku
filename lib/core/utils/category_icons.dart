import 'package:flutter/material.dart';

/// Daftar ikon yang boleh dipakai kategori. Tambah sendiri sesuai kebutuhan.
const Map<String, IconData> categoryIcons = {
  'restaurant': Icons.restaurant,
  'directions_bus': Icons.directions_bus,
  'school': Icons.school,
  'shopping_bag': Icons.shopping_bag,
  'sports_esports': Icons.sports_esports,
  'receipt_long': Icons.receipt_long,
  'wallet': Icons.account_balance_wallet,
  'work': Icons.work,
  'card_giftcard': Icons.card_giftcard,
  'category': Icons.category,
};

IconData iconFromKey(String key) => categoryIcons[key] ?? Icons.category;
