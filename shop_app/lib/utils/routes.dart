
import 'package:go_router/go_router.dart';

import '../ui/Acceui.dart';

final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context,state) => Acceuil(),
      ),
    ]
);