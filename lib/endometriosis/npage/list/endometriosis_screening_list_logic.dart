import 'package:endometriosis_lib_flutter/endometriosis/dto/result_dto.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/api_config.dart';
import '../../dialog/toast_message.dart';
import '../../repository/endometriosis_repository.dart';
import 'endometriosis_screening_list_argument.dart';

class EndometriosisScreeningListLogic extends RapidStartLogic {
  final EndometriosisRepository repository = Get.find();
  final userId = (Get.arguments as EndometriosisScreeningListArgument ).userId;

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
    repository.GET(Endpoints.getListByUserIdUrl(userId!)).then((response){
      globalState.hideBusy();
      if(response.isOk) {
        resultList.value = ResultDto.fromJsonList(response.body['content']);
      } else {
        ShowToast.error('something_wrong'.tr);
      }
    });
  }
}
