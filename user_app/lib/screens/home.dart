import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app/constants.dart';
import "dart:convert";
import "package:http/http.dart" as http;

Future<List<String>> getWorkshops() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse(kUrl + "/workshops/active"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
  );

  if (response.statusCode == 200) {
    // print(List<String>.from(jsonDecode(response.body) as List));
    return List<String>.from(jsonDecode(response.body) as List);
  }
  return [];
}

updateUser(String workshopId, int currentState, int futureState) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  final response = await http.patch(
    Uri.parse(kUrl + "/api/user/"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "auth-token": token!,
    },
    body: jsonEncode({
      "workshopId": workshopId,
      "currentState": currentState,
      "futureState": futureState,
    }),
  );

  print(response);
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dropdownValue;
  late Future<List<String>> futureWorkshops;

  final _currentState = TextEditingController();
  final _futureState = TextEditingController();

  void dropdownCallback(String? selectedValue) {
    setState(() {
      _dropdownValue = selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    futureWorkshops = getWorkshops();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 48.0),
            Center(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 32.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Image.asset("assets/images/test_image.png"),
            ),
            SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Choisissez un workshop: ",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: 20.0),
                FutureBuilder<List<String>>(
                  future: futureWorkshops,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton(
                        value: _dropdownValue,
                        onChanged: dropdownCallback,
                        items: snapshot.data!
                            .map((workshop) => DropdownMenuItem(
                                child: Text(workshop), value: workshop))
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Quel est votre état actuel? : ",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 20.0),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _currentState,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      LimitRange(1, 21),
                    ],
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    onChanged: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "quel est votre état futur? : ",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 20.0),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _futureState,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      LimitRange(1, 21),
                    ],
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    onChanged: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Envoyer"),
                onPressed: () async {
                  final bool formValide = (_dropdownValue != null) &&
                      (_currentState.text != "") &&
                      (_futureState.text != "");

                  if (!formValide) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("please fill all the fields"),
                    ));
                  } else {
                    await updateUser(
                      _dropdownValue!,
                      int.parse(_currentState.text),
                      int.parse(_futureState.text),
                    );

                    context.go("/waiting");
                  }
                },
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove("token");
                context.go("/");
              },
              icon: Icon(Icons.logout),
              label: Text("Lougout"),
            ),
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
