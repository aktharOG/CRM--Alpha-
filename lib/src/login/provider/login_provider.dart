// ignore_for_file: avoid_print

import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/services/cache/shared_pref_service.dart';
import 'package:crm_new/src/home/screens/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {
  SharedPreferenceController pref = SharedPreferenceController();
  //! Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //! checkBox
  bool _check = false;

  get checkValue => _check;

  onCheck() {
    _check = !_check;
    notifyListeners();
  }

  //! showPassword
  bool _showPassword = true;

  get visibility => _showPassword;

  onVisible() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  //! Api Calls
 bool isLogin = false;
  onLoginAPi(context) async {
    String? token = await FirebaseMessaging.instance.getToken()??'';
     isLogin = true;
     notifyListeners();
    final data = {
      "username": usernameController.text,
      "password": passwordController.text,
      "fcm": token
    };
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post, url: loginAPi, data: FormData.fromMap(data));
      if (response != null) {
        if (response.data["status"]) {
            isLogin = false;
     notifyListeners();
          Fluttertoast.showToast(msg: response.data["message"]);

         await ApiService.dioInitializerAndSetter(token: response.data["token"]);
          push(context, const HomeScreen());
        } else {
            isLogin = false;
     notifyListeners();
          Fluttertoast.showToast(msg: response.data["message"]);
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      print("login error : $e");
    }
  }
}
