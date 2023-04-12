import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "package:user_app/constants.dart";

class ThanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "Thank you for your participation",
              style: TextStyle(fontSize: 60, fontFamily: "Lobster"),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go("/");
            },
            child: Text("Return to home"),
          ),
        ],
      ),
    );
  }
}
