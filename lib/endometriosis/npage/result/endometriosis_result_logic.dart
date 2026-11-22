import 'package:endometriosis_lib_flutter/endometriosis/npage/result/endometriosis_result_argument.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/api_config.dart';
import '../../dialog/toast_message.dart';
import '../../dto/result_dto.dart';
import '../../repository/endometriosis_repository.dart';
import '../detail_view/endometriosis_detail_result_view.dart';
import '../detail_view/endometriosis_detail_view_argument.dart';

class EndometriosisResultLogic extends RapidStartLogic {
  EndometriosisRepository repository = Get.find();
  late EndometriosisResultArgument arg;
  var result = (Get.arguments as EndometriosisResultArgument).result;
  var isNewScreening = (Get.arguments as EndometriosisResultArgument).isNewScreening;
  var referDoctorList = [
    'Dhaka Medical College (DMC)',
    'Sir Salimullah Medical College (SSMC)',
    'Combined Military Hospital (Dhaka)- (CMH)',
    'Bangladesh Medical University (BMU)',
    'OGSB Hospital and IRCH'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    arg = (Get.arguments as EndometriosisResultArgument);
  }

  getDetailsResultAndNavigateToView() {
    if(result!.id == null){
      Get.toNamed(EndometriosisDetailResultView.routeName, arguments: EndometriosisDetailsResultArgument(resultDto: result!));
    } else {
      globalState.showBusy(dismissible: true);
      repository.GET(Endpoints.getResultDetailsUrl(result!.userId!, result!.id!)).then((response){
        globalState.hideBusy();
        if(response.isOk) {
          Get.toNamed(EndometriosisDetailResultView.routeName, arguments: EndometriosisDetailsResultArgument(resultDto: ResultDto.fromJson(response.body['content'][0])));
        } else {
          ShowToast.error('something_wrong'.tr);
        }
      });
    }
  }
}