import 'package:endometriosis_lib_flutter/endometriosis/enum/yes_no_dontknow_enum.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/form/checkbox_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import 'animated_visibility.dart';
import 'form/radio_buttons.dart';


class ItemExperienceConstipation extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemExperienceConstipation(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemExperienceConstipation> createState() => _ItemExperienceConstipationState();
}

class _ItemExperienceConstipationState extends State<ItemExperienceConstipation> {
  var isVisibleFirstChild = false;
  @override
  void initState() {
    super.initState();
    isVisibleFirstChild = widget.form.currentState!.getRawValue(widget.content.key) == YesNoDontknowEnum.YES.value || (widget.content.initialValue is List && widget.content.initialValue.length>0);
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
                if(val == YesNoDontknowEnum.YES.value) {
                  isVisibleFirstChild = true;
                } else {
                  isVisibleFirstChild = false;
                  widget.form.currentState!.fields[widget.content.children!.first.key]?.didChange(null);
                }
                setState(() {});
              }),
              AnimatedVisibility(
                visible: isVisibleFirstChild,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CheckboxButtons(widget.content.children!.first, widget.context, widget.form, onChanged: (val){
                    if(val != null && val.length > 1) {
                      if(val.last == "0") {
                        widget.form.currentState!.fields[widget.content.children!.first.key]?.didChange(["0"]);
                      } else if(val.contains("0")) {
                        val = val.remove("0");
                        widget.form.currentState!.fields[widget.content.children!.first.key]?.didChange(val);
                      }
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

