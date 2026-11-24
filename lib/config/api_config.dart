import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:endometriosis_lib_flutter/config/pref_key.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:flutter_rapid/logic/rapid_global_state_logic.dart';


class BaseUrl{
  static String baseDevURL = "https://core-dev.cmedhealth.com/";
  static String baseStageURL = "https://core-stage.cmedhealth.com/";
  static String baseBetaURL = "https://dhc-beta.cmedhealth.com/";
  static String baseProductionURL = "https://core-prod.cmedhealth.com/";
}
class Endpoints {
  static String getListByUserIdUrl(int userId, {int size = 200}){
    return 'api/v1/endometriosis/get-result/by/user?user_id=$userId&size=${size}';
  }

  static String postAnswerUrl(int userId){
    return 'api/v1/endometriosis/get-result?user_id=$userId';
  }
  static String getResultDetailsUrl(int userId, int id){
    return 'api/v1/endometriosis/get-history?user_id=$userId&id=$id';
  }

  static String postAnswerToBundleUrl(){
    return 'api/v7/bundles';
  }
}

class HttpProvider {
  final RapidEnvConfig appBaseConfig = Get.find();
  final RapidPreferenceStore preferenceStore = Get.find();
  final RapidGlobalStateLogic globalState = Get.find();
  late final dio.Dio dioClient;
  dio.CancelToken requestToken = dio.CancelToken();

  HttpProvider(){
    print('${appBaseConfig.baseUrl} is set as baseurl');
    RLog.info(
      '╔══════════════════════════ Server ══════════════════════════\n'
       'BASE_URL ║ ${appBaseConfig.baseUrl}\n'
       'TOKEN ║ ${preferenceStore.read(PrefKey.accessToken)}'
    '\n╚══════════════════════════ Server ══════════════════════════',
    );
    dioClient = dio.Dio(
      dio.BaseOptions(
        baseUrl: appBaseConfig.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': '*',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.addAll([
      NetworkAndLoggingInterceptor(requestToken),
    ]);

    if(appBaseConfig.enableBanner) {
      dioClient.interceptors.add(ChuckerDioInterceptor());
    }
  }

  Future<Response> GET(String path, {data, bool requiredBearerToken = true, String? token, bool checkForceUpdate = false}) async {
    dioClient.options.headers["Authorization"] = requiredBearerToken? "Bearer ${token??preferenceStore.read(PrefKey.accessToken)}": null;
    try {
      var response = await dioClient.get(path, queryParameters: data);
      if(checkForceUpdate){
        checkForceUpdateFromResponse(response);
      }
      if (response.statusCode == 200) {
        return Response(body:response.data, statusCode: response.statusCode);
      } else {
        return Response(body:response.data, statusCode: response.statusCode);
      }
    } on dio.DioException catch (e) {
      final errorMsg = handleDioError(e);
      return Response(body:errorMsg, statusCode: e.response?.statusCode);
    }
  }
  Future<Response> POST(String path, data, {bool requiredBearerToken = true, String? token, bool checkForceUpdate = false}) async {
    dioClient.options.headers["Authorization"] = requiredBearerToken? "Bearer ${token??preferenceStore.read(PrefKey.accessToken)}": null;
    try {
      var response = await dioClient.post(path, data: data);
      if(checkForceUpdate){
        checkForceUpdateFromResponse(response);
      }
      if (response.statusCode == 200) {
        return Response(body:response.data, statusCode: 200);
      } else {
        return Response(body:response.data, statusCode: response.statusCode);
      }
    } on dio.DioException catch (e) {
      final errorMsg = handleDioError(e);
      return Response(body:errorMsg, statusCode: e.response?.statusCode);
    }
  }
  Future<Response> PATCH(String path, data,{ bool requiredBearerToken = true, String? token, bool checkForceUpdate = false}) async {
    dioClient.options.headers["Authorization"] = requiredBearerToken? "Bearer ${token??preferenceStore.read(PrefKey.accessToken)}": null;
    try {
      var response = await dioClient.patch(path, data: data);
      if(checkForceUpdate){
        checkForceUpdateFromResponse(response);
      }
      if (response.statusCode == 200) {
        return Response(body:response.data, statusCode: 200);
      } else {
        return Response(body:response.data, statusCode: response.statusCode);
      }
    } on dio.DioException catch (e) {
      final errorMsg = handleDioError(e);
      return Response(body:errorMsg, statusCode: e.response?.statusCode);
    }
  }
  Future<Response> DELETE(String path, {data, bool requiredBearerToken = true, String? token, bool checkForceUpdate = false}) async {
    dioClient.options.headers["Authorization"] = requiredBearerToken? "Bearer ${token??preferenceStore.read(PrefKey.accessToken)}": null;
    try {
      var response = await dioClient.delete(path, data: data);
      if(checkForceUpdate){
        checkForceUpdateFromResponse(response);
      }
      if (response.statusCode == 200) {
        return Response(body:response.data, statusCode: 200);
      } else {
        return Response(body:response.data, statusCode: response.statusCode);
      }
    } on dio.DioException catch (e) {
      final errorMsg = handleDioError(e);
      return Response(body:errorMsg, statusCode: e.response?.statusCode);
    }
  }

  void checkForceUpdateFromResponse(dio.Response response) {
    String versionKey = Platform.isAndroid ? 'x-supported-min-android-cmed-agent-app-version' : 'x-supported-min-ios-cmed-agent-app-version';
    if ((response.headers.map.containsKey(versionKey))) {
      int serverAppVersionCode = int.parse(response.headers.map[versionKey]![0]);
      // AppInfo.getVersionNumber().then((value) {
      //   int deviceAppVersionCode = int.parse(value.replaceAll(".", ""));
      //   RLog.info('deviceVersion:$deviceAppVersionCode-serverVersion:$serverAppVersionCode');
      //   if (deviceAppVersionCode < serverAppVersionCode) {
      //     //showForceUpdateDialog();
      //   }
      // });
    }
  }
}

class NetworkAndLoggingInterceptor extends dio.Interceptor {
  final dio.CancelToken requestToken;
  NetworkAndLoggingInterceptor(this.requestToken);

  final RapidGlobalStateLogic globalState = Get.find();
  Future checkNetwork(dio.RequestOptions requestOptions, dio.RequestInterceptorHandler handler) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)
    ) {
      RLog.info(
        '╔══════════════════════════ Request ══════════════════════════\n'
         'URL ║ ${requestOptions.path}\n'
         'REQUEST METHOD ║ ${requestOptions.method.toUpperCase()}'
      '\n╚══════════════════════════ Request ══════════════════════════',
      );
      log('REQUEST DATA ║ ${requestOptions.data.toString()}\n');
      return super.onRequest(requestOptions, handler);
    } else {
      requestToken.cancel('message_no_internet'.tr);
      globalState.hideBusy();
      handler.next(requestOptions);
    }
  }

  @override
  void onRequest(dio.RequestOptions requestOptions, dio.RequestInterceptorHandler handler) {
    checkNetwork(requestOptions, handler);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    RLog.warning(
        '╔══════════════════════════ Response ══════════════════════════\n'
         'STATUS_CODE ║ ${response.statusCode}\n'
         'DATA ║ ${response.data?.toString() ?? ''}'
      '\n╚══════════════════════════ Response ══════════════════════════'
    );

    return super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioException error, dio.ErrorInterceptorHandler handler) {
    return super.onError(error, handler);
  }
}

String handleDioError(dio.DioException error) {
  RLog.error(
      '╔══════════════════════════ Response ══════════════════════════\n'
        'STATUS_CODE ║ ${error.response?.statusCode}\n'
        'DATA ║ ${error.response?.toString() ?? ''}'
    '\n╚══════════════════════════ Response ══════════════════════════'
  );
  switch (error.type) {
    case dio.DioExceptionType.connectionTimeout:
    case dio.DioExceptionType.sendTimeout:
    case dio.DioExceptionType.receiveTimeout:
      return "Timeout occurred!";
    case dio.DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        switch (statusCode) {

        }
      }
      break;
    case dio.DioExceptionType.cancel:
      break;
    case dio.DioExceptionType.unknown:
      return "No Internet Connection";
    case dio.DioExceptionType.badCertificate:
      return "Internal Server Error";
    case dio.DioExceptionType.connectionError:
      return "message_no_internet".tr;
    default:
      return "Unknown Error";
  }
  return "Unknown Error";
}