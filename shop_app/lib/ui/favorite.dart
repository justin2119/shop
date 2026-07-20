import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/viewmodels/favoriteNotifier.dart';

class Favorite extends ConsumerWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite=ref.watch(FavoriteProvider);
    final itemCount=favorite.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoris"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(onPressed: (){
            ref.read(FavoriteProvider.notifier).ClearFavorite();
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final produit = favorite[index];
                  return ListTile(
                    onTap: (){
                      context.push(
                          "/detail",
                          extra: produit
                      );
                    },
                    leading: SizedBox(
                      width: 100,
                      height: 200,
                      child: Image.network(
                          produit.image,
                          fit: BoxFit.cover
                      ),
                    ), title: Text(produit.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                    trailing: IconButton(onPressed: (){
                      ref.read(FavoriteProvider.notifier).RemoveFavorite(produit);
                    }, icon: Icon(Icons.delete)),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: itemCount
            ),
          ),
        ],
      )
    ) ;
  }
}
