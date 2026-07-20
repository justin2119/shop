import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProductSortType {
  none,
  priceAsc,
  priceDesc,
  nameAsc,
}

class ProductFilterState {
  final String category;
  final ProductSortType sortType;
  final String searchQuery;

  ProductFilterState({
    this.category = 'Tous',
    this.sortType = ProductSortType.none,
    this.searchQuery = '',
  });

  ProductFilterState copyWith({
    String? category,
    ProductSortType? sortType,
    String? searchQuery,
  }) {
    return ProductFilterState(
      category: category ?? this.category,
      sortType: sortType ?? this.sortType,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final productFilterProvider = StateProvider<ProductFilterState>((ref) => ProductFilterState());
