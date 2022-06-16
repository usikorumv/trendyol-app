import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static String api = "http://139.180.146.234:8000";
}

Future<String> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.api}/account/login/"),
    body: {
      "email": username,
      "password": password,
    },
  );
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  } else if (response.statusCode == 201 || response.statusCode == 200) {
    return jsonDecode(response.body.toString())["token"];
  }
  return "";
}

Future<bool> register(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.api}/account/register/"),
    body: {
      "email": username,
      "password": password,
      "password_confirmation": password,
    },
  );
  print(response.body);
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> confirmPassword(String username, String code) async {
  var response = await http.post(
    Uri.parse("${Api.api}/account/activate/"),
    body: {
      "email": username,
      "code": code,
    },
  );
  if (response.statusCode >= 300) throw UnimplementedError();
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}
