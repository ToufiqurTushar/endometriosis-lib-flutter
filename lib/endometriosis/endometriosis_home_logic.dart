import 'package:endometriosis_lib_flutter/endometriosis/dto/result_dto.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/api_config.dart';
import '../common/method/utils.dart';
import 'dialog/toast_message.dart';
import 'repository/endometriosis_repository.dart';

class EndometriosisHomeLogic extends RapidStartLogic {
  final int? userId;
  final int? birthDate;
  EndometriosisHomeLogic({this.userId, this.birthDate});

  final EndometriosisRepository repository = Get.find();

  final resultList = <ResultDto>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {

  }

  getData() async {
    globalState.showBusy();
    repository.GET(Endpoints.getListByUserIdUrl(userId!, size: 10)).then((response){
      globalState.hideBusy();
      if(response.isOk) {
        resultList.value = ResultDto.fromJsonList(response.body['content']);
      } else {
        ShowToast.error('something_wrong'.tr);
      }
    });
  }
  toggleLanguage() {
    if(Utils.isLocaleEn()){
      globalState.changeLocale("bn_BD");
    } else {
      globalState.changeLocale("en_US");
    }
  }
}
