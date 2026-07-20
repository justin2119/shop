import '../models/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getProductById(String id);
}
