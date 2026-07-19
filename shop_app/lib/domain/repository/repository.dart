import 'package:shop_app/domain/models/product_model.dart';
abstract class Repository {
  Future<List<ProductModel>> getProducts();
}