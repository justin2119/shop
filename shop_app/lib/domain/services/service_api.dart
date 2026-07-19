import 'dart:convert';

import 'package:shop_app/domain/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../dto/product_dto.dart';
import '../repository/repository.dart';

class ServiceApi implements Repository{
  @override
  Future<List<ProductModel>> getProducts() async {
    final baseUrl="https://fakestoreapi.com/products";
    final response= await http.get(Uri.parse(baseUrl));
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      return data.cast(() => ProductDto.fromJson(data).toModel());
    }
    throw Exception("Erreur lors de la récupération des données du serveur");
  }
}