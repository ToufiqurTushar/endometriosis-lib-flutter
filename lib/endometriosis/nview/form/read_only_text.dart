import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../item_label.dart';

Widget ReadOnlyText(Content content, context, GlobalKey form, {double elevation = 0, double padding = 0, validators, keyboardType, inputFormatters}) {
  return Card(
    elevation: elevation,
    margin: EdgeInsets.all(0),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: ListBody(
          children: [
            if(content.label != null) ItemLabel(content),
            FormBuilderTextField(
              //enabled: parentCondition,
              initialValue: content.initialValue.toString(),
              readOnly: true,
              name: content.key!,
              decoration: InputDecoration(
                hintText: content.getHint(),
                hintStyle: const TextStyle(color: ColorConfig.textFieldHintColor, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                fillColor: ColorConfig.textFieldColor,
                prefix: const SizedBox(width: 8,),
                filled: true,
                isDense: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                ),
              ),
              keyboardType: keyboardType,
              inputFormatters: inputFormatters??[],
              style: const TextStyle(fontSize: 14),
            ),
          ]
      ),
    ),
  );
}
