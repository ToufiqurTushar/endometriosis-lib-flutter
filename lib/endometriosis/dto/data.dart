import 'package:flutter_rapid/flutter_rapid.dart';

import '../../common/method/utils.dart';

class Data  {
  int? intValue;
  double? doubleValue;
  dynamic value;
  String? labelEn;
  String? labelBn;
  String? name;
  bool isSelected = false;


  Data({this.intValue, this.doubleValue, this.name, this.value, this.labelEn, this.labelBn, this.isSelected = false});

  Data.fromJson(Map<String, dynamic> json) {
    intValue = json['intValue'];
    labelEn = json['label_en'];
    labelBn = json['label_bn'];
    name = json['name'];
    doubleValue = json['doubleValue'];
    value = json['value'];
    isSelected = json['isSelected']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['intValue'] = intValue;
    data['label_en'] = labelEn;
    data['label_bn'] = labelBn;
    data['name'] = name;
    data['doubleValue'] = doubleValue;
    data['value'] = value;
    data['isSelected'] = isSelected;
    return data;
  }

  static fromJsonList(list) => List<Data>.from(list.map((x) => Data.fromJson(x)));

  getLabel() {
    if(Utils.isLocaleEn()) {
      return labelEn??'';
    } else {
      return labelBn??'';
    }
  }

}
