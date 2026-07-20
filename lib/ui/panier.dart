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
        title: Text("Panier ($itemCount)",),
        actions: [
          IconButton(onPressed: (){
            ref.read(PanierProvider.notifier).Clear();
          }, icon: Icon(Icons.delete)
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index){
                  final product=cart[index].product;
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
                          ref.read(PanierProvider.notifier).Remove(product);
                        }, icon: Icon(Icons.delete))
                      ]
                    ),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          ref.read(PanierProvider.notifier).RemoveProduct(product);
                        }, icon:Icon(Icons.remove_circle)),
                        Text(cart[index].quantity.toString()),
                        IconButton(onPressed: (){
                          ref.read(PanierProvider.notifier).AddProduct(product);
                        }, icon:Icon(Icons.add_circle)),
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
        child: Row(
          children: [
            Expanded(
              child: Text("Total : ${ref.watch(PanierProvider.notifier).TotalPrice.toString()} CFA",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                )
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                elevation:5
              ),
              child: Text("Payer",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange
                )
              )
            )
          ],
        )
      ),
    );
  }
}
