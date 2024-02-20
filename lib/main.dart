import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/pages/home_page.dart';
import 'package:chronoscope/pages/login_page.dart';
import 'package:chronoscope/pages/main_page.dart';
import 'package:chronoscope/pages/register_page.dart';
import 'package:chronoscope/pages/splash_page.dart';
import 'package:chronoscope/providers/login_provider.dart';
import 'package:chronoscope/providers/register_provider.dart';
import 'package:chronoscope/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const Chronoscope()));
}

GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const LoginPage(),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

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
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
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
