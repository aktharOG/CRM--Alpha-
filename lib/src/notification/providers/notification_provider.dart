import 'dart:convert';

import 'package:crm_new/models/notification_model.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier{

    List<NotificationModel> notificationList = [];
  
    bool isNotificationFetching = false;
  onFetchProjectList() async {
    isNotificationFetching = true;
    notifyListeners();
   
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post,
          url: notificationAPI,
      );
      if (response != null) {
        isNotificationFetching = false;
        notifyListeners();
        if (response.data["status"]) {
          final data = jsonEncode(response.data["expanses"]);
          // print(notificationModelFromJson(data));
          notificationList = notificationModelFromJson(data);

          print("search count : ${notificationList.length}");
        } else {}

        print("response : ${response.data}");
      }
    } catch (e) {
      isNotificationFetching = false;
      notifyListeners();
      print("search error : $e");
    }
  }

}