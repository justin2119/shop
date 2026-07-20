import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/viewmodels/PanierNorifier.dart';

class Shopcard extends ConsumerWidget {
  const Shopcard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart=ref.watch(PanierProvider);
    final count=cart.length;
    return Container(
      margin: EdgeInsets.all(5),
      child: Stack(
        children: [
          IconButton(onPressed: () {
            context.push("/panier");
          }, icon: Icon(
              Icons.shopping_cart,
          )),
          Positioned(
            right: 0,
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white
                ),
              )
          )
        ],
      ),
    );
  }
}
