import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import '../../../config/color_config.dart';
import '../../endometriosis_home_i18n.dart';
import '../../nview/form/simple_button.dart';
import '../../repository/endometriosis_repository.dart';
import 'endometriosis_detail_result_logic.dart';


class EndometriosisDetailResultView extends RapidView<EndometriosisDetailResultLogic> {
  static const routeName = '/endometriosis_detail_result';
  const EndometriosisDetailResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Get.back(),),
        title: Text('title_result'.tr),
        backgroundColor: Colors.white,
        foregroundColor: ColorConfig.textFieldIconColor,
        titleTextStyle: const TextStyle(fontSize: 18, color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: ColorConfig.backgroundColor,
      body: SafeArea(
        child: Obx(
          ()=> Column(
            children: [
              Expanded(
                  child:  buildBody(context)
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SimpleWideButton('label_end'.tr, background: Colors.white,textStyle: TextStyle(color: ColorConfig.textFieldIconColor), onPressed:()=> Get.back()),
        ),
      ),
    );

  }

  buildBody(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: !controller.globalState.isSystemBusy.value && controller.screeningPages.isEmpty,
          child: Align(
            alignment: Alignment.center,
            child: Text('no_information_found'.tr),
          ),
        ),
        Visibility(
          visible: controller.screeningPages.isNotEmpty,
          child: builBodyContainer(context)
        ),
      ],
    );
  }

  builBodyContainer(BuildContext context) {
    //return Text('1');
    return DefaultTabController(
      initialIndex: 0,
      length: controller.tabBarTabs.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Card(
              child: Container(
                height: 60,
                child: TabBar(
                  isScrollable: false,
                  indicatorColor: ColorConfig.textFieldIconColor,
                  unselectedLabelColor: ColorConfig.textFieldHintColor,
                  labelColor: Colors.black,
                  indicatorWeight: 4,
                  tabs: controller.tabBarTabs,
                ),
              ),
            ),
          ),
          Expanded(
            child: FormBuilder(
              key:  controller.form,
              child: TabBarView(
                  children: controller.tabBarViewChildren
              ),
            ),
          )
        ]
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
    Get.lazyPut<EndometriosisRepository>(() => EndometriosisRepository(),);
    Get.lazyPut<EndometriosisDetailResultLogic>(() => EndometriosisDetailResultLogic(),);
  }
}
