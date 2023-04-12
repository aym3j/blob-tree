import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/constants.dart';
import "dart:convert";
import "package:http/http.dart" as http;

Future<bool> logIn(String pinCode) async {
  final prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId");

  userId ??= "New user";

  final response = await http.post(
    Uri.parse(kUrl + "/api/users/" + userId),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      "pinCode": pinCode,
    }),
  );

  if (response.statusCode == 200) {
    if (!jsonDecode(response.body)["submit"]) {
      await prefs.setString('userId', jsonDecode(response.body)["id"]);
      await prefs.setString(
        'workshop_id',
        jsonDecode(response.body)["workshopId"],
      );

      return true;
    }
  }

  return false;
}
