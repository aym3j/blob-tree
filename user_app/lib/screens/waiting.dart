import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "package:user_app/constants.dart";

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            "Merci pour votre réponse",
            style: TextStyle(fontSize: 60, fontFamily: "Lobster"),
          ),
        ),
      ),
    );
  }
}
