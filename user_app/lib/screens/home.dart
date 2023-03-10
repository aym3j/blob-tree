import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _dropdownValue;

  @override
  void initState() {
    print("tessssssssssst");
    super.initState();
  }

  void dropdownCallback(String? selectedValue) {
    setState(() {
      _dropdownValue = selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 32.0),
              ),
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
                DropdownButton(
                  value: _dropdownValue,
                  onChanged: dropdownCallback,
                  items: [
                    DropdownMenuItem(child: Text("Dash"), value: "Dash"),
                    DropdownMenuItem(child: Text("Snoo"), value: "Snoo"),
                    DropdownMenuItem(child: Text("Clippy"), value: "Clippy"),
                    DropdownMenuItem(child: Text("Sparky"), value: "Sparky"),
                  ],
                ),
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
                onPressed: () {},
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove("token");
                context.go("/login");
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
