import 'dart:collection';

import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import '../../endometriosis/dto/data.dart';

class Utils {
  static bool isLocaleEn() {
    return Get.locale.toString() == 'en_US';
  }
  static String? getDigitBanglaFromEnglish(String? number) {
    var englishToBanglaDigitsMap = HashMap<String, String>();
    englishToBanglaDigitsMap["0"] = "০";
    englishToBanglaDigitsMap["1"] = "১";
    englishToBanglaDigitsMap["2"] = "২";
    englishToBanglaDigitsMap["3"] = "৩";
    englishToBanglaDigitsMap["4"] = "৪";
    englishToBanglaDigitsMap["5"] = "৫";
    englishToBanglaDigitsMap["6"] = "৬";
    englishToBanglaDigitsMap["7"] = "৭";
    englishToBanglaDigitsMap["8"] = "৮";
    englishToBanglaDigitsMap["9"] = "৯";

    if (number == null || number.isEmpty || number == "null") {
      return number;
    }
    var builder = "";
    try {
      for (var i = 0; i < number.length; i++) {
        if (englishToBanglaDigitsMap.containsKey(number[i].toString())) {
          builder += englishToBanglaDigitsMap[number[i].toString()].toString();
        } else {
          builder += number[i];
        }
      }
    } catch (e) {
      return null;
    }
    return builder.toString();
  }

  static Widget getImageAssetWidget(String image, {BoxFit? fit}) {
    return Image.asset('assets/images/endometriosis/$image', fit: fit, package: 'endometriosis_lib_flutter');
  }

  static List<int> getIntList({int min = 0, int max = 0}) {
    return List.generate(max - min + 1, (index) => min + index);
  }
  static List<Data> getAgeDataList(int min, int max) {
    return getIntList(min:min, max:max).map((i) => Data(labelEn: "${i} years",labelBn: "${(i).toString().trDigit()} বছর", value: i)).toList();
  }
}