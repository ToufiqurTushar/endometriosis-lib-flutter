import 'dart:convert';

import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import '../../../config/color_config.dart';
import '../dto/content.dart';
import '../dto/data.dart';
import '../npage/screening/endometriosis_screening_logic.dart';

Container ItemIndicator({required String text, Color? background, Color? textColor}) {
  return Container(
    width: 50,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: background??ColorConfig.textFieldColor,
        border: Border.all(color: ColorConfig.textFieldIconColor)
    ),
    alignment: const Alignment(0,0),
    padding: const EdgeInsets.all(0),
    child: Text(text, style: TextStyle(color: textColor??Colors.white),),
  );
}

class PageIndicator extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  double? elevation;
  double? padding;
  PageIndicator(this.content, this.context, this.form, {super.key, elevation, padding});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  var customContent = Content();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(Get.isRegistered<EndometriosisScreeningLogic>()) {
      var controller = Get.find<EndometriosisScreeningLogic>();
      customContent.options = customContent.options = [Data(value: 1), Data(value: controller.screeningPages.where((page) => page.getContentWithPageIndicator() != null).length)];
      customContent.initialValue = controller.screeningPages.where((page) => page.getContentWithPageIndicator() != null).toList().indexWhere((item)=> item.page ==  controller.currentPage.page)+1;
    }
    return PageIndicatorWidget(customContent, widget.context, elevation: widget.elevation??0, padding: widget.padding??0);
  }
}

Widget PageIndicatorWidget(Content content, context, {double elevation = 0, double padding = 0}){
  var pages = [Data(value: content.initialValue-1),Data(value: content.initialValue),Data(value: content.initialValue+1)];
  if(content.initialValue == content.options!.first.value) {
    pages = [Data(value: content.initialValue),Data(value: content.initialValue+1),Data(value: content.initialValue+2)];
  } else if(content.initialValue == content.options!.last.value){
    pages = [Data(value: content.initialValue-2),Data(value: content.initialValue-1),Data(value: content.initialValue)];
  }
  pages = [Data(value: '◄'),...pages, Data(value: '►')];

  return Row(mainAxisAlignment:MainAxisAlignment.center, children: pages.map<Widget>((Data data){
    Color background = Colors.white;
    Color textColor = Colors.black;
    if(content.initialValue == data.value){
       background = ColorConfig.textFieldIconColor;
       textColor = Colors.black;
    }
    if(data.value == '◄'){
      background = ColorConfig.disableColor;
      textColor = Colors.black;
      if(content.initialValue == content.options!.first.value) {
        background = ColorConfig.disableColor;
      }
    }
    if(data.value == '►'){
      background = ColorConfig.disableColor;
      textColor = Colors.black;
      if(content.initialValue == content.options!.last.value){
        background = ColorConfig.disableColor;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ItemIndicator(text: data.value.toString().trDigit(), background: background, textColor: textColor),
    );
  }).toList());
}