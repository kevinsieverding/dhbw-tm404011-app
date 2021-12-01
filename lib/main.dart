import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/model/highscore_model.dart';
import 'package:times/model/user_model.dart';
import 'package:times/theme/times_theme.dart';
import 'package:times/ui/page/game_over_page.dart';
import 'package:times/ui/page/game_page/game_page.dart';
import 'package:times/ui/page/home_page/home_page.dart';
import 'package:times/ui/page/landing_page.dart';
import 'package:times/ui/page/splash_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => HighscoreModel())
  ], child: const TimesApp()));
}

class TimesApp extends StatelessWidget {
  const TimesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Times - Einfach Rechnen Lernen!',
        theme: TimesTheme.light,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashPage(),
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/game': (context) => const GamePage(),
          '/game_over': (context) => const GameOverPage()
        });
  }
}
