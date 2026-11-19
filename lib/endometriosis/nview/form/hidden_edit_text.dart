import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/common/rapid_preference_store.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../../dto/data.dart';
import '../item_label.dart';

Widget HiddenEditText(Content content, context, GlobalKey form) {
  return Offstage(
    child: FormBuilderTextField(
      //enabled: parentCondition,
      initialValue: content.initialValue.toString(),
      name: content.key!,
      valueTransformer: content.valueTransformer,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        isDense: true,
      ),
    ),
  );
}
