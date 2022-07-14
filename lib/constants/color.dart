import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const black = Color(0xFF171e26);
  static const black2 = Color(0xFF1c2020);
  static const black3 = Color(0xFF1f2630);
}

Color getColor(String? color) {
  switch (color) {
    case "RED":
      return Colors.red;
    case "PINK_CUSTOM":
      return Color(0xfff78379).withOpacity(0.75);
    case "PINK":
      return Colors.pinkAccent.withOpacity(0.6);
    default:
      return Color(0xfff78379).withOpacity(0.8);
  }
}
