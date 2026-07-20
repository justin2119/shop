


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/product_model.dart';
import 'Provider_product.dart';

class ProductNotifier extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() async {
    final data=ref.watch(productProvider);
    return data;
  }
}


final ProduitProvider=AsyncNotifierProvider<ProductNotifier,List<ProductModel>>(ProductNotifier.new);