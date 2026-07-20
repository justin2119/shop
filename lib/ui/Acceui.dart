import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/ui/widgets/Drawers_side.dart';
import 'package:shop_app/ui/widgets/shopcard.dart';
import '../domain/viewmodels/filtered_products_provider.dart';
import '../domain/viewmodels/filter_provider.dart';

class Acceuil extends ConsumerWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(filteredProductsProvider);
    final filter = ref.watch(productFilterProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF263238),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF263238),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "DOKU SHOP",
          style: GoogleFonts.abel(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          const Shopcard(),
          IconButton(
            onPressed: () => _showFilterDialog(context, ref),
            icon: const Icon(Icons.filter_alt, color: Colors.white),
          ),
        ],
      ),
      drawer: const DrawersSide(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => ref.read(productFilterProvider.notifier).update((state) => state.copyWith(searchQuery: value)),
              style: GoogleFonts.abel(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Rechercher un produit...",
                hintStyle: GoogleFonts.abel(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (filter.category != 'Tous')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Chip(
                    label: Text(filter.category, style: GoogleFonts.abel(color: const Color(0xFF263238))),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    onDeleted: () => ref.read(productFilterProvider.notifier).update((state) => state.copyWith(category: 'Tous')),
                    deleteIconColor: const Color(0xFF263238),
                  ),
                ],
              ),
            ),
          Expanded(
            child: data.when(
              data: (products) => products.isEmpty 
                ? Center(child: Text("Aucun produit trouvé", style: GoogleFonts.abel(color: Colors.white)))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        onTap: () => context.push("/detail", extra: product),
                        leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(product.image, fit: BoxFit.cover),
                        ),
                        title: Text(
                          product.title,
                          style: GoogleFonts.abel(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          product.description,
                          style: GoogleFonts.abel(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          "${product.price.toString()} CFA",
                          style: GoogleFonts.abel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                    itemCount: products.length,
                  ),
              error: (error, stackTrace) => Center(child: Text(error.toString(), style: const TextStyle(color: Colors.red))),
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.read(productFilterProvider);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF263238),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TRIER PAR",
                style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2),
              ),
              const SizedBox(height: 16),
              _buildSortOption(ref, "Prix croissant", ProductSortType.priceAsc),
              _buildSortOption(ref, "Prix décroissant", ProductSortType.priceDesc),
              _buildSortOption(ref, "Nom (A-Z)", ProductSortType.nameAsc),
              const Divider(color: Colors.white24, height: 32),
              Text(
                "CATÉGORIES",
                style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  _buildCategoryChip(ref, "Tous"),
                  _buildCategoryChip(ref, "electronics"),
                  _buildCategoryChip(ref, "jewelery"),
                  _buildCategoryChip(ref, "men's clothing"),
                  _buildCategoryChip(ref, "women's clothing"),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(WidgetRef ref, String label, ProductSortType type) {
    final currentType = ref.watch(productFilterProvider).sortType;
    return ListTile(
      title: Text(label, style: GoogleFonts.abel(color: Colors.white)),
      trailing: currentType == type ? const Icon(Icons.check, color: Colors.white) : null,
      contentPadding: EdgeInsets.zero,
      onTap: () {
        ref.read(productFilterProvider.notifier).update((state) => state.copyWith(sortType: type));
        Navigator.pop(ref.context);
      },
    );
  }

  Widget _buildCategoryChip(WidgetRef ref, String category) {
    final currentCategory = ref.watch(productFilterProvider).category;
    final isSelected = currentCategory == category;
    return ChoiceChip(
      label: Text(category, style: GoogleFonts.abel(color: isSelected ? const Color(0xFF263238) : Colors.white)),
      selected: isSelected,
      selectedColor: Colors.white,
      backgroundColor: Colors.white10,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      onSelected: (selected) {
        if (selected) {
          ref.read(productFilterProvider.notifier).update((state) => state.copyWith(category: category));
          Navigator.pop(ref.context);
        }
      },
    );
  }
}
