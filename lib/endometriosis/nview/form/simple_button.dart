import 'package:flutter/material.dart';

import '../../../../config/color_config.dart';

Widget SimpleButton(String text, {VoidCallback? onPressed, EdgeInsetsGeometry? padding, TextStyle? style}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: ColorConfig.textFieldIconColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Padding(padding: padding??const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Text(text, style: style??const TextStyle(color: Colors.white, fontSize: 18))
      ),
    ),
  );
}

Widget SimpleWideButton(String text, {
  VoidCallback? onPressed,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
  Color? background,
  Color? iconColor,
  double? width,
  double? height,
  bool isEnable = true,
  bool? showIcon,
  IconData? iconData,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isEnable?background??ColorConfig.textFieldIconColor:ColorConfig.disableColor,
          elevation: 4,
          shadowColor: isEnable?background??ColorConfig.textFieldIconColor:ColorConfig.disableColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10)
      ),
      onPressed: () =>{
        if(isEnable && onPressed != null) {
          onPressed()
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(visible: showIcon??false, child: Icon(iconData??Icons.add, color: iconColor ?? ColorConfig.textFieldIconColor,)),
            Text(text, style: textStyle??TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    ),
  );
}

Widget FlexButton(String text, {int? flex, Color? background, TextStyle? textStyle, VoidCallback? onPressed}) {
  return Flexible(
      flex: flex??1,
      child: SimpleWideButton(text, background: background, textStyle: textStyle, onPressed:onPressed)
  );
}
