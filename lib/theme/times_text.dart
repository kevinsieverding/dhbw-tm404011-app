import 'dart:ui';

import 'package:flutter/material.dart';

class TimesText {
  static TextStyle get sansRegular14 {
    return const TextStyle(
        fontFamily: 'Noto',
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400);
  }

  static TextStyle get sansRegular20 {
    return sansRegular14.copyWith(fontSize: 20);
  }

  static TextStyle get sansLight64 {
    return sansRegular14.copyWith(fontSize: 64, fontWeight: FontWeight.w300);
  }
}
