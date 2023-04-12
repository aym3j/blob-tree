import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import "package:flutter/services.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/constants.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "package:user_app/utils/auth.dart";

class CodePINScreen extends StatelessWidget {
  const CodePINScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 180),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0),
            child: Text(
              "Welcome to the blob tree test please select how do you want log into the workshop",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              autocorrect: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                label: const Center(child: Text("Insert Workshop Code...")),
              ),
              onChanged: (value) async {
                if (value.length == 4) {
                  bool exists = await logIn(value);

                  if (exists) {
                    final prefs = await SharedPreferences.getInstance();
                    String? workshopName = prefs.getString("workshop_id");
                    context.go("/form", extra: workshopName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("The workshop does not exists"),
                    ));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
