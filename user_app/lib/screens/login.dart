import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/screens/signup.dart';
import "dart:convert";
import "package:http/http.dart" as http;

LogIn(String email, String password) async {
  final response = await http.post(
    Uri.parse(kUrl + "/api/user/login"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 201) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.headers["auth-token"]!);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: const Hero(
              tag: "flutter_logo",
              child: FlutterLogo(
                size: 80,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: "Email",
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: "Password",
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Log In"),
              onPressed: () async {
                await LogIn(email, password);

                final prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString("token");

                if (token != null) {
                  context.go("/home");
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You haven't any account",
                style: TextStyle(color: Colors.grey[600]),
              ),
              TextButton(
                onPressed: () => context.go("/signup"),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
