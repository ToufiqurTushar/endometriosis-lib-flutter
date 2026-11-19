import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:endometriosis_lib_flutter/endometriosis/npage/result/nview/refer_doctoc_list_dialog.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/color_config.dart';
import '../../endometriosis_home_i18n.dart';
import '../../nview/form/simple_button.dart';
import '../../nview/item_banner_image.dart';
import '../../references/references_view.dart';
import '../../repository/endometriosis_repository.dart';
import 'endometriosis_result_logic.dart';

class EndometriosisResultView extends RapidView<EndometriosisResultLogic> {
  static String routeName = "/endometriosis_result";

  const EndometriosisResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>Get.back(),),
        title: Text('title_result'.tr),
        backgroundColor: Colors.white,
        foregroundColor: ColorConfig.textFieldIconColor,
        titleTextStyle: const TextStyle(fontSize: 18, color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: ColorConfig.backgroundColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(child: BodyContainer(context))
        ],),
      ),
      bottomNavigationBar: SimpleWideButton('See References and Citations'.tr, background: Colors.white30,textStyle: TextStyle(color: Colors.black), onPressed:()=> Get.to(() => const ReferencesCitationsView(), fullscreenDialog: true)),
    );
  }

  BodyContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                ItemBannerImage(image: 'positive_result.png'),
                const SizedBox(height: 20,),
                Card(
                  color: controller.result!.colorCode!.toColor(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(controller.result!.getRiskScale()!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                  )
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controller.result!.getResult()!, textAlign: TextAlign.center,style: const TextStyle(fontSize: 16)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlexButton('label_view'.tr, background: ColorConfig.textFieldIconColor, textStyle: TextStyle(color: Colors.white), onPressed:()=> {
                        controller.getDetailsResultAndNavigateToView(),
                      }),
                    ),
                    Visibility(
                      visible: controller.isNewScreening??false,
                      child: Expanded(
                        child: FlexButton('label_refer'.tr, background: ColorConfig.textFieldIconColor, textStyle: TextStyle(color: Colors.white), onPressed:(){
                          showDialog(
                            context: Get.context!,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey.shade100,
                                insetPadding: const EdgeInsets.all(16),
                                contentPadding: const EdgeInsets.all(8.0),
                                titlePadding: const EdgeInsets.all(0),
                                title: Container(),
                                content: SingleChildScrollView(
                                  child: ReferDoctocListDialog(),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SimpleWideButton('label_end'.tr, background: Colors.white,textStyle: TextStyle(color: ColorConfig.textFieldIconColor), onPressed:()=> Get.back()),
                ),
              ]
          ),
        )
      ],
    );
  }



  @override
  void loadDependentLogics() {
    Get.lazyPut<EndometriosisRepository>(() => EndometriosisRepository());
    Get.lazyPut<EndometriosisResultLogic>(() => EndometriosisResultLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return EndometriosisHomeI18N.getTranslations();
  }
}
