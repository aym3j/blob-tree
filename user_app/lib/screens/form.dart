import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:go_router/go_router.dart';
import 'package:user_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "package:http/http.dart" as http;

updateUser(int currentState, int futureState) async {
  final prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId");

  final response = await http.patch(
    Uri.parse(kUrl + "/api/users/" + userId!),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode({
      "currentState": currentState,
      "futureState": futureState,
    }),
  );
}

class FormScreen extends StatelessWidget {
  String? workshopName;
  FormScreen({super.key, this.workshopName});

  final _currentState = TextEditingController();
  final _futureState = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 48.0, 28.0, 0.0),
              child: Image.asset("assets/images/test_image.png"),
            ),
            Text(
              "Welcome to ${workshopName}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 32.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 200.0,
              child: TextField(
                controller: _currentState,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  LimitRange(1, 21),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Center(child: Text("Your current position")),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 200.0,
              child: TextField(
                controller: _futureState,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  LimitRange(1, 21),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: const Center(child: Text("Your future position")),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final bool formValide =
                    (_currentState.text != "") && (_futureState.text != "");

                if (!formValide) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("please fill all the fields"),
                  ));
                } else {
                  await updateUser(
                    int.parse(_currentState.text),
                    int.parse(_futureState.text),
                  );

                  context.go("/thanks");
                }
              },
              child: Container(
                height: 50.0,
                width: 200.0,
                child: Center(
                  child: Text(
                    "Submit you anwser",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '')
      return newValue;
    else if (int.parse(newValue.text) < minRange) {
      return TextEditingValue().copyWith(text: minRange.toString());
      ;
    } else if (int.parse(newValue.text) > maxRange) {
      return TextEditingValue().copyWith(text: maxRange.toString());
    }
    return newValue;
  }
}
