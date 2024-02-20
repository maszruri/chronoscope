import 'dart:convert';

import 'package:chronoscope/models/register_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<RegisterResponse> sendRegisterRequest(
    String name, String email, String password) async {
  var response = await http.post(Uri.parse(dotenv.env['REGISTER_URL']!),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }));
  return RegisterResponse.fromJson(json.decode(response.body));
}
