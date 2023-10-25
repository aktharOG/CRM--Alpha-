import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/models/category_model.dart';
import 'package:crm_new/models/expense_model.dart';
import 'package:crm_new/models/project_model.dart';
import 'package:crm_new/models/stages_model.dart';
import 'package:crm_new/models/status_model.dart';
import 'package:crm_new/services/api/api_method_setup.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProjectProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descreptionController = TextEditingController();
  File? imageFile;
  List<MultipartFile> imageFilesList = [];
  List<String> imageListString = [];

  //varies

  String selectedStage = "";
  String selectedStatus = "Pending";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Completed", child: Text("Completed")),
      const DropdownMenuItem(value: "Processing", child: Text("Processing")),
      const DropdownMenuItem(value: "Pending", child: Text("Pending")),
    ];
    return menuItems;
  }

  String changeStatus(StagesModel stagesModel) {
    print('stages : ${stagesModel.stageStatus}');
    switch (stagesModel.stageStatus) {
      case 1:
        selectedStatus = "Completed";
        break;
      case 2:
        selectedStatus = "Processing";
        break;
      case 3:
        selectedStatus = "Pending";
        break;
    }
    return selectedStatus;
  }

  int statusID = 1;
  int changeStatusID(value) {
    print('stages : $value');
    switch (value) {
      case "Completed":
        statusID = 1;
        break;
      case "Processing":
        statusID = 2;
        break;
      case "Pending":
        statusID = 3;
        break;
    }
    notifyListeners();
    return statusID;
  }

  onChangedStatus(value, StagesModel stagesModel) {
    stagesModel.stageStatus = changeStatusID(value);
    onChnageStatusAPI(stagesModel.id, statusID);
    notifyListeners();
  }

  // pick image
  pickImage({required ImageSource source}) async {
    await ImagePicker().pickImage(source: source).then((value) {
      imageFile = File(value!.path);
      notifyListeners();
    });
    notifyListeners();
  }

  pickMultiImage() async {
    await ImagePicker().pickMultiImage().then((value) async {
      for (var i = 0; i < value.length; i++) {
        imageListString.add(value[i].path);
        MultipartFile multipartFile = await MultipartFile.fromFile(
            value[i].path,
            filename: value[i].path.split('/').last);
        imageFilesList.add(
          multipartFile,
        );
        notifyListeners();
      }
      print(imageListString);
      print(imageFilesList.length);
    });

    notifyListeners();
  }

  removeImage() {
    imageFile = null;
    imageFilesList.clear();
    imageListString.clear();
    notifyListeners();
  }

  // pick date
  String? dateTime;
  DateTime? dateTimeOG;
  pickDate(context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2050))
        .then((value) {
      if (value != null) {
        dateTime =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(value.toString()));
        dateTimeOG = value;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  //! apis

  //! fetch project list
  List<ProjectModel> projectList = [];

  bool iSProjectFetching = false;
  onFetchProjectList() async {
    iSProjectFetching = true;
    notifyListeners();
    final data = {"keyword": ""};
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post,
          url: projectAPI,
          data: FormData.fromMap(data));
      if (response != null) {
        iSProjectFetching = false;
        notifyListeners();
        if (response.data["status"]) {
          final data = jsonEncode(response.data["Projects"]);
          print(projectModelFromJson(data));
          projectList = projectModelFromJson(data);

          print("search count : ${projectList.length}");
        } else {}

        print("response : ${response.data}");
      }
    } catch (e) {
      iSProjectFetching = false;
      notifyListeners();
      print("search error : $e");
    }
  }

  //! add request
  bool isRequestLoading = false;
  onAddRequest(context) async {
    isRequestLoading = true;
    notifyListeners();
    final data = {
      "title": titleController.text,
      "message": descreptionController.text
    };
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post,
          url: sentRequest,
          data: FormData.fromMap(data));
      if (response != null) {
        if (response.data["status"]) {
          titleController.clear();
          descreptionController.clear();
          Fluttertoast.showToast(msg: response.data["message"]);
          pop(context);
          isRequestLoading = false;
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: "something went wrong");
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      print("login error : $e");
    }
  }

  //! addImage

  bool isAddImage = false;
  onAddImage(context, projectID, stageID, image) async {
    isAddImage = true;
    notifyListeners();
    final data = {
      "project_id": projectID,
      "stage_id": stageID,
      "images": image
    };
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post, url: addImage, data: FormData.fromMap(data));
      if (response != null) {
        isAddImage = false;
        notifyListeners();
        if (response.data["status"]) {
          Fluttertoast.showToast(msg: response.data["message"]);
          imageFilesList.clear();
          imageListString.clear();
          titleController.clear();
          notifyListeners();
          pop(context);
        } else {
          Fluttertoast.showToast(msg: "something went wrong");
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      isAddImage = false;
      notifyListeners();
      print("login error : $e");
    }
  }

  //! add expense

  bool isAddExpense = false;
  onAddEXpense(context, stageID, doc, title, totalExpense, date, catID) async {
    // isAddExpense = true;
    // notifyListeners();
    final converteddate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTimeOG.toString()));
    final data = {
      "stage_id": stageID,
      "documents": await MultipartFile.fromFile(doc),
      "title": title,
      "total_expanse": totalExpense,
      "date": converteddate,
      "cat_id": catID
    };
    print(data);
    try {
      final Response? response = await ApiService.apiMethodSetup(
          method: apiMethod.post,
          url: addExpenseAPI,
          data: FormData.fromMap(data));
      if (response != null) {
        isAddExpense = false;
        notifyListeners();
        if (response.data["status"]) {
          Fluttertoast.showToast(msg: response.data["message"]);
          imageFilesList.clear();
          imageListString.clear();
          titleController.clear();
          notifyListeners();
          pop(context);
        } else {
          Fluttertoast.showToast(msg: "something went wrong");
        }

        print("response : ${response.data}");
      }
    } catch (e) {
      isAddExpense = false;
      notifyListeners();
      print("login error : $e");
    }
  }

  final _random = Random();
  int i = 0;
  loadRandomImage() {
    i = _random.nextInt(imageListString.length);
    print(i);
    notifyListeners();
  }

  //! projectDetailsByID
  ProjectModel? projectModel;
  bool isProjectDetailsLoading = false;
  List<StagesModel> stagesList = [];
  List<Category> stagesNameList = [];

  projectDetailsByID(id) async {
    isProjectDetailsLoading = true;
    notifyListeners();
    final data = {"id": id};

    Response? response = await ApiService.apiMethodSetup(
        method: apiMethod.post,
        url: projectDetailsAPI,
        data: FormData.fromMap(data));
    if (response != null) {
      isProjectDetailsLoading = false;
      notifyListeners();
      notifyListeners();
      if (response.data["status"]) {
        projectModel = ProjectModel.fromJson(response.data["Project"]);
        final encodedStages = jsonEncode(response.data["stages"]);
        stagesList = stagesModelFromJson(encodedStages);
        stagesList
            .map(
              (e) => stagesNameList.add(Category(id: e.id, title: e.name)),
            )
            .toList();

        notifyListeners();
        print(projectModel?.name);
        print("total Stages : ${stagesList.length}");
        print("total Stages name : ${stagesNameList.length}");
      } else {}
    }
  }

  //! expense list api
  List<ExpenseModel> expenseList = [];
  bool isExpenseLoading = false;
  fetchExpenseList(stageID, catID) async {
    isExpenseLoading = true;
    notifyListeners();
    final data = {"stage_id": stageID, "cat_id": catID};
    print("expense list data : $data");
    Response? response = await ApiService.apiMethodSetup(
        method: apiMethod.post,
        url: expenseListAPI,
        data: FormData.fromMap(data));
    if (response != null) {
      checkCategoryStatus(catID);
      isExpenseLoading = false;
      notifyListeners();
      if (response.data["status"]) {
        final encodedData = jsonEncode(response.data["expanses"]);
        expenseList = expenseModelFromJson(encodedData);

        notifyListeners();
        print("expenseList : ${expenseList.length}");
      }
    }
  }

  //! checkCategoryStatus func
  String categoryName = "";
  int categoryID = 0;
  checkCategoryStatus(catID) async {
    switch (catID) {
      case 1:
        categoryName = "Salary";
        categoryID = 1;
        break;

      case 2:
        categoryName = "Purchase";
        categoryID = 2;
        break;

      case 3:
        categoryName = "Rent";
        categoryID = 3;
        break;
      case 4:
        categoryName = "Wages";
        categoryID = 4;
        break;
      case 5:
        categoryName = "Machinery";
        categoryID = 5;
        break;
      case 6:
        categoryName = "Local Rent";
        categoryID = 6;
        break;
      case 7:
        categoryName = "Others";
        categoryID = 7;
        break;
      default:
        categoryName = "Select Category";
    }
    notifyListeners();
    print("categoryName : $categoryName");
  }

  //! change stage status

  onChnageStatusAPI(id, status) async {
    final data = {"id": id, "status": status};
    Response? response = await ApiService.apiMethodSetup(
        method: apiMethod.post,
        url: changeStatusAPI,
        data: FormData.fromMap(data));
    if (response != null) {
      notifyListeners();
      if (response.data["status"]) {
        Fluttertoast.showToast(msg: response.data["message"]);

        notifyListeners();
        print("expenseList : ${expenseList.length}");
      }
    }
  }
}
