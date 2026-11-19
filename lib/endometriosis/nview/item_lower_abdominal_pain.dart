import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import '../npage/screening/endometriosis_screening_logic.dart';
import 'animated_visibility.dart';
import 'build_items.dart';
import 'form/radio_buttons.dart';


class ItemLowerAbdominalPain extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemLowerAbdominalPain(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemLowerAbdominalPain> createState() => _ItemLowerAbdominalPainState();
}

class _ItemLowerAbdominalPainState extends State<ItemLowerAbdominalPain> {
  var isVisibleChildren = false;
  @override
  void initState() {
    super.initState();
    isVisibleChildren = widget.form.currentState!.getRawValue(widget.content.key) == YesNoEnum.YES.value || widget.content.initialValue == YesNoEnum.YES.value.toString();
    //also remove treatment for infertility if initial value no on init
    if(isVisibleChildren) {
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
        color: Colors.white,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(widget.content.readOnly? 0: 8),
          child: Column(
            children: [
              RadioButtons(widget.content, widget.context, widget.form, onChanged: (val){
                if(val == YesNoEnum.YES.value) {
                  isVisibleChildren = true;

                  //add next page if removed already
                  pageAddOrRemove(true);
                } else {
                  isVisibleChildren = false;
                  //remove next page if no
                  pageAddOrRemove(false);
                }
                setState(() {});
              }),
              AnimatedVisibility(
                visible: isVisibleChildren,
                child: Column(
                  children: [
                    const SizedBox(height: 4,),
                    buildContentsOfEachPage(widget.content.children!, widget.context, widget.form, padding: widget.content.readOnly? 0: 4),
                  ],
                ),
              ),
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
        if(controller.screeningPages.firstWhereOrNull((item) => item.page == 13) == null) {
          RLog.error(controller.screeningPages.length);
          int getPosition = controller.screeningPages.indexWhere((item)=> item.page == 12);
          controller.screeningPages.insert(getPosition+1, controller.repository.getScreeningPages().firstWhere((item)=>item.page == 13));
          RLog.error("${controller.screeningPages.length} after adding page");
        }
      } else {
        if(controller.screeningPages.firstWhereOrNull((item)=>item.page == 13) != null) {
          RLog.error(controller.screeningPages.length);
          controller.screeningPages.removeWhere((item) => item.page == 13);
          RLog.error("${controller.screeningPages.length} after remove page");
          controller.removeKeyValue([
            widget.content.children![1].key,
            widget.content.children![2].key,
            widget.content.children![3].key,
            'sm7',
            'sm8'
          ]);
        }
      }
    }
  }
}

