import 'package:endometriosis_lib_flutter/endometriosis/nview/form/read_only_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../item_label.dart';

Widget SelectDate(Content content, context, GlobalKey form, {double elevation = 0, double padding = 0, Function? onChanged}) {
  return Card(
    elevation: elevation,
    margin: const EdgeInsets.all(0),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: ListBody(
          children: [
            if(content.label != null) ItemLabel(content),
            FormBuilderField<DateTime>(
                //enabled: parentCondition,
                initialValue: content.initialValue,
                name: content.key!,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (val) {
                  if(onChanged != null) {
                    onChanged(val);
                  }
                },
                valueTransformer: content.valueTransformer,
                validator: content.required? FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Select'.tr)
                ]) : null,
                builder: (FormFieldState field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConfig.textFieldColor,
                            border: Border.all(
                                color: ColorConfig.textFieldHintColor,
                                width: 1.0
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(field.value != null ?  DateFormat("dd MMMM yyyy").format(field.value) : content.hint, style: TextStyle(color: field.value == null? ColorConfig.textFieldHintColor: null),),
                              const Icon(Icons.calendar_today, color: ColorConfig.textFieldIconColor,)
                            ],
                          ),
                        ),
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              dateFormat:'yyyy-MMMM-dd',
                              pickerTheme: DateTimePickerTheme.Default,
                              onMonthChangeStartWithFirstDate: true,
                              onConfirm: (DateTime dateTime, List<int> selectedIndex) => {
                                field.didChange(dateTime)
                              },
                              onChange: (DateTime dateTime, List<int> selectedIndex) => {
                                debugPrint("onChange$dateTime selectedIndex:$selectedIndex"),
                              },
                              maxDateTime: DateTime.now(),
                              pickerMode: DateTimePickerMode.date
                          );
                        },
                      ),
                      if(field.errorText != null) Text(field.errorText!, style: const TextStyle(color: Colors.red, fontSize: 12),),
                    ],
                  );
                },
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

// child: FormBuilderDateTimePicker(
//   //enabled: parentCondition,
//   initialValue: content.answer,
//   name: content.key!,
//   inputType: InputType.date,
//   lastDate: DateTime.now(),
//   decoration: const InputDecoration(
//     hintText: 'Select Date',
//     hintStyle: TextStyle(color: ColorConfig.textFieldHintColor),
//     border: InputBorder.none,
//     contentPadding: EdgeInsets.zero,
//     fillColor: ColorConfig.textFieldColor,
//     filled: true,
//     isDense: true,
//     suffixIcon: Icon(Icons.calendar_today, color: ColorConfig.textFieldIconColor,)
//   ),
//   textAlignVertical: TextAlignVertical.center,
//   style: TextStyle(),
//   autovalidateMode: AutovalidateMode.onUserInteraction,
//   onChanged: (val) {
//
//   },
//   validator: content.required? FormBuilderValidators.compose([
//     FormBuilderValidators.required(errorText: 'Select'.tr)
//   ]) : null,
// ),
