import 'package:chronoscope/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RegisterProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String message = "";

  Future<void> registration(
      String name, String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool isOnline = await InternetConnectionChecker().hasConnection;

    if (isOnline) {
      sendRegisterRequest(name, email, password).then((value) {
        message = value.message;
        isError = value.error;
      }).whenComplete(() {
        final snackBar = SnackBar(content: Text(message));

        isLoading = false;
        notifyListeners();
        if (isError) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      isLoading = false;
      notifyListeners();
      if (!context.mounted) return;
      const snackBar = SnackBar(content: Text('No Internet Connection'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
