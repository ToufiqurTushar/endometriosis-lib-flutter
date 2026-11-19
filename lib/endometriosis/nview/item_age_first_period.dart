import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../common/method/utils.dart';
import '../dto/content.dart';
import '../dto/data.dart';
import 'form/dropdown.dart';


class ItemAgeFirstPeriod extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemAgeFirstPeriod(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemAgeFirstPeriod> createState() => _ItemAgeFirstPeriodState();
}

class _ItemAgeFirstPeriodState extends State<ItemAgeFirstPeriod> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //modify content based on age
    Content customContent = widget.content;
    var selectedValueForAge = widget.form.currentState!.getRawValue("pm1");
    if(selectedValueForAge != null) {
      int age = DateTime.now().year - (selectedValueForAge as DateTime).year;
      if(age >= 8) {
        customContent = widget.content;
        customContent.options = Utils.getAgeDataList(8, age);
      } else {
        customContent = widget.content;
        customContent.options = [];
      }
    }
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
              DropDown(customContent, context, widget.form, padding: widget.padding, elevation: widget.elevation)
            ],
          ),
        ),
      ),
    );
  }
}

