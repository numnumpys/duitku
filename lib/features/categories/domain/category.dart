import '../../transactions/domain/tx_type.dart';

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.type,
    required this.iconKey,
    required this.colorValue,
  });

  final String id;
  final String name;
  final TxType type;

  /// Kunci ikon, dicocokkan ke `categoryIcons` di core/utils/category_icons.dart.
  /// Pakai kunci (bukan codePoint) supaya tree-shaking ikon tetap jalan di build rilis.
  final String iconKey;

  /// Warna dalam format ARGB, contoh 0xFF3D5AFE.
  final int colorValue;

  Category copyWith({
    String? id,
    String? name,
    TxType? type,
    String? iconKey,
    int? colorValue,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      iconKey: iconKey ?? this.iconKey,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      type: TxType.fromName(json['type'] as String),
      iconKey: json['icon_key'] as String,
      colorValue: json['color_value'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.name,
        'icon_key': iconKey,
        'color_value': colorValue,
      };
}
