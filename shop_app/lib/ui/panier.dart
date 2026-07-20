import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/viewmodels/PanierNorifier.dart';

class PanierCard extends ConsumerWidget {
  const PanierCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart=ref.watch(PanierProvider);
    final itemCount=cart.length;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        title: Text("Panier",),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index){
                  final product=cart[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 100,
                      height: 200,
                      child: Image.network(
                          product.image,
                          fit: BoxFit.cover
                      ),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        Text("${product.price.toString()} CFA",),
                        IconButton(onPressed: (){
                          ref.read(PanierProvider.notifier).RemoveCard(product);
                        }, icon: Icon(Icons.delete))
                      ]
                    ),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){}, icon:Icon(Icons.remove_circle)),
                        Text("1"),
                        IconButton(onPressed: (){}, icon:Icon(Icons.add_circle)),
                      ]
                    )
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: itemCount
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepOrange,
        child: Expanded(
          child: Text("Total : ",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white
            )
          ),
        )
      ),
    );
  }
}
