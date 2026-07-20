import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/domain/models/product_model.dart';
import 'package:shop_app/ui/widgets/shopcard.dart';

import '../domain/viewmodels/PanierNorifier.dart';
import '../domain/viewmodels/favoriteNotifier.dart';

class Detail extends ConsumerWidget {
  final ProductModel produit;
  const Detail({super.key, required this.produit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite=ref.watch(FavoriteProvider);
    final isFavorite=ref.watch(FavoriteProvider.notifier).isFavorite(produit);
    final card=ref.watch(PanierProvider);
    final isCard=ref.watch(PanierProvider.notifier).isCard(produit);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details du Produits"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [
          Shopcard()
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd:Radius.circular(20),
                      bottomStart:Radius.circular(20),
                    )
                ),
                child: Image.network(
                  produit.image,
                ),
              ),
              Positioned(
                left: 10,
                  bottom: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("${produit.price} CFA",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  )
              ),
                Positioned(
                    right: 5,
                    top: 15,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color:Colors.black,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: IconButton(
                          onPressed: (){
                            ref.read(FavoriteProvider.notifier).ToggleFavorite(produit);
                          },
                          icon: Icon(Icons.favorite,
                            size: 30,
                            color: isFavorite?Colors.red:Colors.white,
                          )),
                    )
                )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(produit.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
                Divider(height: 20,),
                Text("Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    color: Colors.deepOrange
                  ),
                ),
                SizedBox(height: 10,),
                Text(produit.description,
                  style: TextStyle(
                      fontSize:16
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        color: Colors.deepOrange
                      ),
                    ),
                    Text(produit.category,
                      style: TextStyle(
                          fontSize:18
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:BottomAppBar(
        color: Colors.deepOrange,
        child: Expanded(
            child: ElevatedButton(
                onPressed: (){
                  ref.read(PanierProvider.notifier).ToggleCard(produit);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
                child:Text(
                    isCard?"Retirer du panier":"Ajouter au panier",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepOrange
                  ),
                )
            )
        ),
      ),
    ) ;
  }
}
