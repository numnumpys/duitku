import '../../transactions/domain/tx_type.dart';
import '../domain/category.dart';

/// Kategori bawaan. Mulai Hari 4 kategori bisa ditambah/diubah pengguna.
const List<Category> defaultCategories = [
  Category(
    id: 'cat-makan',
    name: 'Makan & Minum',
    type: TxType.expense,
    iconKey: 'restaurant',
    colorValue: 0xFFFF7043,
  ),
  Category(
    id: 'cat-transport',
    name: 'Transport',
    type: TxType.expense,
    iconKey: 'directions_bus',
    colorValue: 0xFF42A5F5,
  ),
  Category(
    id: 'cat-kuliah',
    name: 'Kuliah',
    type: TxType.expense,
    iconKey: 'school',
    colorValue: 0xFF7E57C2,
  ),
  Category(
    id: 'cat-belanja',
    name: 'Belanja',
    type: TxType.expense,
    iconKey: 'shopping_bag',
    colorValue: 0xFFEC407A,
  ),
  Category(
    id: 'cat-hiburan',
    name: 'Hiburan',
    type: TxType.expense,
    iconKey: 'sports_esports',
    colorValue: 0xFF26A69A,
  ),
  Category(
    id: 'cat-tagihan',
    name: 'Tagihan',
    type: TxType.expense,
    iconKey: 'receipt_long',
    colorValue: 0xFF8D6E63,
  ),
  Category(
    id: 'cat-uang-saku',
    name: 'Uang Saku',
    type: TxType.income,
    iconKey: 'wallet',
    colorValue: 0xFF2E9E6B,
  ),
  Category(
    id: 'cat-gaji',
    name: 'Kerja Sampingan',
    type: TxType.income,
    iconKey: 'work',
    colorValue: 0xFF66BB6A,
  ),
  Category(
    id: 'cat-hadiah',
    name: 'Hadiah',
    type: TxType.income,
    iconKey: 'card_giftcard',
    colorValue: 0xFFFFA726,
  ),
];
