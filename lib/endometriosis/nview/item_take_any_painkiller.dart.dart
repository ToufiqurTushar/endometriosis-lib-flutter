import 'package:endometriosis_lib_flutter/endometriosis/enum/yes_no_dontknow_enum.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/form/checkbox_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import 'animated_visibility.dart';
import 'form/radio_buttons.dart';


class ItemTakeAnyPainkiller extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemTakeAnyPainkiller(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemTakeAnyPainkiller> createState() => _ItemTakeAnyPainkillerState();
}

class _ItemTakeAnyPainkillerState extends State<ItemTakeAnyPainkiller> {
  var isVisibleFirstChild = false;
  var isVisibleTakingPainKillerQuestion = false;
  @override
  void initState() {
    super.initState();
    isVisibleFirstChild = widget.form.currentState!.getRawValue(widget.content.key) == YesNoEnum.YES.value || widget.content.initialValue == YesNoEnum.YES.value.toString();

    isVisibleTakingPainKillerQuestion = widget.form.currentState!.getRawValue('sm1') == YesNoEnum.YES.value; //if has LOWER_ABDOMIAL_PAIN

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
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Visibility(
                visible: isVisibleTakingPainKillerQuestion,
                child: RadioButtons(widget.content, widget.context, widget.form, onChanged: (val){
                  if(val == YesNoDontknowEnum.YES.value) {
                    isVisibleFirstChild = true;
                  } else {
                    isVisibleFirstChild = false;
                    widget.form.currentState!.fields[widget.content.children!.first.key]?.didChange(null);
                  }
                  setState(() {});
                }),
              ),
              AnimatedVisibility(
                visible: isVisibleFirstChild,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: RadioButtons(widget.content.children!.first, widget.context, widget.form,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

