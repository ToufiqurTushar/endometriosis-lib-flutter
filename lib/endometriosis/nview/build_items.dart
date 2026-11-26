import 'package:endometriosis_lib_flutter/endometriosis/nview/form/hidden_edit_text.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_age_date_of_birth.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_age_first_period.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_experience_constipation.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_felling_depress_anxious.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_history_of_infertility.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_label.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_take_any_painkiller.dart.dart';
import 'package:endometriosis_lib_flutter/endometriosis/nview/item_using_contraceptive_method.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../dto/content.dart';
import '../enum/content_enum.dart';
import 'form/checkbox_buttons.dart';
import 'form/dropdown.dart';
import 'form/edit_text.dart';
import 'form/radio_buttons.dart';
import 'form/read_only_text.dart';
import 'form/select_date.dart';
import 'item_are_you_married.dart';
import 'item_bmi.dart';
import 'item_carousal.dart';
import 'item_banner_image.dart';
import 'item_endometriosis_in_family.dart';
import 'item_lower_abdominal_pain.dart';
import 'item_page_indicator.dart';
import 'item_pregnancy_loss.dart';
import 'item_treatment_for_infertility.dart';

Widget buildEachPage(dynamic screeningPage, context, form, {double elevation = 0, double padding = 0,double topPageMargin = 8, Color? background}) {
  List<Widget> child = [];
  child.add(buildContentsOfEachPage(screeningPage.contents!, context, form, padding: padding, elevation: elevation));
  return Container(
    color: background,
    padding: const EdgeInsets.only(top: 4, bottom: 0, left: 4, right: 4),
    margin: EdgeInsets.only(left: 8, right: 8, top: topPageMargin),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: child
    ),
  );
}


Widget buildContentsOfEachPage(List<Content> contents, context, form, {double padding = 0, double elevation = 0}) {
  List<Widget> children = [];
  for(var i=0; i < contents.length; i++) {
    final content = contents[i];
    Widget child = Container();
    switch(content.type) {
      case ContentEnum.EDIT_TEXT:
        child = EditText(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.READ_ONLY_TEXT:
        child = ReadOnlyText(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.SELECT_DATE:
        child = SelectDate(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.AGE_DATE_OF_BIRTH:
        RLog.error("Select Date:${content.toJson()}");
        child = ItemAgeDateOfBirth(content, context, form, padding: padding, elevation: elevation);
      break;
      case ContentEnum.RADIO_GROUP:
        child = RadioButtons(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.CHECKBOX_GROUP:
        child = CheckboxButtons(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.DROPDOWN:
        child = DropDown(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.AGE_FIRST_PERIOD:
        child = ItemAgeFirstPeriod(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.CAROUSAL_IMAGE:
        child = ItemCarousal(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.BMI:
        child = ItemBMI(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.HIDDEN:
        child = HiddenEditText(content, context, form);
        break;
      case ContentEnum.PREGNANCY_LOSS:
        child = ItemPregnancyLoss(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.HISTORY_OF_INFERTILITY:
        child = ItemHistoryOfInfertility(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.ARE_YOU_MARRIED:
        child = ItemAreYouMarried(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.TREATMENT_FOR_INFERTILITY:
        child = ItemTreatmentForInfertility(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.TAKE_ANY_PAINKILLER:
        child = ItemTakeAnyPainkiller(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.USING_CONTRACEPTIVE_METHOD:
        child = ItemUsingContraceptiveMethod(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.EXPERIENCE_CONSTIPATION:
        child = ItemExperienceConstipation(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.ENDOMETRIOSIS_IN_FAMILY:
        child = ItemEndometriosisInFamily(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.LOWER_ABDOMIAL_PAIN:
        child = ItemLowerAbdominalPain(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.FEELING_DEPRESSED_ANXIOUS:
        child = ItemFeelingDepressedAnxious(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.IMAGE:
        child = ItemBannerImage(image: content.options!.first.value, height: Get.context!.isLandscape ? 50: 100);
        break;
      case ContentEnum.PAGE_INDICATOR:
        child = PageIndicator(content, context, form, padding: padding, elevation: elevation);
        break;
      case ContentEnum.LABEL:
        child = ItemLabel(content);
        break;
      default: Container();
    }
    if(content.isVisible) {
      children.add(child);
      children.add(const SizedBox(height: 14));
    }
  }
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
  );
}