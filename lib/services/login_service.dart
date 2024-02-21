import 'dart:convert';

import 'package:chronoscope/models/login_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<LoginResponse> sendLoginRequest(String email, String password) async {
  var response = await http.post(Uri.parse(dotenv.env['LOGIN_URL']!),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }));
  if (response.statusCode == 201) {
    return LoginResponse.fromJson(json.decode(response.body));
  } else {
    return LoginResponse.fromJson(json.decode(response.body));
  }
}
