import 'package:endometriosis_lib_flutter/config/color_config.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
ThemeData themeData = ThemeData(
    useMaterial3: false,
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: ColorConfig.textFieldIconColor, //icon color
      elevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 18, color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold),
    )
);
