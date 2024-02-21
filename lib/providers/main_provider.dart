import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;
  changeIndex(int index) {
    _navigationIndex = index;
    notifyListeners();
  }
}
