import 'package:auto_size_text/auto_size_text.dart';
import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.person,
                size: 75,
              ),
            ),
            AutoSizeText(
              "Name",
              maxLines: 1,
              maxFontSize: 50,
              style: TextStyle(fontSize: 100),
            ),
            SubmitButton(
              text: "Logout",
              onPressed: () async {
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
