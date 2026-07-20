
import 'package:go_router/go_router.dart';
import 'package:shop_app/domain/models/product_model.dart';

import '../ui/Acceui.dart';
import '../ui/Profil.dart';
import '../ui/detail.dart';
import '../ui/favorite.dart';
import '../ui/panier.dart';

final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context,state) => Acceuil(),
      ),
      GoRoute(
        path: "/detail",
        builder: (context,state){
          final product= state.extra as ProductModel;
          return Detail(produit: product,);
        },
      ),
      GoRoute(
        path: "/favorite",
        builder:(context, state) =>const Favorite(),
      ),
      GoRoute(
        path: "/panier",
        builder:(context, state) =>const PanierCard(),
      ),
      GoRoute(
        path: "/profil",
        builder:(context, state) =>const Profil(),
      ),
    ]
);