import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dto/content.dart';
import 'form/edit_text.dart';
import 'form/hidden_edit_text.dart';
import 'item_label.dart';

Widget ItemBMI(Content content, context, form,{double elevation = 0, double padding = 0}){
  return Column(
    children: [
      HiddenEditText(content.children!.first, context, form),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ItemLabel(content),Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: EditText(content.children![1], context, form, validators: content.children![1].validators, keyboardType: const TextInputType.numberWithOptions(), inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))])),
          const SizedBox(width: 4,),
          Expanded(child: EditText(content.children![2], context, form,validators: content.children![2].validators!, keyboardType: const TextInputType.numberWithOptions(),inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))])),
          const SizedBox(width: 4,),
          Expanded(child: EditText(content.children![3], context, form, validators: content.children![3].validators!, keyboardType: const TextInputType.numberWithOptions(),inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))])),
        ],
      )]),
    ],
  );
}