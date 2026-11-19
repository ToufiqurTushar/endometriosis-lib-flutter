import 'package:flutter_rapid/flutter_rapid.dart';
import '../endometriosis/endometriosis_home_view.dart';
import '../endometriosis_app_registry.dart';
import 'env_config.dart';
import 'theme_config.dart';

class AppSystemConfig extends RapidSystemConfig {
  String appTitle = "Endometriosis Screening";
  ThemeData theme = themeData;
  ThemeData darkTheme = themeData;

  Map<String, Locale> availableLocal = {
    "bn_BD": const Locale('bn', 'BD'),
    "en_US": const Locale('en', 'US')
  };
  String? initialRoute = EndometriosisHomeView.routeName;

  List<RapidModuleRegistry> modules = [
    EndometriosisAppRegistry(),
  ];

  RapidSplashScreenData splashScreenData = RapidSplashScreenData()
      .setAppName("Endometriosis App")
      .setCopyRight('CMED')
      .setLogo('assets/images/logo.png').disable();

  String currentEnv = EnvTypeEnum.DEV.name;
  Map<String, RapidEnvConfig> availableEnvironment = {
    EnvTypeEnum.DEV.name: DevConfig(),
    EnvTypeEnum.STAGE.name: StageConfig(),
    EnvTypeEnum.PROD.name: ProdConfig(),
  };

  initConfig(var env) {
    return Get.put<RapidEnvConfig>(env);
  }

  Future<void> onAppStartup() async {

  }
}
