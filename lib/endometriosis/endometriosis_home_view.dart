import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:endometriosis_lib_flutter/endometriosis/npage/list/endometriosis_screening_list_argument.dart';
import 'package:endometriosis_lib_flutter/endometriosis/references/references_view.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:intl/intl.dart';
import '../config/color_config.dart';
import 'endometriosis_home_i18n.dart';
import 'endometriosis_home_logic.dart';
import 'npage/list/endometriosis_screening_list_view.dart';
import 'npage/list/nview/item_screening_list.dart';
import 'npage/result/endometriosis_result_argument.dart';
import 'npage/result/endometriosis_result_view.dart';
import 'npage/screening/endometriosis_screening_logic.dart';
import 'npage/screening/endometriosis_screening_view.dart';
import 'npage/screening/endometriosis_screening_argument.dart';
import 'nview/form/simple_button.dart';
import 'repository/endometriosis_repository.dart';

class EndometriosisHomeView extends RapidView<EndometriosisHomeLogic> {
  static String routeName = "/endometriosis_home";

  const EndometriosisHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.textFieldIconColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap:()=>Get.toNamed(EndometriosisScreeningView.routeName, arguments: EndometriosisScreeningArgument(userId: controller.userId, birthDate: controller.birthDate)),
                child: Container(
                  height: 206,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Image.asset('assets/images/endometriosis/positive_result.png', height: 150, package: 'endometriosis_lib_flutter'),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('label_start_screening'.tr, style: const TextStyle(fontSize:18,),),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Image.asset('assets/images/endometriosis/endometriosis_bg_top_left.png',height: 50, package: 'endometriosis_lib_flutter'),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child:Image.asset('assets/images/endometriosis/endometriosis_bg_bottom_right.png',height: 50, package: 'endometriosis_lib_flutter'),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child:TextButton(onPressed: (){
                      //     controller.toggleLanguage();
                      //   }, child: Text('app_language'.tr))
                      // ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('title_result'.tr, style: const TextStyle(color: Colors.white),),
                  ),
                  InkWell(
                      onTap: ()=>Get.toNamed(EndometriosisScreeningListView.routeName, arguments: EndometriosisScreeningListArgument(userId: controller.userId)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Text('label_see_all'.tr,style: const TextStyle(color: Colors.white)),
                            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white,),
                          ],
                        ),
                      )
                  )
                ],
              ),
              Expanded(
                  child:Card(
                    child: Obx(
                      ()=> Stack(
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.zero,
                              itemCount:controller.resultList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var result = controller.resultList[index];
                                var title = result.getRiskScale()!;
                                var subtitle = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(result.createdAt??DateTime.now().millisecondsSinceEpoch)).trDigit();
                                var date = DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch((result.createdAt??DateTime.now().millisecondsSinceEpoch))).trDigit();
                                return ScreeningListItem(context: context, title: title, subtitle: subtitle, color: result.colorCode!.toColor(), date: date , onTap:(){
                                  Get.toNamed(EndometriosisResultView.routeName, arguments: EndometriosisResultArgument(result: result));
                                });
                              }
                          ),
                          Visibility(
                            visible: !controller.globalState.isSystemBusy.value && controller.resultList.isEmpty,
                            child: Center(child: Text('no_information_found'.tr)),
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SimpleWideButton('See References and Citations'.tr, background: Colors.white54,textStyle: TextStyle(color: Colors.black), onPressed:()=> Get.to(() => const ReferencesCitationsView(), fullscreenDialog: true)),
      ),
    );
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return EndometriosisHomeI18N.getTranslations();
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  void loadDependentLogics() {
    Get.lazyPut<EndometriosisRepository>(() => EndometriosisRepository());
    Get.lazyPut<EndometriosisHomeLogic>(() => EndometriosisHomeLogic(userId: 4208495, birthDate: 1728286541000));
    //Get.lazyPut<EndometriosisScreeningLogic>(() => EndometriosisScreeningLogic());
  }
}
