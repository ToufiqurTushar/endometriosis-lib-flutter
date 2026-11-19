import 'package:endometriosis_lib_flutter/endometriosis/nview/build_items.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/form/hidden_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import 'animated_visibility.dart';
import 'form/edit_text.dart';
import 'form/radio_buttons.dart';
import 'form/select_year_month.dart';


class ItemTreatmentForInfertility extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemTreatmentForInfertility(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemTreatmentForInfertility> createState() => _ItemTreatmentForInfertilityState();
}

class _ItemTreatmentForInfertilityState extends State<ItemTreatmentForInfertility> {
  var isVisibleFirstChild = false;
  @override
  void initState() {
    super.initState();
    isVisibleFirstChild = widget.form.currentState!.getRawValue(widget.content.key) == YesNoEnum.YES.value || widget.content.initialValue == "1";
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
              RadioButtons(widget.content, widget.context, widget.form, onChanged: (val){
                if(val == YesNoEnum.YES.value) {
                  isVisibleFirstChild = true;
                } else {
                  isVisibleFirstChild = false;
                  widget.form.currentState!.fields[widget.content.children!.first.key]?.didChange(null);
                  widget.form.currentState!.fields[widget.content.children![1].key]?.didChange(null);
                }
                setState(() {});
              }),
              AnimatedVisibility(
                visible: isVisibleFirstChild,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SelectYearMonth(widget.content.children!, widget.context, widget.form),
                ),
              ),
              AnimatedVisibility(//pm5_1
                visible: isVisibleFirstChild,
                child: HiddenEditText(widget.content.children![3], widget.context, widget.form),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

