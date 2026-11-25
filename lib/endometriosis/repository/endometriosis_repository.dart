import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../common/method/utils.dart';
import '../../config/api_config.dart';
import '../dto/content.dart';
import '../dto/data.dart';
import '../dto/result_dto.dart';
import '../dto/screening_page.dart';
import '../enum/bleedding_enum.dart';
import '../enum/content_enum.dart';
import '../enum/menstrual_cycle_enum.dart';
import '../enum/pain_rating_enum.dart';
import '../enum/pattern of pain_enum.dart';
import '../enum/period_last_days_enum.dart';
import '../enum/relationship_enum.dart';
import '../enum/yes_no_divorced_enum.dart';
import '../enum/yes_no_dontknow_enum.dart';
import '../enum/yes_no_enum.dart';
import '../enum/yes_no_often_enum.dart';


class EndometriosisRepository extends HttpProvider {

  List<ScreeningPage> getScreeningPages({int? birthDate, List<Input?>? inputs, bool isDetailsView = false, bool isBirthDayReadonly = false}) {
    return [
      ScreeningPage(
          page: 1,
          contents: [
            Content(
              key: 'pm1',
              initialValue: isDetailsView? DateTime.fromMillisecondsSinceEpoch(int.parse(inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm1')?.answerText?.first??"")) : DateTime.fromMillisecondsSinceEpoch(birthDate??DateTime.now().millisecondsSinceEpoch),
              readOnly: isDetailsView || isBirthDayReadonly,
              label: 'What is your date of birth?',
              labelBn: 'আপনার জন্ম তারিখ কবে?',
              hint: 'Age',
              hintBn: 'বয়স',
              type: ContentEnum.AGE_DATE_OF_BIRTH,
              valueTransformer: AgeValueTrandformer,
              children: [
                Content(
                  label: 'Write down your Height & Weight',
                  labelBn: 'আপনার উচ্চতা এবং ওজন লিখুন',
                  type: ContentEnum.BMI,
                  children : [
                    Content(
                        key: 'BMI',
                        type: ContentEnum.HIDDEN,
                        initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'BMI')?.answerValue??"0": "0",
                        valueTransformer: (value)=> 0,
                    ),
                    Content(
                      key: 'BMI_hf_child',
                      hint: 'Height(feet)',
                      hintBn: 'উচ্চতা (ফুট)',
                      type: ContentEnum.BMI,
                      initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'BMI')?.answerText![0]: null,
                      validators: [
                        FormBuilderValidators.min(0, errorText: 'Min 0'.tr),
                        FormBuilderValidators.max(7, errorText: 'Max 7'.tr)
                      ],
                    ),
                    Content(
                      key: 'BMI_hi_child',
                      hint: 'Height(inch)',
                      hintBn: 'উচ্চতা (ইঞ্চি)',
                      required: false,
                      initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'BMI')?.answerText![1]: null,
                      validators: [
                        FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.min(0, errorText: 'Min 0'.tr)),
                        FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.max(11.99, errorText: 'Max 11.99'.tr)),
                      ],
                    ),
                    Content(
                      key: 'BMI_w_child',
                      hint: 'Weight(kg)',
                      hintBn: 'ওজন(কেজি)',
                      initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'BMI')?.answerText![2]: null,
                      validators: [
                        FormBuilderValidators.min(0, errorText: 'Min 0'.tr),
                        FormBuilderValidators.max(160, errorText: 'Max 160'.tr)
                      ],
                    ),
                  ],
                ),
                Content(
                    key: 'pm2',
                    label: 'At what age did you have your first period?',
                    labelBn: 'কত বছর বয়সে আপনার প্রথম মাসিক শুরু হয়েছিলো?',
                    hint: 'Age',
                    hintBn: 'বয়স',
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm2')?.answerText?.first: null,
                    readOnly: isDetailsView,
                    type: ContentEnum.AGE_FIRST_PERIOD,
                    options: [],
                    valueTransformer:(value)=> (int.tryParse(value)??0) >11? 0: 1
                ),
                Content(
                  key: 'pmi1',
                  label: 'Are you married?',
                  labelBn: 'আপনি কি বিবাহিত ?',
                  type: ContentEnum.ARE_YOU_MARRIED,
                  options: YesNoDivorcedEnum.getDataList(),
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pmi1')?.answerText?.first: null,
                  readOnly: isDetailsView,
                  valueTransformer: (value)=> 0,
                  children: [
                    Content(
                        key: 'pmi1_1',
                        label: 'At what age did you get married?',
                        labelBn: 'কত বছর বয়সে আপনার বিয়ে হয়েছিল?',
                        hint: 'Age',
                        hintBn: 'বয়স',
                        type: ContentEnum.DROPDOWN,
                        options: [],
                        initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pmi1_1')?.answerText?.first: null,
                        readOnly: isDetailsView,
                        valueTransformer:(value)=> (int.tryParse(value)??0) >27? 1: 0
                    ),
                    Content(
                        key: 'pm3',
                        label: 'Do you have any children?',
                        labelBn: 'আপনার সন্তান হয়েছে?',
                        type: ContentEnum.RADIO_GROUP,
                        options: YesNoEnum.getDataList(),
                        initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm3')?.answerText?.first??null: null,
                        readOnly: isDetailsView,
                        valueTransformer:(value)=> 0,
                        children: [
                          Content(
                              key: 'pm3_1',
                              label: 'How many children have you had so far?',
                              labelBn: 'এই পর্যন্ত আপনার কয়টি সন্তান হয়েছে?',
                              hint: 'label_select'.tr,
                              type: ContentEnum.DROPDOWN,
                              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm3_1')?.answerText?.first: null,
                              readOnly: isDetailsView,
                              options: [...List.generate(2, (i) => Data(labelEn: "${i+1} Child",labelBn: "${(i+1).toString().trDigit()} টি সন্তান", value: i+1),),Data(labelEn: '3 or More than 3 Children', labelBn: '৩ টি বা ৩ টির অধিক সন্তান', value: 3)],
                              valueTransformer:(value)=> 0
                          )
                        ]
                    )
                  ],
                ),
              ]
            ),
          ]
      ),
      ScreeningPage(
          page: 2,
          contents: [
            Content(
              key: 'pd1',
              label: isDetailsView? 'Do you have a history of early pregnancy loss (Miscarriage, Ectopic pregnancy, Termination of pregnancy)': 'Do you have a history of early pregnancy loss due to any of the following causes?',
              labelBn:  isDetailsView? 'কোনো কারণে কখনো কি অকালে আপনার গর্ভের বাচ্চা নষ্ট  হয়েছিলো? (গর্ভপাত / একটোপিক প্রেগন্যান্সি  / টারমিনেশন অব প্রেগন্যান্সি)': 'নিম্নলিখিত কোনো কারণে কখনো কি অকালে আপনার গর্ভের বাচ্চা নষ্ট  হয়েছিলো? (গর্ভপাত / একটোপিক প্রেগন্যান্সি  / টারমিনেশন অব প্রেগন্যান্সি)',
              description: 'Miscarriage: Spontaneous pregnancy loss occurring before 24 weeks of gestation.\n\nEctopic pregnancy: A pregnancy that occurs outside the uterine cavity.\n\nTermination of pregnancy:  Occurs before 24 weeks, either medically or surgically.',
              descriptionBn: 'গর্ভপাত: প্রাকৃতিকভাবে বা স্বতঃস্ফূর্তভাবে ২৪ সপ্তাহের আগে গর্ভের বাচ্চা নষ্ট হওয়া।\n\nএকটোপিক প্রেগন্যান্সি: ভ্রূণ জরায়ুর বাহিরে থাকলে যেমন ডিম্বনালী।\n\nটারমিনেশন অব প্রেগন্যান্সি: ঔষধ বা অপারেশনের মাধ্যমে ২৪ সপ্তাহের আগে গর্ভের বাচ্চা নষ্ট করা।',
              type: ContentEnum.PREGNANCY_LOSS,
              options: YesNoEnum.getDataList(),
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pd1')?.answerText?.first: null,
              readOnly: isDetailsView,
              figures: [
                Data(value: "abortion.png", labelEn: 'Miscarriage', labelBn: 'গর্ভপাত'),
                Data(value: "ectopic_pregnancy.png", labelEn: 'Ectopic pregnancy', labelBn: 'একটোপিক প্রেগন্যান্সি'),
              ],
              figuresColumn: 2,
              figure: Data(value: "termination_of_pregnancy.png", labelEn: 'Termination of pregnancy', labelBn: 'টার্মিনেশন অব প্রেগন্যান্সি'),
              children:[Content(
                  key: 'pmi2',
                  label: 'At what age did you first conceive?',
                  labelBn: 'কত বছর বয়সে আপনি প্রথম গর্ভধারণ করেছিলেন?',
                  hint: 'Age',
                  hintBn: 'বয়স',
                  type: ContentEnum.DROPDOWN,
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pmi2')?.answerText?.first: null,
                  readOnly: isDetailsView,
                  valueTransformer:(value)=> (int.tryParse(value)??0) >=30? 1: 0
              )],
            ),
          ]
      ),
      ScreeningPage(
          page: 3,
          contents: [
            Content(
              type: ContentEnum.IMAGE,
              isVisible: !isDetailsView,
              options: [Data(value: "history_of_infertility.png")],
            ),
            Content(
                key: 'pm4',
                label: 'Do you have / had a history of infertility or difficulties in conceiving?',
                labelBn: 'আপনার কি বন্ধ্যাত্ব বা সন্তান ধারণে (গর্ভধারণে) অক্ষমতা আছে বা কখনো ছিলো?',
                type: ContentEnum.HISTORY_OF_INFERTILITY,
                initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm4')?.answerText?.first: null,
                readOnly: isDetailsView,
                options: YesNoEnum.getDataList()
            ),
          ]
      ),
      ScreeningPage(
          page: 4,
          contents: [
            Content(
              type: ContentEnum.IMAGE,
              isVisible: !isDetailsView,
              options: [Data(value: "treatment_for_infertility.png")],
            ),
            Content(
              key: 'pm5',
              label: 'Have you ever sought treatment for infertility or difficulties in conceiving?',
              labelBn: 'আপনি কি কখনো বন্ধ্যাত্ব বা সন্তান ধারণে (গর্ভধারণ) অক্ষমতার জন্য চিকিৎসা নিয়েছেন?',
              type: ContentEnum.TREATMENT_FOR_INFERTILITY,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm5')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
              children: [
                Content(
                  key: 'pm5_1_year_child',
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm5_1')?.answerText![0]??"0": "0",
                  label: 'How long have you sought treatment for infertility or difficulties in conceiving?',
                  labelBn: 'বন্ধ্যাত্ব বা সন্তান ধারণে (গর্ভধারণ) অক্ষমতার জন্য আপনি কতদিন চিকিৎসা নিয়েছেন?',
                  hint: 'Year',
                  hintBn: 'বছর',
                  type: ContentEnum.YEAR_MONTH_DAY,
                  validators: [
                    FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.min(0, errorText: 'Min 0'.tr)),
                  ],
                ),
                Content(
                  key: 'pm5_1_month_child',
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm5_1')?.answerText![1]??"0": "0",
                  hint: 'Month',
                  hintBn: 'মাস',
                  validators: [
                    FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.min(0, errorText: 'Min 0'.tr)),
                    FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.max(11, errorText: 'Max 11'.tr)),
                  ],
                ),
                Content(
                  key: 'pm5_1_day_child',
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm5_1')?.answerText![2]??"0": "0",
                  hint: 'Day',
                  hintBn: 'দিন',
                  validators: [
                    FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.min(0, errorText: 'Min 0'.tr)),
                    FormBuilderValidators.transform(<String>(value)=> value == null || value.toString().isEmpty ? "0" : value, FormBuilderValidators.max(30, errorText: 'Max 30'.tr)),
                  ],
                ),
                Content(
                    key: 'pm5_1',
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pm5_1')?.answerValue??"0": "0",
                    type: ContentEnum.HIDDEN,
                    valueTransformer:(value)=> 0
                ),
              ],
            ),
          ]
      ),
      ScreeningPage(
          page: 5,
          contents: [
            Content(
              key: 'pmi3',
              label: 'Have you been using any of the following contraceptive method?',
              labelBn: 'আপনি কি কখনো নিম্নলিখিত কোন জন্মনিয়ন্ত্রণ পদ্ধতি ব্যবহার করেছেন?',
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pmi3')?.answerText: null,
              readOnly: isDetailsView,
              type: ContentEnum.USING_CONTRACEPTIVE_METHOD,
              options: YesNoEnum.getDataList(),
              figures: [
                Data(value: "condom.png", labelEn: 'Condom', labelBn: 'কনডম'),
                Data(value: "oral_contraceptives.png", labelEn: 'Oral Contraceptives', labelBn: 'জন্মনিয়ন্ত্রণ বড়ি'),
                Data(value: "intra_uterine_contraceptive_device.png", labelEn: 'Intra Uterine Contraceptive device', labelBn: 'জরায়ুর ভেতরে জন্মনিয়ন্ত্রণ ডিভাইস'),
                Data(value: "calendar_rhythm_method.png", labelEn: 'Calendar Rhythm method', labelBn: 'ক্যালেন্ডার রিদম পদ্ধতি'),
                Data(value: "contraceptive_implant.png", labelEn: 'Contraceptive Implant', labelBn: 'জন্মনিয়ন্ত্রণ ইমপ্ল্যান্ট'),
                Data(value: "tubectomy_tubal_ligation.png", labelEn: 'Tubectomy or tubal ligation', labelBn: 'টিউবেকটমি বা টিউবাল লাইগেশন'),
                Data(value: "injectable_contraceptives.png", labelEn: 'Injectable Contraceptives', labelBn: 'জন্মনিয়ন্ত্রণ ইনজেকশন'),
              ],
              figuresColumn: 3,
              children: [
                Content(
                  key: 'pmi3_child',
                  type: ContentEnum.CHECKBOX_GROUP,
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'pmi3')?.answerText: null,
                  readOnly: isDetailsView,
                  options: [
                    Data(value: 1, labelEn: 'Condom', labelBn: 'কনডম'),
                    Data(value: 2, labelEn: 'Oral Contraceptives', labelBn: 'জন্মনিয়ন্ত্রণ বড়ি'),
                    Data(value: 3, labelEn: 'Intra Uterine Contraceptive device', labelBn: 'জরায়ুর ভেতরে জন্মনিয়ন্ত্রণ ডিভাইস'),
                    Data(value: 4, labelEn: 'Calendar Rhythm method', labelBn: 'ক্যালেন্ডার রিদম পদ্ধতি'),
                    Data(value: 5, labelEn: 'Contraceptive Implant', labelBn: 'জন্মনিয়ন্ত্রণ ইমপ্ল্যান্ট'),
                    Data(value: 6, labelEn: 'Tubectomy or tubal ligation', labelBn: 'টিউবেকটমি বা টিউবাল লাইগেশন'),
                    Data(value: 7, labelEn: 'Injectable Contraceptives', labelBn: 'জন্মনিয়ন্ত্রণ ইনজেকশন')
                  ],
                ),
              ]
            ),
          ]
      ),
      ScreeningPage(
          page: 6,
          contents: [
            Content(
              key: 'rm1',
              label: 'Has anyone in your family (blood related relatives) suffered from endometriosis? (severe lower abdominal pain during menstruation)',
              labelBn: 'আপনার পরিবারের কেউ (রক্ত সম্পর্কীয় আত্মীয়) কি এন্ডোমেট্রিওসিস (মাসিকের সময় তলপেটে তীব্র ব্যথা) রোগে ভুগছেন বা ভুগেছেন?',
              type: ContentEnum.ENDOMETRIOSIS_IN_FAMILY,
              options: YesNoDontknowEnum.getDataList(),
              valueTransformer: (value)=> value==2?0:value,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm1')?.answerText: null,
              readOnly: isDetailsView,
              children: [
                Content(
                  key: 'rm1_child',
                  initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm1')?.answerText: null,
                  readOnly: isDetailsView,
                  type: ContentEnum.CHECKBOX_GROUP,
                  options: RelationshipEnum.getDataList(),
                ),
              ]
            ),
          ]
      ),
      ScreeningPage(
          page: 7,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "interval_between_menstrual_cycles.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 1,
            ),
            Content(
              key: 'rm2',
              label: 'What is the usual interval between your menstrual cycles?',
              labelBn: 'আপনার মাসিক  সাধারণত কতদিন পরপর হয়?',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm2')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: MenstrualCycleEnum.getDataList(),
              valueTransformer: (value)=> value==1?1:
                                          value==2?0:
                                          value==3?0:value
            ),
            Content(
              key: 'rm3',
              label: 'How many days does your period usually last?',
              labelBn: 'আপনার মাসিক সাধারণত কতদিন থাকে?',
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm3')?.answerText?.first: null,
              readOnly: isDetailsView,
              type: ContentEnum.RADIO_GROUP,
              options: PeriodLastDaysEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 8,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "bleeding_experience_during_menstruation.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 2,
            ),
            Content(
              key: 'rm4',
              label: 'Which type of bleeding do you usually experience during your menstruation?',
              labelBn: 'মাসিকের সময় সাধারণত আপনার নিম্নলিখিত কোন ধরণের রক্তপাত হয় বলে আপনি  মনে  করেন?',
              description: 'Excessive or heavy bleeding refers to the need to change a fully soaked pad 8 to 10 times or more within 24 hours or a single day during menstruation.',
              descriptionBn: 'অতিরিক্ত বা অনেক বেশি রক্তপাত বলতে বোঝায়, মাসিক চলাকালীন ২৪ ঘণ্টা বা ১ দিনের মাঝে যদি চুপচুপে ভেজা প্যাড  ৮ থেকে ১০ বার বা তার বেশি বার বদলানোর প্রয়োজন হয়।',
              type: ContentEnum.RADIO_GROUP,
              options: BleedingEnum.getDataList(),
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm4')?.answerText?.first: null,
              readOnly: isDetailsView,
              valueTransformer: (value)=> value==1?0:
                                          value==2?0:
                                          value==3?1:value
            ),
            Content(
              key: 'rm5',
              label: 'Do you usually pass clotted blood during menstruation?',
              labelBn: 'মাসিকের সময় কি সাধারণত আপনার চাকা চাকা জমাট বাঁধা রক্ত যায়?',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm5')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 9,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "small_amount_of_vaginal_bleeding.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 3,
            ),
            Content(
              key: 'rm6',
              label: "Did you experience a small amount of vaginal bleeding (just a few drops of blood) during the first ten days after birth? (If you don't know, you can ask your mother)",
              labelBn: "আপনার জন্মের প্রথম দশ দিনের মধ্যে আপনার মাসিকের রাস্তা (যোনিপথ) দিয়ে সামান্য পরিমাণে রক্তপাত (মাত্র কয়েক ফোঁটা রক্ত) হয়েছিল কিনা? (না জানা থাকলে মায়ের কাছ থেকে জেনে নিতে পারেন)",
              description: "A newborn female infant may experience slight vaginal bleeding any time between the first 2 to 10 days after birth. This is a natural phenomenon known as false menstruation.' It occurs when the mother's estrogen hormone levels suddenly drop after birth. The pink or blood-colored discharge should not remain more than 3 to 4 days.",
              descriptionBn: "জন্মের প্রথম ২-১০ দিনের মধ্যে যে কোনও সময়ে নবজাতক কন্যা শিশুদের যোনিপথ দিয়ে সামান্য রক্তপাত হতে পারে। এটি একটি প্রাকৃতিক ঘটনা যা নকল ঋতুস্রাব নামে পরিচিত। জন্মের পরে মায়ের ইস্ট্রোজেন হরমোন হঠাৎ হ্রাস পেলে এটি হয়ে থাকে। গোলাপী বা রক্ত রঙযুক্ত স্রাব ৩-৪ দিনের বেশি যায় না।",
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rm6')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoDontknowEnum.getDataList(),
              valueTransformer: (value)=>value==2?0:value
            ),
          ]
      ),
      ScreeningPage(
          page: 10,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "have_ovarian_cyst.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 4,
            ),
            Content(
              key: 'rd1',
              label: "Do you know if you have ovarian cyst?",
              labelBn: "আপনার ডিম্বাশয়ে বা ওভারিতে কি সিস্ট আছে ?",
              description: "An ovarian cyst is a type of sac that usually filled with fluid. These cysts may develop within or on the surface of the ovary. Women have one ovary on each side of the uterus. Many people mistakenly think that ovarian cysts are ovarian tumors.",
              descriptionBn: "ডিম্বাশয়ের সিস্ট হল এক ধরণের থলি, সাধারণত তরল দিয়ে ভরা থাকে। এই সিস্টগুলো ডিম্বাশয়ের ভিতরে বা উপরিভাগে হয়ে থাকে। মহিলাদের জরায়ুর দুপাশে একটি করে ডিম্বাশয় থাকে। অনেকেই এটিকে ডিম্বাশয়ের টিউমার মনে করে থাকেন।",
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rd1')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoDontknowEnum.getDataList(),
              valueTransformer: (value)=> 0
            ),
          ]
      ),
      ScreeningPage(
          page: 11,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "surgery_in_the_uterus_ovary_vagina.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 5,
            ),
            Content(
              key: 'rd2',
              label: "Do you have a history of  surgery  in the Uterus / Ovary / Vagina due to following causes? (Tumor related, Menstrual irregularity related, Birth defect related)",
              labelBn: "আপনার কি কখনো জরায়ু বা ডিম্বাশয় বা যোনিপথে উল্লিখিত কারণে কোন অপারেশন  হয়েছে? (টিউমার জনিত/ মাসিক বন্ধ জনিত/ জন্ম ত্রুটি জনিত)",
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'rd2')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),

      ScreeningPage(
          page: 12,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "lower_abdominal_pain_during_menstruation.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 6,
            ),
            Content(
                key: 'sm1',
                label: "Do you usually experience lower abdominal pain during menstruation?",
                labelBn: "আপনি কি সাধারণত মাসিকের সময় তলপেটে ব্যথা অনুভব করেন?",
                type: ContentEnum.LOWER_ABDOMIAL_PAIN,
                initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm1')?.answerText?.first: null,
                readOnly: isDetailsView,
                options: YesNoEnum.getDataList(),
                children:[
                  Content(
                    isVisible: !isDetailsView,
                    type: ContentEnum.IMAGE,
                    options: [Data(value: Utils.isLocaleEn()? "rating_severe_pain.png": "rating_severe_pain_bn.png")],
                  ),
                  Content(
                    key: 'sm2',
                    label: "How severe is the pain you usually experience?",
                    labelBn: "আপনি যে ব্যথা অনুভব করেন, সাধারণত তার তীব্রতা কত?",
                    type: ContentEnum.RADIO_GROUP,
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm2')?.answerText?.first: null,
                    readOnly: isDetailsView,
                    options: PainRatingEnum.getDataList(),
                    valueTransformer: (value)=> value==1?0:
                                                value==2?0:
                                                value==3?0:
                                                value==4?1:value
                  ),
                  Content(
                    key: 'sm3',
                    label: "Which pattern of pain do you usually experience during your menstruation from the following options? (You may select the option that most closely matches your usual pattern of pain)",
                    labelBn: "মাসিকের সময় নিচের কোন ধরনের ব্যথা সাধারণত আপনি অনুভব করেন? (সাধারণত যে ধরনের ব্যথা অনুভব করেন, তার সাথে সবচেয়ে বেশি মিলে যায় এমন অপশন নির্বাচন করতে পারবেন)",
                    type: ContentEnum.RADIO_GROUP,
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm3')?.answerText?.first: null,
                    readOnly: isDetailsView,
                    options: PatternOfPainEnum.getDataList(),
                    valueTransformer: (value)=> value==1?1:
                                                value==2?1:
                                                value==3?0:
                                                value==4?0:value,
                  ),
                  Content(
                    key: 'sm4',
                    label: "Does the pain gradually increase during each menstrual cycle compared to previous?",
                    labelBn: "প্রতি মাসে মাসিকের সময় ব্যথা কি আগের চেয়ে ধীরে ধীরে বেড়ে যায় বা বৃদ্ধি পায়?",
                    type: ContentEnum.RADIO_GROUP,
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm4')?.answerText?.first: null,
                    readOnly: isDetailsView,
                    options: YesNoOftenEnum.getDataList(),
                    valueTransformer: (value)=> value==2?1:value,
                  ),
                ]
            ),

          ]
      ),
      ScreeningPage(
          page: 13,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "taking_painkiller_during_menstruation.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 7,
            ),
            Content(
                key: 'sm7',
                label: "Do you usually take any painkillers for pain during menstruation?",
                labelBn: "আপনি কি সাধারণত মাসিকের সময় ব্যথার জন্য কোন ব্যাথানাশক ঔষধ খান?",
                type: ContentEnum.TAKE_ANY_PAINKILLER,
                options: YesNoEnum.getDataList(),
                initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm7')?.answerText?.first: null,
                readOnly: isDetailsView,
                children: [
                  Content(
                    key: 'sm8',
                    label: "Does the menstrual pain usually subside with medication?",
                    labelBn: "মাসিকের ব্যথা কি সাধারণত ঔষধ দিয়ে কমে যায় ?",
                    type: ContentEnum.RADIO_GROUP,
                    options: YesNoEnum.getDataList(),
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm8')?.answerText?.first: null,
                    readOnly: isDetailsView,
                    valueTransformer: (value)=> value==0?1:0,
                  ),
                ]
            ),
          ]
      ),
      ScreeningPage(
          page: 14,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "lower_abdominal_pain_for_six_month.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 8,
            ),
            Content(
              key: 'sm5',
              label: "For the last 6 months or more, have you experience lower abdominal pain aside from your menstrual period, and/or does this pain sometimes persist throughout the month?",
              labelBn: "গত ৬ মাস বা তার বেশি সময় ধরে, আপনি কি মাসিকের সময় বাদ দিয়ে তলপেটে ব্যথা অনুভব করেছেন, এবং/অথবা এই ব্যথা কি মাঝে মাঝে পুরো মাস জুড়ে থেকে যায়?",
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm5')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 15,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "pain_during_intercourse.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 9,
            ),
            Content(
              key: 'sm6',
              label: 'Do you experience pain during intercourse?',
              labelBn: 'আপনি কি সহবাসের সময় ব্যথা অনুভব করেন?',
              description: 'Pain that occurs during sexual intercourse and is felt in the deeper parts of the vagina or lower abdomen. The pain begins after some time of pain-free sexual activity.',
              descriptionBn: 'যৌন মিলনের সময় যে ব্যথা হয়, তা যোনিপথের গভীর অংশে বা তলপেটে অনুভূত হয়। যৌন মিলন শুরু করার কিছু সময় পর এই ব্যাথা শুরু হয়।',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sm6')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 16,
          contents: [
            Content(
              isVisible: !isDetailsView,
              readOnly: isDetailsView,
              type: ContentEnum.LABEL,
              figures: [
                Data(value: "constipation.png", labelEn: 'Constipation', labelBn: 'কোষ্ঠকাঠিন্য'),
                Data(value: "diarrhoea.png", labelEn: 'Diarrhoea', labelBn: 'ডায়রিয়া'),
                Data(value: "blood_in_stools.png", labelEn: 'Have blood in stools', labelBn: 'মলত্যাগ করলে মলের সাথে রক্ত আসা'),
                Data(value: "abdominal_fullness.png",labelEn: 'Feeling of abdominal fullness', labelBn: 'পেট ভরে গেছে এমন অনুভূতি'),
                Data(value: "nausea.png", labelEn: 'Nausea', labelBn: 'বমি বমি ভাব'),
                Data(value: "flatulence.png", labelEn: 'Flatulence', labelBn: 'পেট ফাঁপা'),
                Data(value: "abdominal_discomfort.png", labelEn: 'Abdominal discomfort during menstruation', labelBn: 'পেটে অস্বস্তি'),
              ],
              figuresColumn: 3
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 10,
            ),
            Content(
              key: 'smi1',
              label: 'Do you experience any one or more of the following during menstruation: constipation, diarrhea, have blood in stool, feeling of abdominal fullness, nausea, flatulence, or abdominal discomfort?',
              labelBn: 'মাসিক চলাকালীন সময়ে আপনি কি নিম্নলিখিত এক বা একাধিক সমস্যা অনুভব করেন: কোষ্ঠকাঠিন্য, ডায়রিয়া, মলত্যাগ করলে মলের সাথে রক্ত আসা, পেট ভরে গেছে এমন অনুভূতি, বমি বমি ভাব, পেট ফাঁপা অথবা পেটে অস্বস্তি?',
              type: ContentEnum.EXPERIENCE_CONSTIPATION,
              options: YesNoEnum.getDataList(),
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'smi1')?.answerText: null,
              readOnly: isDetailsView,
              children: [
                Content(
                    key: 'smi1_child',
                    type: ContentEnum.CHECKBOX_GROUP,
                    initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'smi1')?.answerText: null,
                    readOnly: isDetailsView,
                    options: [
                      Data(value: 1, labelEn: 'Constipation', labelBn: 'কোষ্ঠকাঠিন্য'),
                      Data(value: 2, labelEn: 'Diarrhoea', labelBn: 'ডায়রিয়া'),
                      Data(value: 3, labelEn: 'Have blood in stools', labelBn: 'মলত্যাগ করলে মলের সাথে রক্ত আসা'),
                      Data(value: 4, labelEn: 'Feeling of abdominal fullness', labelBn: 'পেট ভরে গেছে এমন অনুভূতি'),
                      Data(value: 5, labelEn: 'Nausea', labelBn: 'বমি বমি ভাব'),
                      Data(value: 6, labelEn: 'Flatulence', labelBn: 'পেট ফাঁপা'),
                      Data(value: 7, labelEn: 'Abdominal discomfort during menstruation', labelBn: 'পেটে অস্বস্তি')
                    ],
                ),
              ]
            ),
          ]
      ),
      ScreeningPage(
          page: 17,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "pain_during_defecation.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 11,
            ),
            Content(
              key: 'sd2',
              label: 'Do you have pain during defecation in your anus while you have your period?',
              labelBn: 'মাসিকের সময় যখন মলত্যাগ করেন, তখন কি আপনি পায়খানার রাস্তায় বা পায়ুপথে কোন ব্যথা অনুভব করেন?',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sd2')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 18,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "pain_while_urinate_during_menstruation.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 12,
            ),
            Content(
              key: 'sd1',
              label: 'Do you feel pain when you urinate during menstruation?',
              labelBn: 'মাসিকের সময় যখন মূত্রত্যাগ বা প্রস্রাব করেন, তখন কি আপনি প্রস্রাবের রাস্তায় কোন ব্যথা অনুভব করেন?',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'sd1')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 19,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "absent_from_work_during_periods.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 13,
            ),
            Content(
              key: 'smi3',
              label: 'Are you absent from class/work more often during your periods because of pain?',
              labelBn: 'আপনি কি ব্যথার কারণে মাসিকের সময় ক্লাসে /কাজে প্রায়ই অনুপস্থিত থাকেন?',
              type: ContentEnum.RADIO_GROUP,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'smi3')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
      ScreeningPage(
          page: 20,
          contents: [
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.IMAGE,
              options: [Data(value: "depressed_or_anxious_due_to_infertility.png")],
            ),
            Content(
              isVisible: !isDetailsView,
              type: ContentEnum.PAGE_INDICATOR,
              initialValue: 14,
            ),
            Content(
              key: 'smi2',
              type: ContentEnum.FEELING_DEPRESSED_ANXIOUS,
              initialValue: isDetailsView? inputs?.firstWhereOrNull((item)=>item?.questionCode == 'smi2')?.answerText?.first: null,
              readOnly: isDetailsView,
              options: YesNoEnum.getDataList(),
            ),
          ]
      ),
    ];
  }

  //transformer used globally
  AgeValueTrandformer(value){
    int age = DateTime.now().year - (value as DateTime).year;
    if(age < 30) return 0;
    else if(age >= 30 && age <= 49) return 1;
    else return 0;
  }

}