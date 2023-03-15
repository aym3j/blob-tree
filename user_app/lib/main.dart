import "package:flutter/material.dart";
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/login.dart';
import 'package:user_app/screens/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app/screens/waiting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => LoginScreen(),
        routes: [
          GoRoute(
            path: "signup",
            builder: (BuildContext context, GoRouterState state) =>
                SignUpScreen(),
          )
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => HomeScreen(),
      ),
      GoRoute(
        path: '/waiting',
        builder: (BuildContext context, GoRouterState state) => WaitingScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
