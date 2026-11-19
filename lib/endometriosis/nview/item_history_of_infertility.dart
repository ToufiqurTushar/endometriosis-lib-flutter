import 'package:endometriosis_lib_flutter/endometriosis/enum/yes_no_dontknow_enum.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/form/checkbox_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import '../npage/screening/endometriosis_screening_logic.dart';
import 'form/radio_buttons.dart';


class ItemHistoryOfInfertility extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemHistoryOfInfertility(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemHistoryOfInfertility> createState() => _ItemHistoryOfInfertilityState();
}

class _ItemHistoryOfInfertilityState extends State<ItemHistoryOfInfertility> {
  var description = "";
  var descriptionBn = "";
  var customContent = Content();
  @override
  void initState() {
    super.initState();
    var selectedValueForAge = widget.form.currentState!.getRawValue("pm1");
    if((selectedValueForAge != null || selectedValueForAge == "") && !widget.content.readOnly) {
      int age = DateTime.now().year - (selectedValueForAge as DateTime).year;
      if(age > 35) {
        description = "Infertility is defined as not being able to achieve pregnancy after 6 months of having regular, unprotected intercourse.";
        descriptionBn = "বন্ধ্যাত্ব হলো ৬ মাস ধরে কোন ধরনের জন্ম নিয়ন্ত্রণ পদ্ধতি ব্যবহার না করে নিয়মিত স্বামী সহবাস করার পরেও গর্ভধারণ (সন্তান ধারণ) করতে না পারা।";
        customContent = widget.content;
        customContent.description = description;
        customContent.descriptionBn = descriptionBn;
      } else {
        description = "Infertility is defined as not being able to achieve pregnancy after 1 year of having regular, unprotected intercourse.";
        descriptionBn = "বন্ধ্যাত্ব হলো ১২ মাস বা ১ বছর ধরে কোন ধরনের জন্ম নিয়ন্ত্রণ পদ্ধতি ব্যবহার না করে নিয়মিত স্বামী সহবাস করার পরেও গর্ভধারণ (সন্তান ধারণ) করতে না পারা।";
        customContent = widget.content;
        customContent.description = description;
        customContent.descriptionBn = descriptionBn;
      }
    } else {
      customContent = widget.content;
    }

    //also remove treatment for infertility if initial value no on init
    if(widget.form.currentState!.getRawValue(widget.content.key) == YesNoEnum.YES.value) {
      pageAddOrRemove(true);
    } else {
      pageAddOrRemove(false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.content.readOnly,
      child: Card(
        elevation: widget.elevation,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Column(
            children: [
              RadioButtons(customContent, widget.context, widget.form, onChanged: (val){
                if(val == YesNoDontknowEnum.YES.value) {
                  //add page if removed earlier
                  pageAddOrRemove(true);
                } else {
                  //remove next page
                  pageAddOrRemove(false);
                }
                setState(() {});
              }),
            ],
          ),
        ),
      ),
    );
  }

  pageAddOrRemove(bool add) {
    if(Get.isRegistered<EndometriosisScreeningLogic>()){
      var controller = Get.find<EndometriosisScreeningLogic>();
      if(add) {
        if(controller.screeningPages.firstWhereOrNull((item) => item.page == 4) == null) {
          RLog.error(controller.screeningPages.length);
          int getPosition = controller.screeningPages.indexWhere((item)=> item.page == 3);
          controller.screeningPages.insert(getPosition+1, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 4));
          RLog.error("${controller.screeningPages.length} after adding page");
        }
      } else {
        if(controller.screeningPages.firstWhereOrNull((item)=>item.page == 4) != null) {
          RLog.error(controller.screeningPages.length);
          controller.screeningPages.removeWhere((item) => item.page == 4);
          RLog.error("${controller.screeningPages.length} after remove page");
          //1 page key value should be null
          controller.removeKeyValue(['pm5', 'pm5_1']);
        }
      }
    }
  }
}

