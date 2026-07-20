import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DrawersSide extends ConsumerWidget {
  const DrawersSide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    Icon(Icons.shop,
                      size: 50,
                      color: Colors.deepOrange,
                    ),
                    Text("Doku Markets",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
          ),
          ListTile(
            onTap: (){
              context.push("/favorite");
            },
            leading: Icon(Icons.favorite),
            title: Text("Favoris"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
         Divider(height: 5,thickness: 2,),
         ListTile(
           onTap: (){
             context.push("/panier");
           },
           leading: Icon(Icons.shopping_cart),
           title: Text("Panier"),
           trailing: Icon(Icons.arrow_forward_ios),
         ),
          Divider(height: 5,thickness: 2,),
          ListTile(
            onTap: (){
              context.push("/profil");
            },
            leading: Icon(Icons.person),
            title: Text("Profil"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(height: 5,thickness: 2,),
        ],
      )
    );
  }
}
