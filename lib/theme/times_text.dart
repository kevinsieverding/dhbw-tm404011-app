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

  static TextStyle get sansRegular48 {
    return sansRegular14.copyWith(fontSize: 48);
  }

  static TextStyle get sansRegular64 {
    return sansRegular14.copyWith(fontSize: 64);
  }

  static TextStyle get sansBold64 {
    return sansRegular14.copyWith(fontSize: 64, fontWeight: FontWeight.w500);
  }

  static TextStyle get sansLight64 {
    return sansRegular14.copyWith(fontSize: 64, fontWeight: FontWeight.w300);
  }

  static TextStyle get sansLight48 {
    return sansLight64.copyWith(fontSize: 48);
  }
}
