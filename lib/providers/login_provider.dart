import 'package:chronoscope/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoginSaved = false;
  bool isLoading = false;
  bool isError = true;
  String message = "";
  dynamic response;

  changeLoginSaved(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoginSaved', value);
    isLoginSaved = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();
    sendLoginRequest(email, password).then((value) {
      isError = value.error!;
      message = value.message!;
      response = value;
      if (value.error!) {
        print(message);
      } else {
        prefs.setString('userId', value.loginResult!.userId!);
        prefs.setString('token', value.loginResult!.token!);
      }
    });
    isLoading = false;
    notifyListeners();
  }
}
