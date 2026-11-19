import 'package:endometriosis_lib_flutter/endometriosis/npage/screening/endometriosis_screening_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../common/method/utils.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import 'animated_visibility.dart';
import 'form/dropdown.dart';
import 'form/radio_buttons.dart';


class ItemPregnancyLoss extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemPregnancyLoss(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemPregnancyLoss> createState() => _ItemPregnancyLossState();
}

class _ItemPregnancyLossState extends State<ItemPregnancyLoss> {
  var isHideFirstChild = true;
  var customFirstChildContent = Content();
  @override
  void initState() {
    super.initState();
    var selectedValueForAge = widget.form.currentState!.getRawValue("pm1");
    int age = 0;
    if(selectedValueForAge is DateTime) {
      age = DateTime.now().year - (selectedValueForAge as DateTime).year;
    }
    else if(selectedValueForAge is String) {
      age = DateTime.now().year - int.tryParse(selectedValueForAge)!;
    }

    var selectedValueForMarriedAge = widget.form.currentState!.getRawValue('pmi1_1')??'8';
    int marriedPeriodAge = int.tryParse(selectedValueForMarriedAge)??8;

    isHideFirstChild = widget.form.currentState!.getRawValue('pm3') == YesNoEnum.NO.value && widget.form.currentState!.getRawValue(widget.content.key) == YesNoEnum.NO.value;
    customFirstChildContent = widget.content.children!.first;
    customFirstChildContent.options = Utils.getAgeDataList(marriedPeriodAge, age > 55 ? 55: age);
    if(isHideFirstChild) {
      pageKeysRemove([customFirstChildContent.key]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.content.readOnly,
      child: Card(
        elevation: widget.elevation,
        margin: EdgeInsets.all(0),
        child: Column(
          children: [
            RadioButtons(widget.content, widget.context, widget.form, onChanged: (val){
              if(val == YesNoEnum.YES.value) {
                isHideFirstChild = false;
              } else {
                if(widget.form.currentState!.getRawValue('pm3') == YesNoEnum.NO.value){ //no children
                  isHideFirstChild = true;
                  widget.form.currentState!.fields[customFirstChildContent.key]?.didChange(null);
                } else {
                  isHideFirstChild = false;
                }
              }
              setState(() {});
            }),
            AnimatedVisibility(
              visible: !isHideFirstChild,
              child: DropDown(customFirstChildContent, widget.context, widget.form,)
            ),
          ],
        ),
      ),
    );
  }

  pageKeysRemove(keys) {
    if(Get.isRegistered<EndometriosisScreeningLogic>()){
      var controller = Get.find<EndometriosisScreeningLogic>();
      controller.removeKeyValue(keys);
    }
  }
}

