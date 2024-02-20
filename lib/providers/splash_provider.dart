import 'dart:math';

import 'package:chronoscope/constants/slogan.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  int _animateTextKey = 0;
  int get animatedTextKey => _animateTextKey;
  double _opacity = 1.0;
  double get opacity => _opacity;
  List slogan = [];
  bool _isLogged = false;
  bool get isLogged => _isLogged;

  increaseKey() {
    _animateTextKey++;
    notifyListeners();
  }

  decreaseOpacity() {
    _opacity = 0.0;
    notifyListeners();
  }

  shuffleSlogan() {
    slogan = slogans[Random().nextInt(slogan.length)];
    notifyListeners();
  }
}
