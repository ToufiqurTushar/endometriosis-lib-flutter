import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../common/method/utils.dart';
import '../enum/content_enum.dart';
import 'data.dart';

class Content {
  Content({
      this.type, 
      this.key, 
      this.label,
      this.labelBn,
      this.description,
      this.descriptionBn,
      this.figure,
      this.figures,
      this.figuresColumn,
      this.hint = "",
      this.hintBn = "",
      this.options,
      this.readOnly = false,
      this.isVisible = true,
      this.labelAtCenter = false,
      this.required = true,
      this.initialValue,
      this.children,
      this.validators,
      this.valueTransformer,
  });

  ContentEnum? type;
  String? key;
  String? label;
  String? labelBn;
  String? description;
  String? descriptionBn;
  List<Data>? figures;
  int? figuresColumn;
  Data? figure;
  String hint = "";
  String hintBn = "";
  List<Data>? options;
  bool readOnly = false;
  bool isVisible = true;
  bool labelAtCenter = false;
  bool required = true;
  dynamic initialValue;
  List<Content>? children;
  List<dynamic>? validators;
  ValueTransformer<dynamic>? valueTransformer;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    if (options != null) {
      data['options'] = options?.map((v) => v.toJson()).toList();
    }
    data['initialValue'] = initialValue;
    return data;
  }

  getLabel() {
    if(Utils.isLocaleEn()) {
      return label??'';
    } else {
      return labelBn??'';
    }
  }

  getHint() {
    if(Utils.isLocaleEn()) {
      return hint;
    } else {
      return hintBn;
    }
  }

  getDescription() {
    if(Utils.isLocaleEn()) {
      return description??'';
    } else {
      return descriptionBn??'';
    }
  }
}