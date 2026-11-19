import 'package:endometriosis_lib_flutter/endometriosis/nview/build_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/extend/rapid_start_logic.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:get/get.dart';
import '../../dto/screening_page.dart';
import '../../repository/endometriosis_repository.dart';
import 'endometriosis_detail_view_argument.dart';




class EndometriosisDetailResultLogic extends RapidStartLogic {
  final EndometriosisRepository endometriosisRepository = Get.find();
  EndometriosisDetailsResultArgument args = Get.arguments;

  //variable
  final form = GlobalKey<FormBuilderState>();
  List<Widget> tabBarTabs = [];
  List<Widget> tabBarViewChildren = [];
  List<ScreeningPage> screeningPages = [];


  @override
  void onInit() {
    super.onInit();
    RLog.error(args.resultDto.toJson());
  }

  @override
  void onReady() {
    super.onReady();
    getQuestionsOptionsAndAnswers();
  }

  @override
  void onClose() {}

  getQuestionsOptionsAndAnswers() async {
    globalState.showBusy();
    try{
      screeningPages = endometriosisRepository.getScreeningPages();
    } catch(e){

    } finally{
      globalState.hideBusy();
    }
    await buildTabBarAndView();

  }

  buildTabBarAndView() async{
    tabBarTabs = [
      Tab(child: Wrap(children: [Text("label_personal_history_based_question".tr, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),)], ), ),
      Tab(child: Wrap(children: [Text("label_risk_factor_based_question".tr, textAlign: TextAlign.center,style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),)], ), ),
      Tab(child: Wrap(children: [Text("label_symptom_based_question".tr, textAlign: TextAlign.center,style: const TextStyle(fontSize: 13, fontFamily: 'Roboto'),)], ), ),
    ];
    

    tabBarViewChildren = [
      //label_personal_history_based_question
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(children:[
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[0],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[1],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    topPageMargin: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[2],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    topPageMargin: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[3],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    topPageMargin: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[4],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    topPageMargin: 0,
                    background: Colors.white
                )
              ]),
            ),
          )
      ),
      //label_risk_factor_based_question
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(children:[
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[5],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[6],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[7],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[8],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[9],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[10],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
              ]),
            ),
          )
      ),
      //label_symptom_based_question
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(children:[
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[11],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[12],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[13],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[14],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[15],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[16],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[17],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[18],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
                buildEachPage(
                    endometriosisRepository.getScreeningPages(isDetailsView: true, inputs: args.resultDto.input)[19],
                    Get.context, form,
                    elevation: 0,
                    padding: 0,
                    background: Colors.white
                ),
              ]),
            ),
          )
      ),
    ];
  }
}
