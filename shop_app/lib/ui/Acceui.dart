import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/viewmodels/Notifier_product/product_notifier.dart';

class Acceuil extends ConsumerWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service=ref.watch(ProductProvider);
    print(service.getProducts());
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
      ),
    ) ;
  }
}
