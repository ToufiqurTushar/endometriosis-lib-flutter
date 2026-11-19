import 'dart:convert';
import 'dart:developer';

import 'package:endometriosis_lib_flutter/endometriosis/dto/answer_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/api_config.dart';
import '../../dialog/toast_message.dart';
import '../../dialog/yes_no_dialog.dart';
import '../../dto/result_dto.dart';
import '../../dto/screening_page.dart';
import '../../endometriosis_home_logic.dart';
import '../../repository/endometriosis_repository.dart';
import '../result/endometriosis_result_argument.dart';
import '../result/endometriosis_result_view.dart';
import 'endometriosis_screening_argument.dart';

class EndometriosisScreeningLogic extends RapidStartLogic {
  EndometriosisRepository repository = Get.find();
  var userId = (Get.arguments as EndometriosisScreeningArgument).userId;
  var birthDate = (Get.arguments as EndometriosisScreeningArgument).birthDate;

  //live data
  final selectedPageIndex = 0.obs;

  //variable
  final form = GlobalKey<FormBuilderState>();
  Map<String, dynamic> formTransformedValues = {};
  final mPageController = PageController();
  late List<ScreeningPage> screeningPages = [];

  @override
  void onInit() {
    super.onInit();
    screeningPages = repository.getScreeningPages(birthDate: birthDate);
  }

  //function variable
  bool get isLastPage => selectedPageIndex.value == screeningPages.length - 1;
  bool get isFirstPage => selectedPageIndex.value == 0;

  ScreeningPage get currentPage => screeningPages[selectedPageIndex.value];


  //get every screen content used in snapshot for future builder of screening page
  Future<ScreeningPage>  getScreeningPages(int index) async{
    return screeningPages[index];
  }

  onPageChanged(index) {
    selectedPageIndex.value = index;
  }

  nextPage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (form.currentState?.saveAndValidate(autoScrollWhenFocusOnInvalid: true) ?? false) {
      mPageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    } else { //not validated
      if(kDebugMode)mPageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
      ShowToast.error("please_fillup_required_field".tr);
    }
  }

  previousPage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (form.currentState?.saveAndValidate() ?? false) {
      mPageController.previousPage(duration: 300.milliseconds, curve: Curves.ease);
    } else { //not validated
      if(kDebugMode)mPageController.previousPage(duration: 300.milliseconds, curve: Curves.ease);
      ShowToast.error('please_fillup_required_field_for_previous'.tr);
    }
  }

  navigateToPage(int index) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    mPageController.animateToPage(index, duration: 100.milliseconds, curve: Curves.ease);
  }


  submit() async {
    if (form.currentState?.saveAndValidate() ?? false) {
      final formMap = form.currentState!.value;

      //if not user interaction
      if(!formTransformedValues.containsKey('pm1')) {
        formTransformedValues['pm1'] = repository.AgeValueTrandformer(form.currentState!.getRawValue('pm1'));
      }
      if(!formTransformedValues.containsKey('BMI')) {
        formTransformedValues['BMI'] = 0;
      }
      if(!formTransformedValues.containsKey('pm5_1')) {
        formTransformedValues['pm5_1'] = 0;
      }
      //end: if not user interaction

      List<dynamic> answers = [];
      formMap.forEach((formKey, formValue){
        if(formValue != null && !formKey.contains("child") && formTransformedValues.containsKey(formKey)) {
          int answerValue = getTransformedValueFromAnswerMap(formKey);
          var answerTextWrappedWithArray = getAnswerTextAsArray(formKey);
          answers.add(AnswerDto(
              questionCode: formKey,
              answerValue: answerValue,
              answerText: answerTextWrappedWithArray
          ).toJson());
        }
      });
      log(jsonEncode(answers));
      postAnswer(jsonEncode(answers));
    } else {
      ShowToast.error("please_fillup_required_field".tr);
    }
  }

  postAnswer(answerData) async {
    log(answerData);
    globalState.showBusy(dismissible: false);
    repository.POST(Endpoints.postAnswerUrl(userId!), answerData).then((response){
      globalState.hideBusy();
      if(response.isOk) {
        var result = ResultDto.fromJson(response.body);
        Get.find<EndometriosisHomeLogic>().getData();
        Get.offNamed(EndometriosisResultView.routeName, arguments: EndometriosisResultArgument(result: result, isNewScreening: true));
      } else {
        ShowToast.error('something_wrong'.tr);
      }
    });
  }

  pressBackWarning() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    showYesNoDialog(
        title: 'do_you_want_to_go_back'.tr,
        onPressedYes: (){
          Get.back(closeOverlays: true);
        },
        onPressedNo: (){
          Get.back();
        }
    );
  }

  int getTransformedValueFromAnswerMap(String formFieldKey) {
    var formTransformedValue = formTransformedValues[formFieldKey];
    if(formTransformedValue == null) {
      RLog.info("transformed value for key $formFieldKey is 0");
      return 0;
    } else if(formTransformedValue is String) {
      return int.tryParse(formTransformedValue)??0;
    }

    return formTransformedValue;
  }

  List<String>? getAnswerTextAsArray(String formFieldKey) {
    if(
      formFieldKey.contains('pmi3')
      || formFieldKey.contains('rm1')
      || formFieldKey.contains('smi1')
    ) {
      return form.currentState!.getRawValue("${formFieldKey}_child");
    }
    if(formFieldKey.contains('pm5_1')) {
      return [
        form.currentState!.getRawValue("${formFieldKey}_year_child"),
        form.currentState!.getRawValue("${formFieldKey}_month_child"),
        form.currentState!.getRawValue("${formFieldKey}_day_child")
      ];
    }
    if(formFieldKey.contains('BMI')) {
      return [
        form.currentState!.getRawValue("${formFieldKey}_hf_child"),
        form.currentState!.getRawValue("${formFieldKey}_hi_child"),
        form.currentState!.getRawValue("${formFieldKey}_w_child")
      ];
    }


    var formRawValue = form.currentState!.getRawValue(formFieldKey);
    if(formRawValue is DateTime){
      return [formRawValue.millisecondsSinceEpoch.toString()];
    } else if(form.currentState!.getRawValue(formFieldKey) is String){
      return [formRawValue];
    } else if(form.currentState!.getRawValue(formFieldKey) is int){
      return [formRawValue.toString()];
    } else if(form.currentState!.getRawValue(formFieldKey) is List){
      return formRawValue;
    } else {
      RLog.error("key: $formFieldKey, type: ${form.currentState!.getRawValue(formFieldKey).runtimeType} Not Processed!, return null");
    }

    return null;
  }

  void removeKeyValue(keys) {
    keys.forEach((key){
      formTransformedValues.remove(key);
      form.currentState!.fields[key]?.didChange(null);
    });
  }
}