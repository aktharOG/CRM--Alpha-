import 'dart:convert';

import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/models/profile_model.dart';
import 'package:crm_new/models/stages_model.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/services/cache/shared_pref_service.dart';
import 'package:crm_new/src/login/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  //! checkbox


  setCheckValue(StagesModel model) {
    model.isActive = !model.isActive;
    notifyListeners();
  }

 

  //! expansion tile




  onExpand(StagesModel model) {
    model.isExpanded = ! model.isExpanded;
    notifyListeners();
  }



  // floating action button options
  bool isopen = false;

  openFloat() {
    isopen = !isopen;
    notifyListeners();
  }

  //! API CALLS

  //! profile fetch

  ProfileModel? profileModel;
  bool isProfileLoading = false;
  onFetchProfileAPI() async {
    isProfileLoading = true;
    notifyListeners();
    try {
      final Response? response = await ApiService.apiMethodSetup(
        method: apiMethod.post,
        url: profileAPI,
      );
      if (response != null) {
        if (response.data["status"]) {
          final data = jsonEncode(response.data["profileDetails"]);
          profileModel = profileModelFromJson(data);
          isProfileLoading = false;
          notifyListeners();

          if (profileModel != null) {
            print(profileModel!.name);
          }
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      print("login error : $e");
    }
  }

  bool isLogout = false;
  onLogoutAPI(context) async {
    isLogout = true;
    notifyListeners();
    final data = {"fcm": "test_fcm"};
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post, url: logoutAPI, data: FormData.fromMap(data));
      if (response != null) {
        if (response.data["status"]) {
          isLogout = false;
          notifyListeners();
          Fluttertoast.showToast(msg: response.data["message"]);
          SharedPreferencesService.prefs.clear();
          push(context, const LoginScreen());
        } else {
          isLogout = false;
          notifyListeners();
          Fluttertoast.showToast(msg: "something went wrong");
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      print("login error : $e");
    }
  }


  
}
