import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import 'build_items.dart';
import 'form/select_date.dart';


class ItemAgeDateOfBirth extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemAgeDateOfBirth(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemAgeDateOfBirth> createState() => _ItemAgeDateOfBirthState();
}

class _ItemAgeDateOfBirthState extends State<ItemAgeDateOfBirth> {
  @override
  void initState() {
    super.initState();
    RLog.error(widget.content.toJson());
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
              SelectDate(widget.content, context, widget.form, padding: widget.padding, elevation: widget.elevation, onChanged: (value){
                setState(() {});
              }),
              const SizedBox(height: 12,),
              buildContentsOfEachPage(widget.content.children!, context, widget.form, padding: widget.padding, elevation: widget.elevation)
            ],
          ),
        ),
      ),
    );
  }
}

