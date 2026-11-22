import 'tx_type.dart';

class AppTransaction {
  const AppTransaction({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.type,
    this.note,
  });

  final String id;
  final String categoryId;

  /// Nominal dalam rupiah. Pakai int, bukan double, supaya tidak ada
  /// kesalahan pembulatan.
  final int amount;
  final DateTime date;
  final TxType type;
  final String? note;

  AppTransaction copyWith({
    String? id,
    String? categoryId,
    int? amount,
    DateTime? date,
    TxType? type,
    String? note,
  }) {
    return AppTransaction(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      note: note ?? this.note,
    );
  }

  factory AppTransaction.fromJson(Map<String, dynamic> json) {
    return AppTransaction(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      amount: json['amount'] as int,
      date: DateTime.parse(json['date'] as String),
      type: TxType.fromName(json['type'] as String),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'amount': amount,
        'date': date.toIso8601String(),
        'type': type.name,
        'note': note,
      };
}
