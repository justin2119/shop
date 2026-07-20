import '../../domain/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';

class ProductRepositoryImpl implements IProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return []; // Placeholder for actual data source
  }

  @override
  Future<Product?> getProductById(String id) async {
    return null;
  }
}
