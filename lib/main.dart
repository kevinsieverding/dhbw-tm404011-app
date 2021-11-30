import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/model/user_model.dart';
import 'package:times/theme/times_theme.dart';
import 'package:times/ui/game_page.dart';
import 'package:times/ui/home_page.dart';
import 'package:times/ui/landing_page.dart';
import 'package:times/ui/splash_page.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserModel())],
      child: const TimesApp()));
}

class TimesApp extends StatelessWidget {
  const TimesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Times - Einfach Rechnen Lernen!',
        theme: TimesTheme.light,
        initialRoute: '/landing',
        routes: {
          '/splash': (context) => const SplashPage(),
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/game': (context) => const GamePage()
        });
  }
}
