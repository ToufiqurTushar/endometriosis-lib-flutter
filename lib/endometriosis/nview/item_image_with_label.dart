import 'package:flutter/material.dart';

import '../../../config/color_config.dart';
import '../../common/method/utils.dart';
import '../dto/data.dart';

Widget ItemImageWithLabel(Data data) {
  return Container(
    margin: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: ColorConfig.textFieldColor, // Set border width
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Utils.getImageAssetWidget(data.value, fit: BoxFit.fill),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          height:60,
          child: Center(child: Text(data.getLabel(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 13),)),
        )
      ],
    ),
  );
}