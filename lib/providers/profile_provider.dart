import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String name = "";
  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
  }

  Future getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = "${prefs.getString('name')}";
    notifyListeners();
    return name;
  }
}
