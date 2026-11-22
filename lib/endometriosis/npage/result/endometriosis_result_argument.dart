import 'package:endometriosis_lib_flutter/endometriosis/dto/result_dto.dart';

class EndometriosisResultArgument {
  EndometriosisResultArgument({
    this.result,
    this.isNewScreening,
    this.isCoreUserAppOrI4WeMemberApp = false,
    this.isCoreAgentAppOrI4WeAgentApp = false,
  });

  ResultDto? result;
  bool? isNewScreening;
  bool isCoreUserAppOrI4WeMemberApp;
  bool isCoreAgentAppOrI4WeAgentApp;

}