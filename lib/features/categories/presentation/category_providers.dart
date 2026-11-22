import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/default_categories.dart';
import '../domain/category.dart';

/// Daftar kategori. Sementara dari data bawaan; Hari 4 diganti repository.
final categoriesProvider = Provider<List<Category>>((ref) => defaultCategories);

/// Akses cepat kategori berdasarkan id.
final categoryByIdProvider = Provider<Map<String, Category>>((ref) {
  final categories = ref.watch(categoriesProvider);
  return {for (final c in categories) c.id: c};
});
