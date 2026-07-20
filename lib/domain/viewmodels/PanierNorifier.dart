import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/domain/models/CartItem.dart';
import 'package:shop_app/domain/models/product_model.dart';

class PanierNorifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }
  void AddProduct(ProductModel product){
    final index=state.indexWhere((element) => element.product.id==product.id);
    if(index!=-1) {
      final currentlindex=state[index];
      state=[
        for(int i=0; i<state.length;i++)
          i==index?currentlindex.copyWith(quantity: currentlindex.quantity+1):state[i]
      ];
    }else{
      state=[...state,CartItem(product: product, quantity: 1)];
    }
  }
  void RemoveProduct(ProductModel product){
    final index=state.indexWhere((element) => element.product.id==product.id);
    if (index==-1)return;
    final currentlindex=state[index];
    if (currentlindex.quantity>1) {
      state=[
        for(int i=0; i<state.length;i++)
          i==index?currentlindex.copyWith(quantity: currentlindex.quantity-1):state[i]
      ];
    }else{
      Remove(product);
    }
  }
  bool isCard(ProductModel product){
    return state.any((element) => element.product.id==product.id);
  }
  void ToggleCard(ProductModel product){
    if(isCard(product)){
      RemoveProduct(product);
    }else{
      AddProduct(product);
    }
  }
  void Remove(ProductModel product){
    state=state.where((element) => element.product.id!=product.id).toList();
  }
  int get TotalProduct{
    return state.fold(0, (previousValue, element) => previousValue+element.quantity);
  }
  double get TotalPrice{
    return state.fold(0, (previousValue, element) => previousValue+element.product.price*element.quantity);

  }
  void Clear(){
    state=[];
  }
}

final PanierProvider=NotifierProvider<PanierNorifier,List<CartItem>>(
    PanierNorifier.new
);