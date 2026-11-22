class Budget {
  const Budget({
    required this.id,
    required this.categoryId,
    required this.month,
    required this.limitAmount,
  });

  final String id;
  final String categoryId;

  /// Selalu tanggal 1 pada bulan yang dimaksud.
  final DateTime month;
  final int limitAmount;

  Budget copyWith({
    String? id,
    String? categoryId,
    DateTime? month,
    int? limitAmount,
  }) {
    return Budget(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      month: month ?? this.month,
      limitAmount: limitAmount ?? this.limitAmount,
    );
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      month: DateTime.parse(json['month'] as String),
      limitAmount: json['limit_amount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'month': month.toIso8601String(),
        'limit_amount': limitAmount,
      };
}
