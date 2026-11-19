import 'package:flutter_rapid/flutter_rapid.dart';
import 'api_config.dart';

enum EnvTypeEnum{ DEV, STAGE, PROD }
class AppBaseConfig extends RapidEnvConfig {
  String baseUrl = BaseUrl.baseDevURL;
  MaterialColor primarySwatch = Colors.green;
  Color primaryAccent = Colors.greenAccent;
}

class DevConfig extends AppBaseConfig {
  String bannerTitle = EnvTypeEnum.DEV.name;
  String baseUrl = BaseUrl.baseDevURL;
}

class StageConfig extends AppBaseConfig {
  String bannerTitle = EnvTypeEnum.STAGE.name;
  String baseUrl = BaseUrl.baseStageURL;
}

class ProdConfig extends AppBaseConfig {
  bool debug = false;
  bool enableLog = false;
  bool enableBanner = false;
  String bannerTitle = EnvTypeEnum.PROD.name;
  String baseUrl = BaseUrl.baseProductionURL;
}
