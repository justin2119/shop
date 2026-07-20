import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/ui/widgets/Drawers_side.dart';
import 'package:shop_app/ui/widgets/shopcard.dart';
import '../domain/viewmodels/product_notifier.dart';

class Acceuil extends ConsumerWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ProduitProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text("Doku Shop", style: TextStyle(fontSize: 25)),
        centerTitle: true,
        actions: [
          Shopcard(),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
        ],
      ),
      drawer: DrawersSide(),
      body:Column(
        children: [
         SizedBox(height: 10,),
          Expanded(
            child: data.when(
                data: (data) => IntrinsicHeight(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final product= data[index];
                        return ListTile(
                          onTap: (){
                            context.push(
                                "/detail",
                              extra: product
                            );
                          },
                          leading:SizedBox(
                            width: 100,
                            height: 200,
                            child: Image.network(
                                product.image,
                                fit: BoxFit.cover
                            ),
                          ),
                          title: Text(product.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing:Text(
                            "${product.price.toString()} CFA",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepOrange
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: data.length
                  ),
                ),
                error: (error, stackTrace) => Text(error.toString()),
                loading: ()=> Center(child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                )),
            ),
          ),
        ],
      )
    );
  }
}
