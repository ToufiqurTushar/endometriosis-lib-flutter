import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../../dto/data.dart';
import '../item_label.dart';

Widget SelectYearOrMonth(List<Content> contents, context, GlobalKey form, {double elevation = 0, double padding = 0}) {
  return Card(
    elevation: elevation,
    margin: const EdgeInsets.all(0),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: ListBody(
          children: [
            if(contents.first.label != null) ItemLabel(contents.first),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                          name: contents.first.key!,
                          initialValue: contents.first.initialValue,
                          decoration: InputDecoration(
                            hintText: contents.first.hint,
                            hintStyle: const TextStyle(color: ColorConfig.textFieldHintColor, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            fillColor: ColorConfig.textFieldColor,
                            prefix: SizedBox(width: 8,),
                            filled: true,
                            isDense: true,
                          ),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: const TextInputType.numberWithOptions(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: contents.first.required? FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'error_required'.tr),
                          ]): null
                      ),
                    ),
                    FormBuilderField<String>(
                        //enabled: parentCondition,
                        initialValue: contents[1].initialValue,
                        name: contents[1].key!,
                        builder: (FormFieldState field) {
                          return  Row(children: [
                            InkWell(
                              onTap:(){
                                field.didChange('year');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 4, right: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                color: field.value == null || field.value.toString().contains('year')? ColorConfig.textFieldIconColor: ColorConfig.textFieldColor,
                                width: 70,
                                child: Text('Year', textAlign: TextAlign.center, style: TextStyle(color: field.value.toString().contains('year')? Colors.white: null),),
                              ),
                            ),
                            InkWell(
                              onTap:(){
                                field.didChange('month');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                color: field.value.toString().contains('month')? ColorConfig.textFieldIconColor: ColorConfig.textFieldColor,
                                width: 70,
                                child: Text('Month', textAlign: TextAlign.center, style: TextStyle(color: field.value.toString().contains('month')? Colors.white: null),),
                              ),
                            )
                          ],);
                        }
                    ),
                  ],
                ),
              ],
            ),
            if(contents.first.description != null) Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(contents.first.description!),
            ),
          ]
      ),
    ),
  );
}