import 'package:shop_app/domain/models/product_model.dart';

/// Représente un élément du panier.
/// On stocke :
/// - le produit
/// - la quantité de ce produit dans le panier
class CartItem {
  final ProductModel product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  /// Permet de créer une nouvelle instance
  /// en modifiant seulement certaines propriétés.
  ///
  /// Exemple :
  /// item.copyWith(quantity: 3)
  CartItem copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}