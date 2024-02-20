import 'package:chronoscope/services/register_service.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = true;
  String message = "";

  registration(String name, String email, String password) {
    isLoading = true;
    notifyListeners();

    sendRegisterRequest(name, email, password).then((value) {
      message = value.message;
      isError = value.error;
    });

    isLoading = true;
    notifyListeners();
  }
}
