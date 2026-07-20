import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shop_app/domain/models/product_model.dart';
import '../dto/product_dto.dart';
import '../repository/repository.dart';

class ServiceApi implements Repository{
  @override
  Future<List<ProductModel>> getProducts() async {
    final baseUrl="https://fakestoreapi.com/products";
    final dio = Dio();
    final response= await dio.get(baseUrl);
    if(response.statusCode==200){
      final data=response.data;
      final resp= (data as List).map((e) => ProductDto.fromJson(e).toModel()).toList();
      return resp;
    }
    throw Exception("Erreur lors de la récupération des données du serveur");
  }
}