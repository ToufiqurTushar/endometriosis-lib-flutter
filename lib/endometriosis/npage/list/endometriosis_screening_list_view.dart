 import 'package:endometriosis_lib_flutter/common/extension/string_extension.dart';
import 'package:endometriosis_lib_flutter/endometriosis/npage/result/endometriosis_result_argument.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:intl/intl.dart';

import '../../../../config/color_config.dart';
import '../../endometriosis_home_i18n.dart';
import '../../nview/form/simple_button.dart';
import '../../references/references_view.dart';
import '../result/endometriosis_result_view.dart';
import '../../repository/endometriosis_repository.dart';
import 'endometriosis_screening_list_logic.dart';
import 'nview/item_screening_list.dart';

class EndometriosisScreeningListView extends RapidView<EndometriosisScreeningListLogic> {
  static const routeName = '/endometriosis_screening_list_view';

  const EndometriosisScreeningListView();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Get.back(),),
        title: Text('title_screening_list'.tr),
        backgroundColor: Colors.white,
        foregroundColor: ColorConfig.textFieldIconColor,
        titleTextStyle: const TextStyle(fontSize: 18, color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: ColorConfig.textFieldIconColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: builListContainer(context)
          )
        ],),
      ),

    ));
  }

  builListContainer(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount:controller.resultList.length,
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
        ),
        Visibility(
          visible: !controller.globalState.isSystemBusy.value && controller.resultList.isEmpty,
          child: Align(
            alignment: Alignment.center,
            child: Text('no_information_found'.tr),
          ),
        )
      ],
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
    Get.lazyPut<EndometriosisScreeningListLogic>(() => EndometriosisScreeningListLogic(),);
  }
}
