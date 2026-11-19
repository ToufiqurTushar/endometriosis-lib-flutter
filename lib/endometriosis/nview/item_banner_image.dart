import 'package:endometriosis_lib_flutter/common/method/utils.dart';
import 'package:flutter/material.dart';

ItemBannerImage({required String image, EdgeInsetsGeometry? margin, double? height}) {
  return Card(
    margin: EdgeInsets.zero,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(1),
      child: Utils.getImageAssetWidget(image, fit: BoxFit.fill),
    ),
  );
}