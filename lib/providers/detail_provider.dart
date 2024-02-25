import 'package:chronoscope/models/story_model.dart';
import 'package:chronoscope/services/story_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProvider extends ChangeNotifier {
  String token = "";
  bool isLoading = true;
  StoryModel? storyModel;

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('token');
  }

  fetchDetail(String id) {
    isLoading = true;
    notifyListeners();
    getToken().then((value) {
      token = value;
      notifyListeners();
    }).whenComplete(() => detailStory(token, id).then((value) {
          storyModel = value;
          notifyListeners();
        }).whenComplete(() {
          isLoading = false;
          notifyListeners();
        }));
  }
}
