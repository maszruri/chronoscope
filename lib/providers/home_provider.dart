import 'package:chronoscope/services/stories_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  dynamic storiesModel;
  String token = "";

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('token');
  }

  fetchStories() {
    isLoading = true;
    notifyListeners();
    getToken().then((value) => token = value).whenComplete(() =>
        getStories(token)
            .then((value) => storiesModel = value)
            .whenComplete(() {
          isLoading = false;
          notifyListeners();
        }));
  }
}
