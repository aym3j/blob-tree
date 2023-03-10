import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "package:user_app/constants.dart";

signUp(String fname, String lname, String email, String password) async {
  final response = await http.post(
    Uri.parse(kUrl + "/api/user/register"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      "nom": lname,
      "prenom": fname,
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 201) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.headers["auth-token"]!);
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String fname = "";

  String lname = "";

  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Screen"),
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
                size: 50,
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
                labelText: "First Name",
              ),
              onChanged: (value) {
                setState(() {
                  fname = value;
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: "Last Name",
              ),
              onChanged: (value) {
                setState(() {
                  lname = value;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
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
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
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
              child: const Text("Sign Up"),
              onPressed: () async {
                await signUp(fname, lname, email, password);

                final prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString("token");

                if (token != null) {
                  context.go("/landing");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
