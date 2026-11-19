import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../../dto/data.dart';
import '../item_label.dart';

Widget SelectYearMonth(List<Content> contents, context, GlobalKey form, {double elevation = 0, double padding = 0}) {
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
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                              name: contents.first.key!,
                              initialValue: contents.first.initialValue,
                              decoration: InputDecoration(
                                hintText: contents.first.getHint(),
                                hintStyle: const TextStyle(color: ColorConfig.textFieldHintColor, fontSize: 14),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                fillColor: ColorConfig.textFieldColor,
                                prefix: const SizedBox(width: 8,),
                                filled: true,
                                isDense: true,
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: const TextInputType.numberWithOptions(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: contents.first.required ? FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'error_required'.tr),
                                ...contents.first.validators??[]
                              ]) : FormBuilderValidators.compose([
                                ...contents.first.validators??[]
                              ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          color: ColorConfig.textFieldIconColor,
                          width: 70,
                          child: Text(contents.first.getHint(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                              name: contents[1].key!,
                              initialValue: contents[1].initialValue,
                              decoration: InputDecoration(
                                hintText: contents[1].getHint(),
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
                              validator: contents[1].required? FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'error_required'.tr),
                                ...contents[1].validators??[]
                              ]) : FormBuilderValidators.compose([
                                ...contents[1].validators??[]
                              ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          color: ColorConfig.textFieldIconColor,
                          width: 70,
                          child: Text(contents[1].getHint(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: contents[2].key!,
                            initialValue: contents[2].initialValue,
                            decoration: InputDecoration(
                              hintText: contents[2].getHint(),
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
                            validator: contents[2].required? FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'error_required'.tr),
                              ...contents[2].validators??[]
                            ]) : FormBuilderValidators.compose([
                              ...contents[2].validators??[]
                            ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          color: ColorConfig.textFieldIconColor,
                          width: 70,
                          child: Text(contents[2].getHint(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if(contents.first.description != null) Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(contents.first.getDescription()!),
            ),
          ]
      ),
    ),
  );
}