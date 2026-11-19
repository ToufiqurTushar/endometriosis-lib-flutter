import 'package:endometriosis_lib_flutter/endometriosis/nview/form/read_only_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../../dto/data.dart';
import '../item_label.dart';

Widget DropDown(Content content, context, GlobalKey form, {double elevation = 0, double padding = 0}) {
  if(content.readOnly) {
    return Visibility(visible: content.initialValue != null, child: ReadOnlyText(content, context, form, padding: padding, elevation: elevation));;
  }
  return Card(
    elevation: elevation,
    margin: EdgeInsets.all(0),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: ListBody(
          children: [
            if(content.label != null) ItemLabel(content),
            FormBuilderDropdown<String>(
              //enabled: parentCondition,
              initialValue: content.initialValue??'null',
              name: content.key!,
              items: [Data(value: 'null', labelEn: 'Select', labelBn: 'সিলেক্ট করুন'), ...content.options!].map((Data data) => DropdownMenuItem<String>(
                alignment: AlignmentDirectional.centerStart,
                value: data.value.toString(),
                child: Text(data.getLabel()??content.getHint(), style: TextStyle(color: data.value == 'null'? ColorConfig.textFieldHintColor: null),),
              )).toList(growable: false),
              decoration: InputDecoration(
                hintText: content.hint,
                hintStyle: TextStyle(color: ColorConfig.textFieldHintColor, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                fillColor: ColorConfig.textFieldColor,
                filled: true,
                isDense: true,
                prefix: const SizedBox(width: 8,),
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
              alignment:Alignment.topCenter,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (val) {

              },
              valueTransformer: content.valueTransformer,
              validator: content.required? FormBuilderValidators.compose([
                FormBuilderValidators.notEqual('null', checkNullOrEmpty: true, errorText: 'Select'.tr)
              ]) : null,
            ),
            if(content.description != null) Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(content.description!),
            ),
          ]
      ),
    ),
  );
}
