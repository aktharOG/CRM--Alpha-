// To parse this JSON data, do
//
//     final stagesModel = stagesModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<StagesModel> stagesModelFromJson(String str) => List<StagesModel>.from(
    json.decode(str).map((x) => StagesModel.fromJson(x)));

String stagesModelToJson(List<StagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StagesModel {
  int id;
  String name;
  String stageCurrency;
  String stageBudget;
  // String startDate;
  // String endDate;
  int stageStatus;
  bool isActive;
  String createdAt;
  String updatedAt;
  int project;
  int employer;
  List<ImageM> images;
  List<dynamic> expanses;
  bool isExpanded;
  ExpenseCategoryTotal expenseCategoryTotal;
  String shortdescription;

  StagesModel(
      {required this.id,
      required this.name,
      required this.stageCurrency,
      required this.stageBudget,
      // required this.startDate,
      // required this.endDate,
      required this.stageStatus,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      required this.project,
      required this.employer,
      required this.images,
      required this.expanses,
      required this.isExpanded,
      required this.expenseCategoryTotal,
      required this.shortdescription});

  factory StagesModel.fromJson(Map<String, dynamic> json) => StagesModel(
      id: json["id"],
      name: json["name"],
      stageCurrency: json["stage_currency"],
      stageBudget: json["stage_budget"],
      // startDate: DateFormat('dd-MM-yyyy')
      //     .format(DateTime.parse(json["start_date"].toString())),
      // endDate: DateFormat('dd-MM-yyyy')
      //     .format(DateTime.parse(json["end_date"].toString())),
      stageStatus: json["stage_status"],
      isActive: json["is_active"],
      createdAt: DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(json["created_at"].toString())),
      updatedAt: DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(json["updated_at"].toString())),
      project: json["project"],
      employer: json["employer"],
      images: List<ImageM>.from(json["images"].map((x) => ImageM.fromJson(x))),
      expanses: List<dynamic>.from(json["expanses"].map((x) => x)),
      isExpanded: json["is_expaired"] ?? false,
      expenseCategoryTotal:
          expenseCategoryTotalFromJson(jsonEncode(json["category_totals"])),
      shortdescription: json["short_description"] ?? "short descreption");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stage_currency": stageCurrency,
        "stage_budget": stageBudget,
        // "start_date": startDate,
        // "end_date": endDate,
        "stage_status": stageStatus,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "project": project,
        "employer": employer,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "expanses": List<dynamic>.from(expanses.map((x) => x)),
        "is_expaired": isExpanded,
        "category_totals": expenseCategoryTotal,
        "short_description": shortdescription
      };
}

class ImageM {
  int id;
  String image;
  bool isActive;
  String createdAt;
  String updatedAt;
  int project;
  int stage;

  ImageM({
    required this.id,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.project,
    required this.stage,
  });

  factory ImageM.fromJson(Map<String, dynamic> json) => ImageM(
        id: json["id"] ?? 0,
        image: json["image"] ?? '',
        isActive: json["is_active"] ?? false,
        createdAt: json["created_at"] ?? "03-04-2023",
        updatedAt: json["updated_at"] ?? "03-04-2023",
        project: json["project"] ?? 1,
        stage: json["stage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "project": project,
        "stage": stage,
      };
}

// To parse this JSON data, do
//
//     final expenseCategoryTotal = expenseCategoryTotalFromJson(jsonString);

ExpenseCategoryTotal expenseCategoryTotalFromJson(String str) =>
    ExpenseCategoryTotal.fromJson(json.decode(str));

String expenseCategoryTotalToJson(ExpenseCategoryTotal data) =>
    json.encode(data.toJson());

class ExpenseCategoryTotal {
  double salary;
  double purchases;
  double rent;
  double wages;
  double machinery;
  double localRent;
  double others;

  ExpenseCategoryTotal({
    required this.salary,
    required this.purchases,
    required this.rent,
    required this.wages,
    required this.machinery,
    required this.localRent,
    required this.others,
  });

  factory ExpenseCategoryTotal.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryTotal(
        salary: double.parse(json["Salary"].toString()),
        purchases: double.parse(json["Purchases"].toString()),
        rent: double.parse(json["Rent"].toString()),
        wages: double.parse(json["Wages"].toString()),
        machinery: double.parse(json["Machinery"].toString()),
        localRent: double.parse(json["Local Rent"].toString()),
        others: double.parse(json["Others"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "Salary": salary,
        "Purchases": purchases,
        "Rent": rent,
        "Wages": wages,
        "Machinery": machinery,
        "Local Rent": localRent,
        "Others": others,
      };
}
