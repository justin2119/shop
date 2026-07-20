import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import 'product_notifier.dart';
import 'filter_provider.dart';

final filteredProductsProvider = Provider<AsyncValue<List<ProductModel>>>((ref) {
  final productsAsync = ref.watch(ProduitProvider);
  final filter = ref.watch(productFilterProvider);

  return productsAsync.whenData((products) {
    var filtered = products.where((p) {
      final matchesCategory = filter.category == 'Tous' || p.category == filter.category;
      final matchesSearch = p.title.toLowerCase().contains(filter.searchQuery.toLowerCase()) ||
                            p.description.toLowerCase().contains(filter.searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    switch (filter.sortType) {
      case ProductSortType.priceAsc:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortType.priceDesc:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortType.nameAsc:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProductSortType.none:
        break;
    }

    return filtered;
  });
});
