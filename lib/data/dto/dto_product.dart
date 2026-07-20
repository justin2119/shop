import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/product.dart';

part 'dto_product.freezed.dart';
part 'dto_product.g.dart';

@freezed
class DtoProduct with _\$DtoProduct {
  const factory DtoProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required String categoryId,
    required String origin,
    required String conservationType,
  }) = _DtoProduct;

  factory DtoProduct.fromJson(Map<String, dynamic> json) => _\$DtoProductFromJson(json);

  const DtoProduct._();

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      categoryId: categoryId,
      origin: origin,
      conservationType: conservationType,
    );
  }
}
