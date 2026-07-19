import 'package:shop_app/domain/models/product_model.dart';

class ProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
  ProductModel toModel(){
    return ProductModel(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image
    );
  }
}