import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/domain/models/product_model.dart';

class PanierNorifier extends Notifier<List<ProductModel>> {
  @override
  List<ProductModel> build() {
    return [];
  }
  void ToggleCard(ProductModel product){
    if(isCard(product)){
      RemoveCard(product);
    }else{
      AddCard(product);
    }
  }
  void AddCard(ProductModel product){
    state =[...state,product];
  }
  void RemoveCard(ProductModel product) {
    state = state.where((element) => element.id != product.id).toList();
  }
  bool isCard(ProductModel product){
    return state.any((element) => element.id==product.id);
  }
  void addProduct(ProductModel product){
  }
}

final PanierProvider=NotifierProvider<PanierNorifier,List<ProductModel>>(
    PanierNorifier.new
);