import 'dart:convert';

import 'package:chronoscope/models/story_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<StoryModel> detailStory(var token, String id) async {
  var response = await http.get(
    Uri.parse("${dotenv.env['STORIES_URL']!}/$id"),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200) {
    return StoryModel.fromJson(json.decode(response.body));
  } else {
    throw Exception();
  }
}
