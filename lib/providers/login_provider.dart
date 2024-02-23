import 'package:chronoscope/providers/home_provider.dart';
import 'package:chronoscope/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isObscure = true;

  String message = "";
  dynamic response;

  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<Map> restoreEmailPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.get('email');
    var password = prefs.get('password');
    return {'email': email, 'password': password};
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isOnline = await InternetConnectionChecker().hasConnection;

    if (isOnline) {
      sendLoginRequest(email, password).then((value) {
        isError = value.error!;
        message = value.message!;
        response = value;
        notifyListeners();

        if (!value.error!) {
          isError = value.error!;
          prefs.setString('token', value.loginResult!.token!);

          prefs.setString('userId', value.loginResult!.userId!);
          prefs.setString('name', value.loginResult!.name!);
          context.read<HomeProvider>().fetchStories();
        }
      }).whenComplete(() {
        final snackBar = SnackBar(content: Text(message));

        isLoading = false;
        notifyListeners();
        if (isError) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          context.go('/');
        }
      });
    } else {
      isLoading = false;
      notifyListeners();
      if (!context.mounted) return;
      const snackBar = SnackBar(
        content: Text('No Internet Connection'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
