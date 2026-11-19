import 'package:endometriosis_lib_flutter/endometriosis/enum/yes_no_dontknow_enum.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/form/checkbox_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/yes_no_enum.dart';
import '../npage/screening/endometriosis_screening_logic.dart';
import 'form/radio_buttons.dart';


class ItemFeelingDepressedAnxious extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemFeelingDepressedAnxious(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemFeelingDepressedAnxious> createState() => _ItemFeelingDepressedAnxiousState();
}

class _ItemFeelingDepressedAnxiousState extends State<ItemFeelingDepressedAnxious> {
  var label = "";
  var labelBn = "";
  var customContent = Content();
  @override
  void initState() {
    super.initState();
    var selectedValueForMarried = widget.form.currentState!.getRawValue("pmi1");
    if(selectedValueForMarried == YesNoEnum.YES.value) {
      label = "Do you feel depressed or anxious due to any of the following: infertility, pain during intercourse, lower abdominal pain during or outside of menstruation, pain during menstruation while defecating, or pain while urinating?";
      labelBn = "আপনি কি নিম্নলিখিত যে কোনও এক বা একাধিক কারণে হতাশাগ্রস্ত বা উদ্বিগ্নতা অনুভব করেন: গর্ভধারণে অক্ষমতা, সহবাসের সময় ব্যথা, মাসিকের সময়ে বা মাসিকের সময় বাদ দিয়ে তলপেটে ব্যথা, মাসিক চলাকালীন সময়ে মলত্যাগ বা প্রস্রাব করার সময় ব্যথা?";
      customContent = widget.content;
      customContent.label = label;
      customContent.labelBn = labelBn;
    } else {
      label = "Do you feel depressed or anxious due to any of the following: lower abdominal pain during or outside of menstruation, pain during menstruation while defecating, or pain while urinating?";
      labelBn = "আপনি কি নিম্নলিখিত যে কোনও এক বা একাধিক কারণে হতাশাগ্রস্ত বা উদ্বিগ্নতা অনুভব করেন: মাসিকের সময়ে বা মাসিকের সময় বাদ দিয়ে তলপেটে ব্যথা, মাসিক চলাকালীন সময়ে মলত্যাগ বা প্রস্রাব করার সময় ব্যথা?";
      customContent = widget.content;
      customContent.label = label;
      customContent.labelBn = labelBn;
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
              RadioButtons(customContent, widget.context, widget.form, onChanged: (val){}),
            ],
          ),
        ),
      ),
    );
  }
}

