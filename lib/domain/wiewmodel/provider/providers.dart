import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../models/product.dart';
import '../../repositories/i_product_repository.dart';

// 1. SharedPreferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// 2. Repository Provider
final productRepositoryProvider = Provider<IProductRepository>((ref) {
  return ProductRepositoryImpl();
});

// 3. Products Provider
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

// 4. Product Detail Provider
final productDetailProvider = FutureProvider.family<Product?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
});

// 5. User Profile Provider
class UserProfile {
  final String name;
  final String email;
  final String avatarUrl;
  UserProfile({required this.name, required this.email, required this.avatarUrl});
}

final userProfileProvider = Provider<UserProfile>((ref) {
  return UserProfile(
    name: 'Justin Draoude',
    email: 'justin@poke.com',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Justin',
  );
});
