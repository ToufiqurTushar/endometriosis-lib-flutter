
import 'package:endometriosis_lib_flutter/config/color_config.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

Future<void> showYesNoDialog({required String title, required Function onPressedYes,required Function onPressedNo}) async {
  return Get.dialog(
    AlertDialog(
      content: Text(title),
      actions: [
        TextButton(
          child: Text("label_no".tr, style: TextStyle(color: ColorConfig.textFieldIconColor),),
          onPressed: () => onPressedNo(),
        ),
        TextButton(
          child: Text("label_yes".tr, style: TextStyle(color: ColorConfig.textFieldIconColor),),
          onPressed: () => onPressedYes(),
        ),
      ],
    ),
  );
}