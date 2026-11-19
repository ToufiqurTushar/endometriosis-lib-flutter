import 'package:flutter/material.dart';

import '../method/utils.dart';


extension StringExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
  String trDigit() => Utils.isLocaleEn()?this: Utils.getDigitBanglaFromEnglish(this)??"";
}