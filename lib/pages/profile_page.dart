import 'package:auto_size_text/auto_size_text.dart';
import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/profile_provider.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileProvider>().getName();
    super.initState();
  }

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
              context.watch<ProfileProvider>().name,
              maxLines: 1,
              maxFontSize: 40,
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(height: 10),
            SubmitButton(
              text: AppLocalizations.of(context)!.logout,
              onPressed: () {
                context.read<ProfileProvider>().logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
