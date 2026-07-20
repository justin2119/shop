import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/domain/models/product_model.dart';

class FavoriteNotifier extends Notifier<List<ProductModel>> {
  @override
  List<ProductModel> build() {
    _loadFavorites();
    return [];
  }

  Future<void> _loadFavorites() async {
    final favorites = await _getFavorite();
    state = favorites;
  }

  void ToggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      RemoveFavorite(product);
    } else {
      AddFavorite(product);
    }
  }

  Future<void> AddFavorite(ProductModel product) async {
    state = [...state, product];
    await _saveProduct(state);
  }

  Future<void> RemoveFavorite(ProductModel product) async {
    state = state.where((element) => element.id != product.id).toList();
    await _saveProduct(state);
  }

  bool isFavorite(ProductModel product) {
    return state.any((element) => element.id == product.id);
  }

  Future<void> ClearFavorite() async {
    state = [];
    await _saveProduct(state);
  }

  Future<void> _saveProduct(List<ProductModel> favorites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(
      favorites.map((e) => e.toJson()).toList(),
    );
    await prefs.setString("favoritekey", json);
  }

  Future<List<ProductModel>> _getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favoritekey");
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final FavoriteProvider = NotifierProvider<FavoriteNotifier, List<ProductModel>>(FavoriteNotifier.new);