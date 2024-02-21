import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/constants/slogan.dart';
import 'package:chronoscope/providers/home_provider.dart';
import 'package:chronoscope/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoading = false;
  bool isLogged = false;
  int animateTextKey = 0;

  Future checkLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null &&
        prefs.getString('token')!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    checkLogged().then((value) {
      isLogged = value;
      if (value) {
        context.read<HomeProvider>().fetchStories();
      }
    });

    context.read<SplashProvider>().slogan =
        slogans[Random().nextInt(slogans.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primaryColor,
        alignment: Alignment.center,
        child: AnimatedOpacity(
          opacity: context.watch<SplashProvider>().opacity,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: 50,
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 300),
                  isRepeatingAnimation: false,
                  key:
                      Key("${context.watch<SplashProvider>().animatedTextKey}"),
                  onFinished: () {
                    if (isLoading) {
                      final provider = context.read<SplashProvider>();
                      provider.increaseKey();
                      provider.shuffleSlogan();
                    } else {
                      context.read<SplashProvider>().decreaseOpacity();
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () {
                          if (isLogged) {
                            context.go('/');
                          } else {
                            context.go('/login');
                          }
                        },
                      );
                    }
                  },
                  animatedTexts: context
                      .watch<SplashProvider>()
                      .slogan
                      .map((e) => RotateAnimatedText("$e",
                          duration: const Duration(seconds: 1),
                          textStyle: const TextStyle(
                            color: accentColor,
                            fontSize: 30,
                            fontFamily: 'PlayfairDisplay',
                          )))
                      .toList(),
                ),
              ),
              const Text(
                "Be Chronoscoped.",
                style: TextStyle(
                  color: accentColor,
                  fontSize: 30,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
