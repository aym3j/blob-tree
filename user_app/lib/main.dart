import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:user_app/screens/home.dart";
import "package:user_app/screens/form.dart";
import 'package:user_app/screens/thanks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => HomeScreen(),
      ),
      GoRoute(
        path: "/form",
        builder: (BuildContext context, GoRouterState state) => FormScreen(
          workshopName: state.extra as String,
        ),
      ),
      GoRoute(
        path: "/thanks",
        builder: (BuildContext context, GoRouterState state) => ThanksScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
    );
  }
}
