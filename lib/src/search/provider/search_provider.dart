import 'dart:convert';

import 'package:crm_new/models/project_model.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  
   TextEditingController searchController = TextEditingController();
     List<ProjectModel> searchList = [];  
      
        

        
  bool isSearch = false;
  onSearch(value) async {
    isSearch = true;
    notifyListeners();
    final data = {
      "keyword": value
    };
    try {
      final Response? response = await ApiService.apiMethodSetup(
        method: apiMethod.post,
        url: projectAPI,
        data: FormData.fromMap(data)
      );
      if (response != null) {
         isSearch = false;
          notifyListeners();
        if (response.data["status"]) {
         
          final data = jsonEncode(response.data["Projects"]);
           print(projectModelFromJson(data));
          searchList = projectModelFromJson(data);
         
           print("search count : ${searchList.length}");
        }else{
          
        }

        print("response : ${response.data}");
      }
    } catch (e) {
       isSearch = false;
          notifyListeners();
      print("search error : $e");
    }
  }
}