import 'dart:convert';

import 'package:chronoscope/models/stories_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<StoriesModel> getStories(var token) async {
  var response = await http.get(
    Uri.parse(dotenv.env['STORIES_URL']!),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200) {
    return StoriesModel.fromJson(json.decode(response.body));
  } else {
    throw Exception();
  }
}
