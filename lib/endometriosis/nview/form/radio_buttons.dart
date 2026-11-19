import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../config/color_config.dart';
import '../../dto/content.dart';
import '../../dto/data.dart';
import '../item_label.dart';

Widget RadioButtons(Content content, context, GlobalKey form, {double elevation = 0, double padding = 0, Function? onChanged}) {
  int? initialValue = (content.initialValue == null)?
  null :
  (content.initialValue is List && content.initialValue.length>0)?
  1 :
  (content.initialValue is List && content.initialValue.length==0)?
  0:
  int.tryParse(content.initialValue);
  return Visibility(
    visible: !(content.readOnly && initialValue == null),
    child: IgnorePointer(
      ignoring: content.readOnly,
      child: Card(
        elevation: elevation,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: ListBody(
              children: [
                if(content.label != null) ItemLabel(content),
                Theme(
                  data: Theme.of(context).copyWith(
                    radioTheme: Theme.of(context).radioTheme.copyWith(
                      fillColor: MaterialStateProperty.all(Colors.black),
                    ),
                  ),
                  child: FormBuilderRadioGroup<dynamic>(
                    //enabled: parentCondition,
                    initialValue: initialValue,
                    name: content.key!,
                    options: content.options!.map((Data data) => FormBuilderFieldOption(
                      value: data.value,
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 4),width:content.options?.length == 2? Get.width*.3: null, child: Align(alignment: Alignment.centerLeft, child: Text(data.getLabel(), textAlign: TextAlign.left,)),),
                    )).toList(growable: false),
                    wrapAlignment: WrapAlignment.start,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      fillColor: ColorConfig.textFieldColor,
                      filled: true,
                      isDense: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConfig.textFieldHintColor, width: 1.0),
                      ),
                    ),
                    activeColor: ColorConfig.textFieldIconColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) {
                      if(onChanged != null) {
                        onChanged(val);
                      }
                    },
                    valueTransformer: content.valueTransformer,
                    controlAffinity: ControlAffinity.leading,
                    validator: content.required? FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Select'.tr)
                    ]) : null,

                  ),
                ),
                if(content.description != null  && !content.readOnly) Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                  child: Text(content.getDescription()!),
                ),
              ]
          ),
        ),
      ),
    ),
  );
}
