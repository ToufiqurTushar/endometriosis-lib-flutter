import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:endometriosis_lib_flutter/endometriosis/enum/yes_no_divorced_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../common/method/utils.dart';
import '../dto/content.dart';
import '../dto/data.dart';
import '../enum/yes_no_enum.dart';
import '../npage/screening/endometriosis_screening_logic.dart';
import 'animated_visibility.dart';
import 'form/dropdown.dart';
import 'form/radio_buttons.dart';


class ItemAreYouMarried extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  ItemAreYouMarried(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemAreYouMarried> createState() => _ItemAreYouMarriedState();
}

class _ItemAreYouMarriedState extends State<ItemAreYouMarried> {
  var isVisibleFirstChild = false;
  var isVisibleSecondChild = false;
  var isVisibleSecondChildSFirstChild = false;

  late Content content;
  late Content firstChildContent;
  late Content secondChildContent;
  late Content secondChildFirstContent;


  @override
  void initState() {
    super.initState();
    content = widget.content;
    firstChildContent = content.children!.first;
    secondChildContent = content.children![1];
    secondChildFirstContent = secondChildContent.children!.first;
    isVisibleFirstChild = widget.form.currentState?.getRawValue(content.key) == YesNoDivorcedEnum.YES.value
        || widget.form.currentState?.getRawValue(content.key) == YesNoDivorcedEnum.DIVORCED.value
        || content.initialValue == YesNoDivorcedEnum.YES.value.toString()
        || content.initialValue == YesNoDivorcedEnum.DIVORCED.value.toString();

    isVisibleSecondChild = isVisibleFirstChild;
    isVisibleSecondChildSFirstChild = widget.form.currentState?.getRawValue(secondChildContent.key) == YesNoEnum.YES.value
      || secondChildContent.initialValue == YesNoDivorcedEnum.YES.value.toString();
  }
  @override
  Widget build(BuildContext context) {
    //modify first child content based on age
    Content customFirstChildContent = firstChildContent;
    var selectedValueForAge = widget.form.currentState!.getRawValue("pm1");
    if(selectedValueForAge != null) {
      int age = DateTime.now().year - (selectedValueForAge as DateTime).year;
      if(age >= 8) {
        customFirstChildContent = firstChildContent;
        customFirstChildContent.options = Utils.getAgeDataList(8, age);
      } else {
        customFirstChildContent = firstChildContent;
        customFirstChildContent.options = [];
      }
    }
    return IgnorePointer(
      ignoring: content.readOnly,
      child: Column(
        children: [
          RadioButtons(widget.content, widget.context, widget.form, onChanged: (val){
            if(isVisibleFirstChild && (val == YesNoDivorcedEnum.YES.value || val == YesNoDivorcedEnum.DIVORCED.value)) {
              return;
            }
            if(val == YesNoDivorcedEnum.YES.value || val == YesNoDivorcedEnum.DIVORCED.value) {
              isVisibleFirstChild = true;
              isVisibleSecondChild = true;
              isVisibleSecondChildSFirstChild = false;
              //add 5 page if removed earlier
              pageAddOrRemove(true);

            } else {
              isVisibleFirstChild = false;
              isVisibleSecondChild = false;
              isVisibleSecondChildSFirstChild = false;
              //remove 5 pages
              pageAddOrRemove(false);
            }
            setState(() {});
          }),
          AnimatedVisibility(
            visible: isVisibleFirstChild,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: DropDown(customFirstChildContent, widget.context, widget.form),
            ),
          ),
          AnimatedVisibility(
            visible: isVisibleSecondChild,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: RadioButtons(secondChildContent, widget.context, widget.form, onChanged:(val){
                if(val == YesNoEnum.YES.value) {
                  isVisibleSecondChildSFirstChild = true;
                } else {
                  isVisibleSecondChildSFirstChild = false;
                  widget.form.currentState!.fields[secondChildFirstContent.key]?.didChange(null);
                }
                setState(() {});
              }),
            ),
          ),
          AnimatedVisibility(
            visible: isVisibleSecondChildSFirstChild,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: DropDown(secondChildFirstContent, widget.context, widget.form),
            ),
          ),
        ],
      ),
    );
  }
  pageAddOrRemove(bool add) {
    if(Get.isRegistered<EndometriosisScreeningLogic>()){
      var controller = Get.find<EndometriosisScreeningLogic>();
      if(add) {
        if(controller.screeningPages.firstWhereOrNull((item)=>item.page == 2) == null){
          RLog.error(controller.screeningPages.length);
          int getPosition = controller.screeningPages.indexWhere((item)=> item.page == 1);
          controller.screeningPages.insert(getPosition+1, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 2));
          controller.screeningPages.insert(getPosition+2, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 3));
          controller.screeningPages.insert(getPosition+3, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 4));
          controller.screeningPages.insert(getPosition+4, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 5));
          controller.screeningPages.insert(getPosition+14, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 15));
          RLog.error("${controller.screeningPages.length} after adding page");
        }
      } else {
        if(controller.screeningPages.firstWhereOrNull((item)=>item.page == 2) != null){
          RLog.error(controller.screeningPages.length);
          controller.screeningPages.removeWhere((item) => item.page == 2 || item.page == 3 || item.page == 4 || item.page == 5 || item.page == 15);
          RLog.error("${controller.screeningPages.length} after remove page");
          controller.removeKeyValue([
            firstChildContent.key,
            secondChildContent.key,
            secondChildFirstContent.key,
            'pd1', //p2
            'pmi2', //p2
            'pm4', //p3
            'pm5', //p4
            'pm5_1', //p4
            'pm5_1_month_child', //p4
            'pm5_1_day_child', //p4
            'pmi3', //p5
            'sm6' //p14
          ]);
        }
      }
    }
  }
}

