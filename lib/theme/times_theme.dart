import 'package:flutter/material.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';

class TimesTheme {
  static ThemeData get light {
    return ThemeData(
        primaryColor: TimesColor.orange,
        primarySwatch: MaterialColor(TimesColor.orange.value, {
          50: TimesColor.orange.withOpacity(0.1),
          100: TimesColor.orange.withOpacity(0.2),
          200: TimesColor.orange.withOpacity(0.3),
          300: TimesColor.orange.withOpacity(0.4),
          400: TimesColor.orange.withOpacity(0.5),
          500: TimesColor.orange.withOpacity(0.6),
          600: TimesColor.orange.withOpacity(0.7),
          700: TimesColor.orange.withOpacity(0.8),
          800: TimesColor.orange.withOpacity(0.9),
          900: TimesColor.orange,
        }),
        brightness: Brightness.light,
        primaryTextTheme: TextTheme(
            bodyText1: TimesText.sansRegular14,
            headline4: TimesText.sansRegular20));
  }
}
