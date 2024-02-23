import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/detail_provider.dart';
import 'package:chronoscope/providers/go_router_provider.dart';
import 'package:chronoscope/providers/home_provider.dart';

import 'package:chronoscope/providers/login_provider.dart';
import 'package:chronoscope/providers/main_provider.dart';
import 'package:chronoscope/providers/profile_provider.dart';
import 'package:chronoscope/providers/register_provider.dart';
import 'package:chronoscope/providers/splash_provider.dart';
import 'package:chronoscope/providers/upload_provider.dart';
import 'package:chronoscope/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const Chronoscope()));
}

class Chronoscope extends StatelessWidget {
  const Chronoscope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', ''),
          Locale('en', ''),
        ],
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontFamily: 'OpenSans', color: accentColor),
          ),
          snackBarTheme:
              const SnackBarThemeData(behavior: SnackBarBehavior.floating),
          colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: accentColor,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
