import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primary = Color(0xFF0F796B);
  static const Color primaryDark = Color(0xFF075447);
  static const Color primaryLight = Color(0xFFE1F2F1);
  static const Color accent = Color(0xFFF09952);
  static const Color background = Color(0xFFF4FAF9);
  static const Color surface = Colors.white;
  static const Color darkText = Color(0xFF1F2A2E);
  static const Color greyText = Color(0xFF66787A);
  static const Color error = Color(0xFFC0392B);

  // Spacing
  static const double smallSpace = 8;
  static const double mediumSpace = 16;
  static const double bigSpace = 24;
  static const double hugeSpace = 48;

  static const Widget smallSeparator = SizedBox(width: smallSpace, height: smallSpace);
  static const Widget mediumSeparator = SizedBox(width: mediumSpace, height: mediumSpace);
  static const Widget bigSeparator = SizedBox(width: bigSpace, height: bigSpace);

  // Sizes
  static const double fieldRadius = 14;
  static const double statusIconSize = 64;

  // Text styles
  static const TextStyle statusTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkText,
  );
  static const TextStyle statusMessage = TextStyle(
    fontSize: 15,
    color: greyText,
    height: 1.4,
  );
  static const TextStyle placeName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: darkText,
  );
  static const TextStyle placeRegion = TextStyle(fontSize: 13, color: greyText);
  static const TextStyle resultsCount = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: greyText,
  );
}
