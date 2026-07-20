import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_app/domain/models/product_model.dart';

class FavoriteNotifier extends Notifier<List<ProductModel>>{
  @override
  List<ProductModel> build() {
    return [];
  }

  void ToggleFavorite(ProductModel product){
    if(isFavorite(product)){
      RemoveFavorite(product);
    }else{
      AddFavorite(product);
    }
  }
  void AddFavorite(ProductModel product){
    state=[...state,product];
  }
  void RemoveFavorite(ProductModel product){
    state=state.where((element) => element.id!=product.id).toList();
  }
  bool isFavorite(ProductModel product){
    return state.any((element) => element.id==product.id);
  }
  void ClearFavorite(){
    state=[];
  }

}

final FavoriteProvider=NotifierProvider<FavoriteNotifier,List<ProductModel>>(FavoriteNotifier.new);