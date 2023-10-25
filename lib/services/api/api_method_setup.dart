// ignore_for_file: use_build_context_synchronously, deprecated_member_use, camel_case_types, avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/main.dart';
import 'package:crm_new/services/cache/shared_pref_service.dart';
import 'package:crm_new/src/login/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

// String baseUrl = "https://purchasebids.noviindus.in";
enum apiMethod {
  get,
  post,
  delete,
  update,
}

class ApiService {
  static Map errorResponse = {};
  static Dio dio = Dio();

  static Future<void> dioInitializerAndSetter({required String token}) async {
    if (token.length > 5) {
      String tokenFromShared;
      await SharedPreferencesService.prefs.setString("token", token);
      tokenFromShared = SharedPreferencesService.prefs.getString("token")!;
      log("token : $tokenFromShared");
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $tokenFromShared';

      print("set token");
    }
  }

  ///token remover
  static Future<void> tokenRemover() async {
    dio.options.headers["Authorization"] = "";
    print("token remover");
  }

  ///api method set up
  static Future<Response<dynamic>?> apiMethodSetup(
      {required apiMethod method,
      required String url,
      var data,
      var queryParameters,
      Function(int, int)? onSendProgress,
      Function(int, int)? onRecieveProgress,
      Options? options}) async {
    dio.options.baseUrl = "https://crm-alpha.noviindus.in/api/";
    dio.options.connectTimeout = const Duration(milliseconds: 10000);
    dio.options.receiveTimeout = const Duration(milliseconds: 10000);
    dio.options.contentType = Headers.acceptHeader;
    try {
      Response? response;
      switch (method) {
        case apiMethod.get:
          if (data != null) {
            response = await dio.get(url,
                queryParameters: data, options: options ?? Options());
          } else {
            response = await dio.get(url, options: options ?? Options());
          }
          break;
        case apiMethod.post:
          response = await dio.post(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
        case apiMethod.delete:
          // ignore: todo
          // TODO: Handle this case.
          break;
        case apiMethod.update:
          // ignore: todo
          // TODO: Handle this case.
          break;
      }
      return response;
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 401) {
        errorResponse["status"] = "401";
        errorResponse["message"] = "Authorization error";
        Fluttertoast.showToast(msg: 'Authorization error');
        SharedPreferencesService.prefs.clear();
        pushAndRemoveUntil(
            navigatorKey.currentState!.context, const LoginScreen());
        print(errorResponse);
      } else if (e.response?.statusCode == 500) {
        Fluttertoast.showToast(msg: 'Server Error');
      } else if (e.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(msg: 'Check your network speed');
      } else if (e.type == DioErrorType.connectionTimeout) {
        Fluttertoast.showToast(msg: 'Check your connectivity');
      } else if (e.error is SocketException) {
        errorResponse["status"] = "101";
        errorResponse["message"] = "internet error";
        Fluttertoast.showToast(msg: 'Please check your network');
        print(errorResponse);
      } else {
        print("103");
      }
    }
    return null;
  }
}
