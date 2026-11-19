import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

Card ScreeningListItem({required BuildContext context, Color? color, required String title, required String subtitle, required String date, required GestureTapCallback onTap}) {
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: CircleAvatar(
        radius: Get.width * 0.065,
        backgroundColor: color??Colors.red,
        child: ClipOval(child: Container(color:Colors.white, child: Image.asset('assets/images/endometriosis/result_bg.png', height: 42, package: 'endometriosis_lib_flutter'))),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color??Colors.black),),
      subtitle: Text(subtitle),
      trailing: Text(date),
      onTap: onTap,
    ),
  );
}
