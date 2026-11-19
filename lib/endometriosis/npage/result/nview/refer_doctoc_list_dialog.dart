import 'package:endometriosis_lib_flutter/endometriosis/dialog/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/color_config.dart';
import '../endometriosis_result_logic.dart';

class ReferDoctocListDialog extends GetView<EndometriosisResultLogic> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: ColorConfig.backgroundColor,
        child: Column(children: controller.referDoctorList.map<Widget>((String value){
          return Card(elevation: 1, child: ListTile(title:Text(value), onTap: (){
            ShowToast.success('Refer Successful!');
            Get.close(2);
          },));
        }).toList()),
      )
    );
  }
}




