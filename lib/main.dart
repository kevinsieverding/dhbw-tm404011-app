import 'package:flutter/material.dart';
import 'package:times/home_page.dart';
import 'package:times/theme/times_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TimesTheme.light,
      home: const HomePage(),
    );
  }
}
